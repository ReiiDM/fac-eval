<?php
// Quick mail test — run this in browser to see detailed SMTP errors
// DELETE THIS FILE after testing!

require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/config/app.php';
require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/functions.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;

$mail = new PHPMailer(true);

try {
    $mail->isSMTP();
    $mail->SMTPDebug  = SMTP::DEBUG_SERVER; // Show detailed debug output
    $mail->Host       = getSetting('mail_host', 'smtp.gmail.com');
    $mail->SMTPAuth   = true;
    $mail->Username   = getSetting('mail_username', '');
    $mail->Password   = str_replace(' ', '', getSetting('mail_password', ''));
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = (int)getSetting('mail_port', '587');

    $fromEmail = getSetting('mail_from_email', '');
    if (empty($fromEmail)) $fromEmail = getSetting('mail_username', '');
    
    $mail->setFrom($fromEmail, 'Test');
    $mail->addAddress($fromEmail); // Send to self

    $mail->isHTML(true);
    $mail->Subject = 'Test from Faculty Eval System';
    $mail->Body    = '<h3>It works!</h3>';

    echo "<pre>";
    echo "Host: " . $mail->Host . "\n";
    echo "Port: " . $mail->Port . "\n";
    echo "Username: " . $mail->Username . "\n";
    echo "Password length: " . strlen($mail->Password) . " chars\n";
    echo "---\n";

    $mail->send();
    echo "\n\n✅ EMAIL SENT SUCCESSFULLY!";
} catch (Exception $e) {
    echo "\n\n❌ FAILED: " . $mail->ErrorInfo;
}
echo "</pre>";
