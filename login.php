<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/functions.php';

// Already logged in — redirect to dashboard
if (isLoggedIn()) {
    redirectByRole(currentRole());
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');

    if (empty($username) || empty($password)) {
        $error = 'Please enter your username and password.';
    } else {
        $pdo  = getDB();
        $stmt = $pdo->prepare(
            "SELECT u.* 
             FROM users u 
             LEFT JOIN faculty f ON f.user_id = u.id 
             LEFT JOIN students s ON s.user_id = u.id 
             WHERE (u.username = ? OR u.email = ? OR f.employee_no = ? OR s.student_no = ?) 
               AND u.is_active = 1 
             LIMIT 1"
        );
        $stmt->execute([$username, $username, $username, $username]);
        $user = $stmt->fetch();

        if ($user && verifyPassword($password, $user['password'])) {
            loginUser($user);

            // Redirect to change password if first login
            if ($user['first_login'] == 1) {
                header('Location: ' . BASE_URL . '/change_password.php');
                exit;
            }

            redirectByRole($user['role']);
        } else {
            $error = 'Invalid username or password.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — <?= APP_NAME ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= BASE_URL ?>/assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100" style="background: linear-gradient(135deg, #0D0B61 0%, #1a1878 50%, #2d2a9e 100%);">

<div class="container py-5">
    <div class="login-card card border-0 shadow p-4 p-md-5">

        <!-- Logo / Header -->
        <div class="text-center mb-4">
            <img src="<?= BASE_URL ?>/assets/img/school_logo.jpg" alt="School Logo" width="80" height="80" class="rounded-circle shadow mb-3" style="object-fit:cover;">
            <h5 class="fw-bold mb-1"><?= APP_NAME ?></h5>
            <small class="text-muted"><?= SCHOOL_NAME ?></small>
        </div>

        <!-- Error Alert -->
        <?php if ($error): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i><?= e($error) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <!-- Login Form -->
        <form method="POST" action="" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Username or Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control" id="username" name="username"
                           value="<?= e($_POST['username'] ?? '') ?>"
                           placeholder="Enter username or email" required autofocus>
                </div>
            </div>

            <div class="mb-4">
                <div class="d-flex justify-content-between align-items-center mb-1">
                    <label for="password" class="form-label fw-semibold mb-0">Password</label>
                    <a href="<?= BASE_URL ?>/forgot_password.php" class="text-primary text-decoration-none small">Forgot password?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter password" required>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                        <i class="bi bi-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
            </button>
        </form>

        <div class="text-center mt-4">
            <small class="text-muted">
                New student? <a href="<?= BASE_URL ?>/register.php" class="text-primary text-decoration-none fw-semibold">Register Online Here</a>
            </small>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function () {
        const pwd  = document.getElementById('password');
        const icon = document.getElementById('toggleIcon');
        if (pwd.type === 'password') {
            pwd.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            pwd.type = 'password';
            icon.className = 'bi bi-eye';
        }
    });

    // Auto-dismiss alerts
    document.querySelectorAll('.alert-dismissible').forEach(a => {
        setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 5000);
    });
</script>
</body>
</html>
