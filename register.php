<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/functions.php';

$pdo = getDB();

// Validate token or fallback to department selection
$token = trim($_GET['token'] ?? '');
$error = '';
$tokenErrorType = ''; // 'invalid', 'disabled', 'expired', 'none'
$success = false;
$qrData = null;

$activeSem = getActiveSemester();

if (!empty($token)) {
    $stmt = $pdo->prepare(
        "SELECT qr.*, d.name as dept_name, d.code as dept_code,
                s.semester_no, ay.year_label
         FROM registration_qr_codes qr
         JOIN departments d ON d.id = qr.department_id
         JOIN semesters s ON s.id = qr.semester_id
         JOIN academic_years ay ON ay.id = s.academic_year_id
         WHERE qr.token = ?"
    );
    $stmt->execute([$token]);
    $qrData = $stmt->fetch();

    if (!$qrData) {
        $error = 'Invalid registration link. The token could not be verified.';
        $tokenErrorType = 'invalid';
    } elseif (!$qrData['is_active']) {
        $error = 'This registration link has been temporarily disabled by the administrator.';
        $tokenErrorType = 'disabled';
    } elseif (strtotime($qrData['expires_at']) < time()) {
        $error = 'This registration QR code expired on ' . date('M d, Y h:i A', strtotime($qrData['expires_at'])) . '.';
        $tokenErrorType = 'expired';
    }
} else {
    $tokenErrorType = 'none';
}

// Manual registration fallback mode
$manualMode = isset($_GET['mode']) && $_GET['mode'] === 'manual';
$allowManual = (getSetting('allow_manual_registration', '1') == '1');

// Fetch all active departments for manual selection
$allDepts = $pdo->query("SELECT id, name, code FROM departments WHERE is_active = 1 ORDER BY name")->fetchAll();

$selectedDeptId = (int)($_POST['manual_dept_id'] ?? ($_GET['dept_id'] ?? ($qrData['department_id'] ?? 0)));

// If in manual mode and department selected, load courses for that department
$courses = [];
if ($qrData && !$manualMode) {
    $stmt = $pdo->prepare("SELECT id, name, code FROM courses WHERE department_id = ? AND is_active = 1 ORDER BY name");
    $stmt->execute([$qrData['department_id']]);
    $courses = $stmt->fetchAll();
} elseif ($selectedDeptId > 0) {
    $stmt = $pdo->prepare("SELECT id, name, code FROM courses WHERE department_id = ? AND is_active = 1 ORDER BY name");
    $stmt->execute([$selectedDeptId]);
    $courses = $stmt->fetchAll();
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $targetDeptId = $qrData ? (int)$qrData['department_id'] : (int)($_POST['manual_dept_id'] ?? 0);
    $targetSemId  = $qrData ? (int)$qrData['semester_id'] : ($activeSem['id'] ?? 0);
    $qrCodeId     = $qrData ? (int)$qrData['id'] : null;

    $lastName      = trim($_POST['last_name'] ?? '');
    $firstName     = trim($_POST['first_name'] ?? '');
    $middleInitial = trim($_POST['middle_initial'] ?? '');

    // Combine into full name: "Last Name, First Name M."
    $fullName = $lastName . ', ' . $firstName;
    if (!empty($middleInitial)) {
        $fullName .= ' ' . strtoupper(trim($middleInitial, '.')) . '.';
    }

    $dob         = $_POST['date_of_birth'] ?? '';
    $gender      = $_POST['gender'] ?? '';
    $contactNo   = trim($_POST['contact_no'] ?? '');
    $email       = trim($_POST['email'] ?? '');
    $address         = trim($_POST['address'] ?? '');
    $username        = trim($_POST['username'] ?? '');
    $password        = $_POST['password'] ?? '';
    $confirmPassword = $_POST['confirm_password'] ?? '';
    $yearLevel       = (int)($_POST['year_level'] ?? 0);
    $course          = trim($_POST['course'] ?? '');
    $studentType     = $_POST['student_type'] ?? 'regular';

    // Validation
    if ($targetDeptId <= 0 || $targetSemId <= 0) {
        $error = 'Please select a valid department and ensure an active semester exists.';
    } elseif (empty($lastName) || empty($firstName) || empty($dob) || empty($gender) || empty($contactNo) ||
        empty($email) || empty($address) || empty($username) || empty($password) || $yearLevel <= 0 || empty($course)) {
        $error = 'Please fill in all required fields marked with an asterisk (*).';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'Please enter a valid email address.';
    } elseif (strlen($username) < 4) {
        $error = 'Username must be at least 4 characters long.';
    } elseif (!preg_match('/^[a-zA-Z0-9_.-]+$/', $username)) {
        $error = 'Username can only contain alphanumeric characters, underscores, hyphens, and periods.';
    } elseif (strlen($password) < 6) {
        $error = 'Password must be at least 6 characters long.';
    } elseif ($password !== $confirmPassword) {
        $error = 'Passwords do not match.';
    } else {
        // 1. Check if an active user account already exists with this email or username
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM users WHERE email = ? OR username = ?");
        $stmt->execute([$email, $username]);
        if ($stmt->fetchColumn() > 0) {
            $error = 'An account with this email or username already exists. Please choose a different username or sign in.';
        }

        // 2. Check duplicate email or username in pending/accepted requests
        if (!$error) {
            $check = $pdo->prepare(
                "SELECT COUNT(*) FROM student_registration_requests
                 WHERE (email = ? OR username = ?) AND status IN ('pending', 'accepted')"
            );
            $check->execute([$email, $username]);
            if ($check->fetchColumn() > 0) {
                $error = 'A registration request with this email or username already exists and is pending review.';
            }
        }

        // 3. Check duplicate full_name + DOB combination
        if (!$error) {
            $checkName = $pdo->prepare(
                "SELECT COUNT(*) FROM student_registration_requests
                 WHERE full_name = ? AND date_of_birth = ? AND status IN ('pending', 'accepted')"
            );
            $checkName->execute([$fullName, $dob]);
            if ($checkName->fetchColumn() > 0) {
                $error = 'A registration for this student name and date of birth is already on file.';
            }
        }
    }

    if (!$error) {
        $hashedPassword = hashPassword($password);
        $stmt = $pdo->prepare(
            "INSERT INTO student_registration_requests
             (qr_code_id, department_id, semester_id, full_name, date_of_birth, gender,
              contact_no, email, address, username, password, year_level, course, student_type)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $qrCodeId, $targetDeptId, $targetSemId,
            $fullName, $dob, $gender, $contactNo, $email, $address,
            $username, $hashedPassword, $yearLevel, $course, $studentType
        ]);

        if ($qrCodeId) {
            $pdo->prepare("UPDATE registration_qr_codes SET scan_count = scan_count + 1 WHERE id = ?")
                ->execute([$qrCodeId]);
        }

        // Notify Department Admins & Superadmins
        notifyDepartmentAdmins(
            $targetDeptId,
            'New Student Registration',
            "{$fullName} ({$course} - Year {$yearLevel}) has submitted a registration request.",
            'welcome'
        );

        $success = true;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration — <?= SCHOOL_NAME ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= BASE_URL ?>/assets/css/style.css" rel="stylesheet">
</head>
<body style="background: linear-gradient(180deg, #0D0B61 0%, #f0f2f8 35%); min-height: 100vh;">

<div class="container py-4" style="max-width: 700px;">
    <div class="register-card card border-0 shadow p-4 p-md-5">

        <!-- Header -->
        <div class="text-center mb-4">
            <img src="<?= BASE_URL ?>/assets/img/school_logo.jpg" alt="School Logo" width="75" height="75" class="rounded-circle shadow mb-2" style="object-fit:cover;">
            <h5 class="fw-bold mb-1"><?= SCHOOL_NAME ?></h5>
            <small class="text-muted">Student Online Registration</small>
        </div>

        <?php if ($success): ?>
            <!-- Success State -->
            <div class="text-center py-4">
                <div class="text-success mb-3">
                    <i class="bi bi-check-circle-fill" style="font-size: 3.5rem;"></i>
                </div>
                <h4 class="fw-bold text-success">Registration Submitted!</h4>
                <p class="text-muted mt-2">
                    Your registration has been submitted successfully.<br>
                    Your department administrator will review your application. Once approved, your login credentials will be generated and emailed to your address.
                </p>
                <div class="alert alert-info small mt-3 text-start">
                    <div class="mb-1"><i class="bi bi-person me-1"></i> Student: <strong><?= e($fullName ?? '') ?></strong></div>
                    <div class="mb-1"><i class="bi bi-envelope me-1"></i> Email: <strong><?= e($email ?? '') ?></strong></div>
                    <div><i class="bi bi-building me-1"></i> Status: <span class="badge bg-warning text-dark">Pending Approval</span></div>
                </div>
                <a href="<?= BASE_URL ?>/login.php" class="btn btn-outline-primary mt-3">
                    <i class="bi bi-arrow-left me-1"></i>Return to Login
                </a>
            </div>

        <?php elseif ($tokenErrorType && $tokenErrorType !== 'none' && !$manualMode): ?>
            <!-- Error State for invalid / expired QR -->
            <div class="text-center py-4">
                <div class="text-danger mb-3">
                    <i class="bi bi-exclamation-octagon-fill" style="font-size: 3.5rem;"></i>
                </div>
                <h5 class="fw-bold text-danger"><?= e($error) ?></h5>
                <p class="text-muted small mt-2">
                    The registration QR code you scanned is invalid, expired, or deactivated.
                </p>
                <?php if ($allowManual): ?>
                    <div class="mt-4">
                        <a href="?mode=manual" class="btn btn-primary">
                            <i class="bi bi-pencil-square me-1"></i>Register Manually (Select Department)
                        </a>
                    </div>
                <?php endif; ?>
                <div class="mt-3">
                    <a href="<?= BASE_URL ?>/login.php" class="text-decoration-none small text-muted">
                        <i class="bi bi-arrow-left me-1"></i>Back to Sign In
                    </a>
                </div>
            </div>

        <?php elseif ($tokenErrorType === 'none' && !$manualMode && !$qrData): ?>
            <!-- Landing without QR token -->
            <div class="text-center py-4">
                <div class="text-primary mb-3">
                    <i class="bi bi-qr-code-scan" style="font-size: 3.5rem;"></i>
                </div>
                <h5 class="fw-bold">Scan QR or Register Manually</h5>
                <p class="text-muted small">
                    Please scan the registration QR code provided by your department, or proceed with manual department selection below.
                </p>
                <?php if ($allowManual): ?>
                    <a href="?mode=manual" class="btn btn-primary mt-2">
                        <i class="bi bi-card-checklist me-1"></i>Proceed to Registration Form
                    </a>
                <?php endif; ?>
                <div class="mt-3">
                    <a href="<?= BASE_URL ?>/login.php" class="text-decoration-none small text-muted">
                        <i class="bi bi-arrow-left me-1"></i>Already have an account? Sign In
                    </a>
                </div>
            </div>

        <?php else: ?>
            <!-- Registration Form (Valid QR or Manual Mode) -->
            <?php if ($qrData): ?>
                <div class="alert alert-primary small mb-4 d-flex align-items-center gap-2">
                    <i class="bi bi-qr-code fs-5"></i>
                    <div>
                        Registering for: <strong><?= e($qrData['dept_name']) ?></strong><br>
                        Term: <strong><?= e($qrData['year_label']) ?> — <?= semesterLabel((int)$qrData['semester_no']) ?></strong>
                    </div>
                </div>
            <?php else: ?>
                <div class="alert alert-info small mb-4">
                    <i class="bi bi-info-circle me-1"></i>
                    Manual Student Self-Registration
                    <?php if ($activeSem): ?>
                        — <strong><?= e($activeSem['year_label']) ?> <?= semesterLabel((int)$activeSem['semester_no']) ?></strong>
                    <?php endif; ?>
                </div>
            <?php endif; ?>

            <?php if ($error): ?>
                <div class="alert alert-danger d-flex align-items-center gap-2 mb-4" role="alert">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <div><?= e($error) ?></div>
                </div>
            <?php endif; ?>

            <form method="POST" novalidate>
                <?php if ($manualMode || !$qrData): ?>
                    <!-- Department Selection for Manual Mode -->
                    <div class="mb-4 p-3 bg-light rounded border">
                        <label class="form-label fw-semibold text-primary">
                            <i class="bi bi-building me-1"></i>Select Department <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" name="manual_dept_id" required onchange="window.location.href='?mode=manual&dept_id=' + this.value">
                            <option value="">Select your department</option>
                            <?php foreach ($allDepts as $d): ?>
                                <option value="<?= $d['id'] ?>" <?= $selectedDeptId == $d['id'] ? 'selected' : '' ?>>
                                    <?= e($d['code']) ?> — <?= e($d['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                <?php endif; ?>

                <!-- Personal Information -->
                <h6 class="fw-bold text-primary mb-3 border-bottom pb-2">
                    <i class="bi bi-person me-1"></i>Personal Information
                </h6>

                <div class="row">
                    <div class="col-12 col-sm-5 mb-3">
                        <label class="form-label fw-semibold">Last Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="last_name" required
                               value="<?= e($_POST['last_name'] ?? '') ?>" placeholder="e.g. Santos">
                    </div>
                    <div class="col-12 col-sm-5 mb-3">
                        <label class="form-label fw-semibold">First Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="first_name" required
                               value="<?= e($_POST['first_name'] ?? '') ?>" placeholder="e.g. Maria">
                    </div>
                    <div class="col-12 col-sm-2 mb-3">
                        <label class="form-label fw-semibold">M.I.</label>
                        <input type="text" class="form-control" name="middle_initial"
                               value="<?= e($_POST['middle_initial'] ?? '') ?>" placeholder="A" maxlength="2">
                    </div>
                </div>

                <div class="row">
                    <div class="col-6 mb-3">
                        <label class="form-label fw-semibold">Date of Birth <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" name="date_of_birth" required
                               value="<?= e($_POST['date_of_birth'] ?? '') ?>">
                    </div>
                    <div class="col-6 mb-3">
                        <label class="form-label fw-semibold">Gender <span class="text-danger">*</span></label>
                        <select class="form-select" name="gender" required>
                            <option value="">Select</option>
                            <option value="male" <?= ($_POST['gender'] ?? '') === 'male' ? 'selected' : '' ?>>Male</option>
                            <option value="female" <?= ($_POST['gender'] ?? '') === 'female' ? 'selected' : '' ?>>Female</option>
                            <option value="other" <?= ($_POST['gender'] ?? '') === 'other' ? 'selected' : '' ?>>Other</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                    <input type="tel" class="form-control" name="contact_no" required
                           value="<?= e($_POST['contact_no'] ?? '') ?>" placeholder="09XX-XXX-XXXX">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                    <input type="email" class="form-control" name="email" required
                           value="<?= e($_POST['email'] ?? '') ?>" placeholder="your.email@example.com">
                    <small class="text-muted">Account credentials will be sent to this email upon approval.</small>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Home Address <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="address" rows="2" required
                              placeholder="Street, Barangay, Municipality, Province"><?= e($_POST['address'] ?? '') ?></textarea>
                </div>

                <!-- Academic Information -->
                <h6 class="fw-bold text-primary mb-3 border-bottom pb-2 mt-4">
                    <i class="bi bi-mortarboard me-1"></i>Academic Information
                </h6>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Course / Program <span class="text-danger">*</span></label>
                    <select class="form-select" name="course" required>
                        <option value="">Select course</option>
                        <?php foreach ($courses as $c): ?>
                            <option value="<?= e($c['code']) ?>" <?= ($_POST['course'] ?? '') === $c['code'] ? 'selected' : '' ?>>
                                <?= e($c['code']) ?> — <?= e($c['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                    <?php if (empty($courses) && ($selectedDeptId > 0 || $qrData)): ?>
                        <small class="text-danger">No active courses found for this department.</small>
                    <?php endif; ?>
                </div>

                <div class="row">
                    <div class="col-6 mb-3">
                        <label class="form-label fw-semibold">Year Level <span class="text-danger">*</span></label>
                        <select class="form-select" name="year_level" required>
                            <option value="">Select</option>
                            <option value="1" <?= ($_POST['year_level'] ?? '') == '1' ? 'selected' : '' ?>>1st Year</option>
                            <option value="2" <?= ($_POST['year_level'] ?? '') == '2' ? 'selected' : '' ?>>2nd Year</option>
                            <option value="3" <?= ($_POST['year_level'] ?? '') == '3' ? 'selected' : '' ?>>3rd Year</option>
                            <option value="4" <?= ($_POST['year_level'] ?? '') == '4' ? 'selected' : '' ?>>4th Year</option>
                        </select>
                    </div>
                    <div class="col-6 mb-3">
                        <label class="form-label fw-semibold">Student Type <span class="text-danger">*</span></label>
                        <select class="form-select" name="student_type" required>
                            <option value="regular" <?= ($_POST['student_type'] ?? '') === 'regular' ? 'selected' : '' ?>>Regular</option>
                            <option value="irregular" <?= ($_POST['student_type'] ?? '') === 'irregular' ? 'selected' : '' ?>>Irregular</option>
                        </select>
                    </div>
                </div>

                <!-- Account Credentials -->
                <h6 class="fw-bold text-primary mb-3 border-bottom pb-2 mt-4">
                    <i class="bi bi-shield-lock me-1"></i>Account Credentials
                </h6>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Preferred Username <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" name="username" required
                               value="<?= e($_POST['username'] ?? '') ?>" placeholder="e.g. juan_delacruz" minlength="4" maxlength="50" autocomplete="username">
                    </div>
                    <small class="text-muted">Minimum 4 characters (letters, numbers, underscores, periods, hyphens).</small>
                </div>

                <div class="row">
                    <div class="col-12 col-md-6 mb-3">
                        <label class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="regPassword" name="password" required
                                   placeholder="Create password" minlength="6" autocomplete="new-password">
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('regPassword', this)">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                        <small class="text-muted">Minimum 6 characters.</small>
                    </div>
                    <div class="col-12 col-md-6 mb-3">
                        <label class="form-label fw-semibold">Confirm Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" class="form-control" id="regConfirmPassword" name="confirm_password" required
                                   placeholder="Repeat password" minlength="6" autocomplete="new-password">
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('regConfirmPassword', this)">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mt-3">
                    <i class="bi bi-send me-1"></i>Submit Registration
                </button>

                <div class="text-center mt-3">
                    <a href="<?= BASE_URL ?>/login.php" class="text-muted small text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i>Already registered? Sign In
                    </a>
                </div>

            </form>
        <?php endif; ?>

    </div>

    <div class="text-center mt-3">
        <small class="text-muted">&copy; <?= date('Y') ?> <?= SCHOOL_NAME ?></small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePasswordVisibility(fieldId, btn) {
    const field = document.getElementById(fieldId);
    if (!field) return;
    const icon = btn.querySelector('i');
    if (field.type === 'password') {
        field.type = 'text';
        if (icon) {
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        }
    } else {
        field.type = 'password';
        if (icon) {
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    }
}
</script>
</body>
</html>
