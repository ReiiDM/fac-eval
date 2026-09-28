<?php
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/includes/auth.php';

if (isLoggedIn()) {
    redirectByRole(currentRole());
}

header('Location: ' . BASE_URL . '/login.php');
exit;
