<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/functions.php';

$pdo = getDB();

$token   = trim($_GET['token'] ?? ($_POST['token'] ?? ''));
$otp     = trim($_GET['otp'] ?? ($_POST['otp'] ?? ''));
$error   = '';
$success = '';

$resetRecord = null;
if (!empty($token)) {
    $stmt = $pdo->prepare("SELECT pr.*, u.username, u.name, u.email FROM password_resets pr JOIN users u ON u.id = pr.user_id WHERE pr.token = ? AND pr.is_used = 0 AND pr.expires_at > NOW() LIMIT 1");
    $stmt->execute([$token]);
    $resetRecord = $stmt->fetch();
} elseif (!empty($otp)) {
    $stmt = $pdo->prepare("SELECT pr.*, u.username, u.name, u.email FROM password_resets pr JOIN users u ON u.id = pr.user_id WHERE pr.otp_code = ? AND pr.is_used = 0 AND pr.expires_at > NOW() LIMIT 1");
    $stmt->execute([$otp]);
    $resetRecord = $stmt->fetch();
}

if (!$resetRecord && $_SERVER['REQUEST_METHOD'] !== 'POST') {
    $error = 'Invalid, expired, or already used password reset link. Please submit a new request.';
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $new     = $_POST['new_password'] ?? '';
    $confirm = $_POST['confirm_password'] ?? '';

    if (!$resetRecord) {
        $error = 'Invalid or expired password reset session. Please request a new link.';
    } elseif (empty($new) || empty($confirm)) {
        $error = 'All fields are required.';
    } elseif (strlen($new) < 8) {
        $error = 'New password must be at least 8 characters long.';
    } elseif ($new !== $confirm) {
        $error = 'Passwords do not match.';
    } else {
        // Update user password and mark reset token used
        $hashed = hashPassword($new);
        $pdo->prepare("UPDATE users SET password = ?, first_login = 0 WHERE id = ?")
            ->execute([$hashed, $resetRecord['user_id']]);

        $pdo->prepare("UPDATE password_resets SET is_used = 1 WHERE id = ?")
            ->execute([$resetRecord['id']]);

        $success = 'Your password has been successfully reset! You can now log in with your new password.';
        header('Refresh: 2; url=' . BASE_URL . '/login.php');
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password — <?= APP_NAME ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= BASE_URL ?>/assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100" style="background: linear-gradient(135deg, #0D0B61 0%, #1a1878 50%, #2d2a9e 100%);">

<div class="container py-5">
    <div class="login-card card border-0 shadow p-4 p-md-5" style="max-width: 480px; margin: auto;">

        <div class="text-center mb-4">
            <img src="<?= BASE_URL ?>/assets/img/school_logo.jpg" alt="School Logo" width="72" height="72" class="rounded-circle shadow mb-3" style="object-fit:cover;">
            <h5 class="fw-bold mb-1">Set New Password</h5>
            <?php if ($resetRecord): ?>
                <small class="text-muted">Account: <strong><?= e($resetRecord['username']) ?></strong> (<?= e($resetRecord['name']) ?>)</small>
            <?php else: ?>
                <small class="text-muted">Faculty Evaluation System</small>
            <?php endif; ?>
        </div>

        <?php if ($error): ?>
            <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i><?= e($error) ?></div>
            <div class="text-center mt-3">
                <a href="<?= BASE_URL ?>/forgot_password.php" class="btn btn-outline-primary btn-sm">
                    <i class="bi bi-arrow-repeat me-1"></i>Request New Reset Link
                </a>
            </div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i><?= e($success) ?></div>
            <div class="text-center mt-3">
                <a href="<?= BASE_URL ?>/login.php" class="btn btn-primary fw-semibold">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Proceed to Sign In
                </a>
            </div>
        <?php elseif ($resetRecord): ?>
            <form method="POST" action="">
                <input type="hidden" name="token" value="<?= e($token) ?>">
                <input type="hidden" name="otp" value="<?= e($otp) ?>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" name="new_password" id="new_password"
                               minlength="8" required placeholder="At least 8 characters">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Confirm New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control" name="confirm_password" id="confirm_password"
                               required placeholder="Repeat new password">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                    <i class="bi bi-check-lg me-2"></i>Reset & Update Password
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
