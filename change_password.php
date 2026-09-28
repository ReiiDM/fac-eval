<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/functions.php';

requireLogin();

$error   = '';
$success = '';

$isFirstLogin = ($_SESSION['first_login'] ?? 0) == 1;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current  = $_POST['current_password'] ?? '';
    $new      = $_POST['new_password'] ?? '';
    $confirm  = $_POST['confirm_password'] ?? '';

    if ((!$isFirstLogin && empty($current)) || empty($new) || empty($confirm)) {
        $error = 'All fields are required.';
    } elseif (strlen($new) < 8) {
        $error = 'New password must be at least 8 characters.';
    } elseif ($new !== $confirm) {
        $error = 'New passwords do not match.';
    } else {
        $pdo  = getDB();
        $stmt = $pdo->prepare("SELECT password FROM users WHERE id = ?");
        $stmt->execute([currentUserId()]);
        $user = $stmt->fetch();

        if (!$isFirstLogin && (!$user || !verifyPassword($current, $user['password']))) {
            $error = 'Current password is incorrect.';
        } else {
            $hashed = hashPassword($new);
            $pdo->prepare("UPDATE users SET password = ?, first_login = 0 WHERE id = ?")
                ->execute([$hashed, currentUserId()]);

            $_SESSION['first_login'] = 0;
            $success = 'Password changed successfully.';

            // Redirect to dashboard after 2 seconds
            header('Refresh: 2; url=' . BASE_URL . '/' . currentRole() . '/dashboard.php');
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password — <?= APP_NAME ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= BASE_URL ?>/assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100" style="background: linear-gradient(135deg, #0D0B61 0%, #1a1878 50%, #2d2a9e 100%);">

<div class="container py-5">
    <div class="login-card card border-0 shadow p-4 p-md-5">

        <div class="text-center mb-4">
            <img src="<?= BASE_URL ?>/assets/img/school_logo.jpg" alt="School Logo" width="72" height="72" class="rounded-circle shadow mb-3" style="object-fit:cover;">
            <h5 class="fw-bold mb-1"><?= $isFirstLogin ? 'Set Your New Password' : 'Change Password' ?></h5>
            <small class="text-muted">
                <?= $isFirstLogin ? 'Your password was reset. Please create a new private password to continue.' : 'Enter your current password and choose a new one.' ?>
            </small>
        </div>

        <?php if ($error): ?>
            <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i><?= e($error) ?></div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i><?= e($success) ?> Redirecting...</div>
        <?php endif; ?>

        <form method="POST" action="">
            <?php if (!$isFirstLogin): ?>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Current Password</label>
                    <input type="password" class="form-control" name="current_password" required>
                </div>
            <?php endif; ?>
            <div class="mb-3">
                <label class="form-label fw-semibold">New Password</label>
                <input type="password" class="form-control" name="new_password"
                       minlength="8" required placeholder="Minimum 8 characters">
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Confirm New Password</label>
                <input type="password" class="form-control" name="confirm_password" required placeholder="Repeat new password">
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                <i class="bi bi-check-lg me-2"></i><?= $isFirstLogin ? 'Save & Continue to Dashboard' : 'Update Password' ?>
            </button>
        </form>

        <?php if (!$isFirstLogin): ?>
            <div class="text-center mt-3">
                <a href="<?= BASE_URL ?>/<?= currentRole() ?>/dashboard.php" class="text-muted small">Cancel</a>
            </div>
        <?php endif; ?>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
