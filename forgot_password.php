<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/functions.php';

// If already logged in, redirect
if (isLoggedIn()) {
    redirectByRole(currentRole());
}

$error   = '';
$success = '';
$resetLink = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $identifier = trim($_POST['identifier'] ?? '');

    if (empty($identifier)) {
        $error = 'Please enter your username, student ID, or registered email.';
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
        $stmt->execute([$identifier, $identifier, $identifier, $identifier]);
        $user = $stmt->fetch();

        if ($user) {
            $token   = bin2hex(random_bytes(32));
            $otpCode = sprintf('%06d', mt_rand(100000, 999999));
            $expires = date('Y-m-d H:i:s', strtotime('+30 minutes'));

            // Invalidate any previous unused tokens for this user
            $pdo->prepare("UPDATE password_resets SET is_used = 1 WHERE user_id = ? AND is_used = 0")
                ->execute([$user['id']]);

            // Insert new reset request
            $stmt = $pdo->prepare(
                "INSERT INTO password_resets (user_id, token, otp_code, expires_at, is_used) VALUES (?, ?, ?, ?, 0)"
            );
            $stmt->execute([$user['id'], $token, $otpCode, $expires]);

            $resetUrl = BASE_URL . '/reset_password.php?token=' . $token;

            // Try sending email if mail is configured
            $emailSent = false;
            if (file_exists(__DIR__ . '/vendor/autoload.php')) {
                require_once __DIR__ . '/vendor/autoload.php';
                require_once __DIR__ . '/config/mail.php';

                try {
                    $mail = new PHPMailer\PHPMailer\PHPMailer(true);
                    $mail->isSMTP();
                    $mail->Host       = MAIL_HOST;
                    $mail->SMTPAuth   = true;
                    $mail->Username   = MAIL_USERNAME;
                    $mail->Password   = MAIL_PASSWORD;
                    $mail->SMTPSecure = MAIL_ENCRYPTION;
                    $mail->Port       = MAIL_PORT;

                    $mail->setFrom(MAIL_FROM_EMAIL, MAIL_FROM_NAME);
                    $mail->addAddress($user['email'], $user['name']);

                    $mail->isHTML(true);
                    $mail->Subject = 'Password Reset Request — ' . APP_NAME;
                    $mail->Body    = "
                        <div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e2e8f0; border-radius: 10px;'>
                            <h3 style='color: #0D0B61;'>Password Reset Request</h3>
                            <p>Hello <strong>" . htmlspecialchars($user['name']) . "</strong>,</p>
                            <p>We received a request to reset your password for your <strong>" . APP_NAME . "</strong> account.</p>
                            <p>Your 6-digit Verification Code is:</p>
                            <div style='background: #f1f5f9; padding: 15px; font-size: 24px; font-weight: bold; letter-spacing: 4px; text-align: center; color: #0D0B61; border-radius: 8px;'>
                                " . $otpCode . "
                            </div>
                            <p style='margin-top: 20px;'>Or click the button below to set a new password directly:</p>
                            <p style='text-align: center; margin: 25px 0;'>
                                <a href='" . $resetUrl . "' style='background: #0D0B61; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; font-weight: bold; display: inline-block;'>Reset My Password</a>
                            </p>
                            <p style='font-size: 12px; color: #64748b;'>This link and code will expire in 30 minutes. If you did not request a password reset, please ignore this email.</p>
                        </div>
                    ";

                    $mail->send();
                    $emailSent = true;
                } catch (Exception $e) {
                    $emailSent = false;
                }
            }

            if ($emailSent) {
                $success = "A password reset link and verification code have been sent to <strong>" . htmlspecialchars($user['email']) . "</strong>. Please check your inbox.";
            } else {
                // If mail is not configured or fails, provide direct self-service reset action
                $success = "Password reset request generated for <strong>" . htmlspecialchars($user['username']) . "</strong>.";
                $resetLink = $resetUrl;
            }
        } else {
            // For security, show error or generic response
            $error = 'No active account found with that username, student ID, or email address.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — <?= APP_NAME ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= BASE_URL ?>/assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100" style="background: linear-gradient(135deg, #0D0B61 0%, #1a1878 50%, #2d2a9e 100%);">

<div class="container py-5">
    <div class="login-card card border-0 shadow p-4 p-md-5" style="max-width: 480px; margin: auto;">

        <div class="text-center mb-4">
            <img src="<?= BASE_URL ?>/assets/img/school_logo.jpg" alt="School Logo" width="72" height="72" class="rounded-circle shadow mb-3" style="object-fit:cover;">
            <h5 class="fw-bold mb-1">Forgot Password</h5>
            <small class="text-muted">Enter your username, student number, or email to reset your password.</small>
        </div>

        <?php if ($error): ?>
            <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i><?= $error ?></div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="alert alert-success">
                <i class="bi bi-check-circle me-2"></i><?= $success ?>
            </div>
            <?php if ($resetLink): ?>
                <div class="card bg-light border-primary p-3 mb-4 text-center">
                    <p class="small text-muted mb-2">Click below to proceed to the secure password reset page:</p>
                    <a href="<?= $resetLink ?>" class="btn btn-primary fw-semibold">
                        <i class="bi bi-key me-1"></i>Set New Password Now
                    </a>
                </div>
            <?php endif; ?>
        <?php else: ?>
            <form method="POST" action="">
                <div class="mb-4">
                    <label class="form-label fw-semibold">Username, Student No, or Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" name="identifier"
                               value="<?= e($_POST['identifier'] ?? '') ?>"
                               placeholder="e.g. 2024-00001 or email" required autofocus>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                    <i class="bi bi-send me-2"></i>Request Password Reset
                </button>
            </form>
        <?php endif; ?>

        <div class="text-center mt-4">
            <a href="<?= BASE_URL ?>/login.php" class="text-muted text-decoration-none small">
                <i class="bi bi-arrow-left me-1"></i>Back to Sign In
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
