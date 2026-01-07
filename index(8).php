<?php
// Turn on error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// === CONFIGURATION ===
$config = [
    'db' => [
        'host' => 'localhost',
        'name' => 'kyhsqcgs_smcdb',
        'user' => 'kyhsqcgs_smcadmin',
        'pass' => '2025@AdminDb#'
    ],
    'payfast' => [
        'merchant_id' => '13248267',
        'merchant_key' => 'fy40apz2306qs',
        'passphrase' => '1989Passphrase',
        'mode' => 'sandbox' // Change to 'live' for production
    ],
    'smtp' => [
        'host' => 'das111.truehost.cloud',
        'user' => 'noreply@elbethuel.co.za',
        'pass' => '2026@NoReply#',
        'port' => 587,
        'from_email' => 'hi@elbethuel.co.za',
        'from_name' => 'EL Bethuel Molaadira'
    ],
    'notifications' => [
        'elbethuel@gmail.com',
        'info@secretmatchesclub.co.za',
        'hi@elbethuel.co.za'
    ],
    'whatsapp' => '27630225600',
    'site_email' => 'elbethuel@secretmatchesclub.co.za',
    'site_name' => 'EL Bethuel Molaadira',
    'site_url' => 'https://elbethuel.co.za'
];

// === CONSTANTS ===
define('SITE_NAME', $config['site_name']);
define('SITE_EMAIL', $config['site_email']);
define('WHATSAPP_NUMBER', $config['whatsapp']);
define('SITE_URL', $config['site_url']);

// === DATABASE CONNECTION ===
try {
    $pdo = new PDO(
        "mysql:host={$config['db']['host']};dbname={$config['db']['name']};charset=utf8mb4",
        $config['db']['user'],
        $config['db']['pass']
    );
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $db_connected = true;
} catch(PDOException $e) {
    $db_connected = false;
    $db_error = $e->getMessage();
    error_log("Database connection failed: " . $e->getMessage());
}

// === LOAD PHPMailer ===
require_once 'PHPMailer/src/PHPMailer.php';
require_once 'PHPMailer/src/SMTP.php';
require_once 'PHPMailer/src/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// === FUNCTIONS ===
function sendEmail($to, $subject, $body, $cc = [], $bcc = []) {
    global $config;
    
    try {
        $mail = new PHPMailer(true);
        
        // Server settings
        $mail->isSMTP();
        $mail->Host = $config['smtp']['host'];
        $mail->SMTPAuth = true;
        $mail->Username = $config['smtp']['user'];
        $mail->Password = $config['smtp']['pass'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = $config['smtp']['port'];
        
        // Recipients
        $mail->setFrom($config['smtp']['from_email'], $config['smtp']['from_name']);
        $mail->addAddress($to);
        
        // Add CC recipients
        foreach ($cc as $email) {
            $mail->addCC($email);
        }
        
        // Add BCC recipients
        foreach ($bcc as $email) {
            $mail->addBCC($email);
        }
        
        // Add default BCC to notification emails
        foreach ($config['notifications'] as $notification_email) {
            $mail->addBCC($notification_email);
        }
        
        // Content
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body = $body;
        $mail->AltBody = strip_tags($body);
        
        if ($mail->send()) {
            return true;
        } else {
            error_log("Email send failed: {$mail->ErrorInfo}");
            return false;
        }
    } catch (Exception $e) {
        error_log("PHPMailer exception: {$e->getMessage()}");
        return false;
    }
}

function generateBookingID() {
    return 'ELB' . date('Ymd') . strtoupper(substr(md5(uniqid()), 0, 6));
}

function saveBookingToDatabase($bookingData) {
    global $pdo;
    
    if (!$pdo) return false;
    
    try {
        $sql = "INSERT INTO bookings (
            booking_id, first_name, last_name, email, phone, 
            service_type, service_name, amount, message, status,
            created_at, ip_address
        ) VALUES (
            :booking_id, :first_name, :last_name, :email, :phone,
            :service_type, :service_name, :amount, :message, 'pending',
            NOW(), :ip_address
        )";
        
        $stmt = $pdo->prepare($sql);
        
        // Add IP address
        $bookingData['ip_address'] = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
        
        $stmt->execute($bookingData);
        
        return $pdo->lastInsertId();
    } catch(PDOException $e) {
        error_log("Database error saving booking: " . $e->getMessage());
        return false;
    }
}

function sendBookingNotification($bookingData) {
    global $config;
    
    $subject = "📅 New Booking: " . $bookingData['service_name'];
    
    // Admin notification email
    $adminBody = "
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background: #D4AF37; color: black; padding: 20px; text-align: center; border-radius: 10px 10px 0 0; }
            .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
            .info-box { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #D4AF37; }
            .label { font-weight: bold; color: #555; }
            .value { color: #333; }
        </style>
    </head>
    <body>
        <div class='container'>
            <div class='header'>
                <h1>✨ New Booking Received</h1>
            </div>
            <div class='content'>
                <h2>Booking Details</h2>
                <div class='info-box'>
                    <p><span class='label'>Booking ID:</span> <span class='value'>{$bookingData['booking_id']}</span></p>
                    <p><span class='label'>Customer:</span> <span class='value'>{$bookingData['first_name']} {$bookingData['last_name']}</span></p>
                    <p><span class='label'>Email:</span> <span class='value'>{$bookingData['email']}</span></p>
                    <p><span class='label'>Phone:</span> <span class='value'>{$bookingData['phone']}</span></p>
                    <p><span class='label'>Service:</span> <span class='value'>{$bookingData['service_name']}</span></p>
                    <p><span class='label'>Amount:</span> <span class='value'>R " . number_format($bookingData['amount'], 2) . "</span></p>
                    <p><span class='label'>Date:</span> <span class='value'>" . date('Y-m-d H:i:s') . "</span></p>
                </div>
            </div>
        </div>
    </body>
    </html>";
    
    // Send to all admin emails
    foreach ($config['notifications'] as $admin_email) {
        sendEmail($admin_email, $subject, $adminBody);
    }
    
    // Customer confirmation email
    $customerSubject = "✅ Booking Confirmed: " . $bookingData['service_name'];
    $customerBody = "
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background: #D4AF37; color: black; padding: 20px; text-align: center; border-radius: 10px 10px 0 0; }
            .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
            .booking-info { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #D4AF37; }
        </style>
    </head>
    <body>
        <div class='container'>
            <div class='header'>
                <h1>✨ Booking Confirmed!</h1>
            </div>
            <div class='content'>
                <p>Dear {$bookingData['first_name']},</p>
                
                <div class='booking-info'>
                    <h3>📋 Booking Details</h3>
                    <p><strong>Booking ID:</strong> {$bookingData['booking_id']}</p>
                    <p><strong>Service:</strong> {$bookingData['service_name']}</p>
                    <p><strong>Amount:</strong> R " . number_format($bookingData['amount'], 2) . "</p>
                    <p><strong>Date:</strong> " . date('F d, Y') . "</p>
                </div>
                
                <p><strong>📞 Contact:</strong></p>
                <p>WhatsApp: <a href='https://wa.me/" . WHATSAPP_NUMBER . "'>+27 63 022 5600</a></p>
                <p>Email: <a href='mailto:" . SITE_EMAIL . "'>{$config['site_email']}</a></p>
                
                <p style='margin-top: 30px;'><strong>Peace, Love, and Bliss,</strong><br>The EL Bethuel Team</p>
            </div>
        </div>
    </body>
    </html>";
    
    // Send to customer
    return sendEmail($bookingData['email'], $customerSubject, $customerBody);
}

// === HANDLE FORM SUBMISSIONS ===
$successMessage = '';
$errorMessage = '';

// Check for payment status in URL
if (isset($_GET['payment'])) {
    if ($_GET['payment'] == 'success') {
        $successMessage = "🎉 Payment successful! Thank you for your booking.";
    } elseif ($_GET['payment'] == 'cancelled') {
        $errorMessage = "⚠️ Payment was cancelled.";
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['action'])) {
        switch ($_POST['action']) {
            case 'book_service':
                // Validate and sanitize input
                $bookingData = [
                    'first_name' => filter_var(trim($_POST['first_name'] ?? ''), FILTER_SANITIZE_STRING),
                    'last_name' => filter_var(trim($_POST['last_name'] ?? ''), FILTER_SANITIZE_STRING),
                    'email' => filter_var(trim($_POST['email'] ?? ''), FILTER_SANITIZE_EMAIL),
                    'phone' => filter_var(trim($_POST['phone'] ?? ''), FILTER_SANITIZE_STRING),
                    'service_type' => filter_var($_POST['service_type'] ?? '', FILTER_SANITIZE_STRING),
                    'service_name' => filter_var($_POST['service_name'] ?? '', FILTER_SANITIZE_STRING),
                    'amount' => floatval($_POST['amount'] ?? 0),
                    'message' => filter_var(trim($_POST['message'] ?? ''), FILTER_SANITIZE_STRING),
                    'booking_id' => generateBookingID()
                ];
                
                // Validate required fields
                $errors = [];
                if (empty($bookingData['first_name'])) $errors[] = "First name is required";
                if (empty($bookingData['last_name'])) $errors[] = "Last name is required";
                if (!filter_var($bookingData['email'], FILTER_VALIDATE_EMAIL)) $errors[] = "Valid email is required";
                if (empty($bookingData['phone'])) $errors[] = "Phone number is required";
                
                if (empty($errors)) {
                    // Save to database
                    $saveResult = false;
                    if ($db_connected) {
                        $saveResult = saveBookingToDatabase($bookingData);
                    }
                    
                    // Send email notifications
                    $emailSent = sendBookingNotification($bookingData);
                    
                    if ($saveResult !== false || $emailSent) {
                        $successMessage = "✅ Your booking has been received! Booking ID: <strong>{$bookingData['booking_id']}</strong><br>We will contact you within 24 hours.";
                    } else {
                        $successMessage = "✅ Your booking request has been received! We will contact you shortly.";
                    }
                } else {
                    $errorMessage = "❌ " . implode("<br>", $errors);
                }
                break;
                
            case 'healing_request':
                // Simple healing request handling
                $name = filter_var(trim($_POST['full_name'] ?? ''), FILTER_SANITIZE_STRING);
                $email = filter_var(trim($_POST['email'] ?? ''), FILTER_SANITIZE_EMAIL);
                
                if (!empty($name) && !empty($email)) {
                    $subject = "🙏 Healing Request from " . $name;
                    $body = "Name: $name<br>Email: $email<br>Focus: " . ($_POST['healing_focus'] ?? 'Not specified');
                    
                    foreach ($config['notifications'] as $admin_email) {
                        sendEmail($admin_email, $subject, $body);
                    }
                    
                    $successMessage = "🙏 Your healing request has been received.";
                } else {
                    $errorMessage = "❌ Please provide your name and email.";
                }
                break;
                
            case 'contact_form':
                // Simple contact form handling
                $name = filter_var(trim($_POST['name'] ?? ''), FILTER_SANITIZE_STRING);
                $email = filter_var(trim($_POST['email'] ?? ''), FILTER_SANITIZE_EMAIL);
                
                if (!empty($name) && !empty($email)) {
                    $subject = "📧 Contact Form: " . ($_POST['subject'] ?? 'No subject');
                    $body = "Name: $name<br>Email: $email<br>Message: " . ($_POST['message'] ?? 'No message');
                    
                    foreach ($config['notifications'] as $admin_email) {
                        sendEmail($admin_email, $subject, $body);
                    }
                    
                    $successMessage = "✅ Thank you! Your message has been sent.";
                } else {
                    $errorMessage = "❌ Please provide your name and email.";
                }
                break;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EL Bethuel Molaadira | Be The Magick Live The Miracle</title>
    <meta name="description" content="Professional Web/App Developer & Spiritual Guide. Build automated businesses, learn AI integration, receive energy healing. Peace, Love, and Bliss.">
    <meta name="keywords" content="web developer, AI automation, blockchain, energy healing, spiritual guide, South Africa, business scaling, metaverse development">
    <meta property="og:title" content="EL Bethuel Molaadira - Be The Magick Live The Miracle">
    <meta property="og:description" content="Professional Web Development & Spiritual Guidance Services">
    <meta property="og:image" content="https://secretmatchesclub.co.za/elbethuel/assets/images/og-image.jpg">
    <meta property="og:url" content="https://secretmatchesclub.co.za/elbethuel">
    <meta name="twitter:card" content="summary_large_image">
    
    <!-- External Dependencies -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Include all CSS from original file -->
    <style>
        /* === ROOT VARIABLES === */
        :root {
            --gold: #D4AF37;
            --gold-light: #F1D382;
            --gold-dark: #B8860B;
            --dark: #0A0A0A;
            --darker: #070707;
            --primary: #1a1a2e;
            --secondary: #16213e;
            --glass: rgba(255, 255, 255, 0.05);
            --glass-heavy: rgba(0, 0, 0, 0.7);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        /* === BASE STYLES === */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, var(--darker) 0%, var(--primary) 100%);
            color: white;
            overflow-x: hidden;
            scroll-behavior: smooth;
            min-height: 100vh;
            position: relative;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(212, 175, 55, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(26, 26, 46, 0.05) 0%, transparent 50%);
            z-index: -1;
            pointer-events: none;
        }
        
        /* === UTILITY CLASSES === */
        .gold-gradient {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 50%, var(--gold-dark) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .gold-gradient-bg {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 50%, var(--gold-dark) 100%);
        }
        
        .glass-card {
            background: var(--glass);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            transition: var(--transition);
        }
        
        .glass-card:hover {
            border-color: var(--gold);
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 20px 40px rgba(212, 175, 55, 0.15);
        }
        
        .glass-heavy {
            background: var(--glass-heavy);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }
        
        .nav-link {
            position: relative;
            padding: 10px 0;
            transition: color 0.3s ease;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background: var(--gold);
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        .cta-button {
            background: linear-gradient(135deg, var(--gold), var(--gold-dark));
            color: var(--dark);
            font-weight: 800;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: none;
            cursor: pointer;
        }
        
        .cta-button:hover {
            transform: scale(1.05) translateY(-2px);
            box-shadow: 0 15px 30px rgba(212, 175, 55, 0.3);
        }
        
        .cta-button::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.7s ease;
        }
        
        .cta-button:hover::after {
            left: 100%;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0.4); }
            70% { box-shadow: 0 0 0 15px rgba(212, 175, 55, 0); }
            100% { box-shadow: 0 0 0 0 rgba(212, 175, 55, 0); }
        }
        
        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 4rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            width: 80px;
            height: 4px;
            background: var(--gold);
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .feature-icon {
            width: 70px;
            height: 70px;
            background: rgba(212, 175, 55, 0.1);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            transition: var(--transition);
        }
        
        .glass-card:hover .feature-icon {
            background: rgba(212, 175, 55, 0.2);
            transform: rotate(5deg) scale(1.1);
        }
        
        .testimonial-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(212, 175, 55, 0.05) 100%);
            border-left: 4px solid var(--gold);
        }
        
        .progress-bar {
            background: linear-gradient(90deg, var(--gold), var(--gold-light));
            height: 3px;
            border-radius: 2px;
            width: 0;
            transition: width 1.5s ease-out;
        }
        
        /* === ANIMATIONS === */
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes shimmer {
            0% { background-position: -200% center; }
            100% { background-position: 200% center; }
        }
        
        .animate-float {
            animation: float 6s ease-in-out infinite;
        }
        
        .animate-fade-in {
            animation: fadeIn 0.8s ease-out forwards;
        }
        
        .animate-shimmer {
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            background-size: 200% 100%;
            animation: shimmer 3s infinite linear;
        }
        
        /* === COMPONENT STYLES === */
        .floating-whatsapp {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1000;
            animation: float 4s ease-in-out infinite;
        }
        
        .mobile-menu {
            transform: translateX(-100%);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .mobile-menu.active {
            transform: translateX(0);
        }
        
        .loading-spinner {
            border: 4px solid rgba(255, 255, 255, 0.1);
            border-top: 4px solid var(--gold);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
        }
        
        .pricing-card {
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .pricing-card.popular::before {
            content: 'MOST POPULAR';
            position: absolute;
            top: 20px;
            right: -35px;
            background: var(--gold);
            color: var(--dark);
            padding: 6px 40px;
            transform: rotate(45deg);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 1px;
        }
        
        .count-up {
            font-variant-numeric: tabular-nums;
            font-feature-settings: "tnum";
        }
        
        .energy-glow {
            box-shadow: 0 0 60px rgba(212, 175, 55, 0.2);
        }
        
        .node-card {
            transition: var(--transition);
        }
        
        .node-card:hover {
            transform: scale(1.03) translateY(-5px);
            border-color: var(--gold);
        }
        
        /* === RESPONSIVE DESIGN === */
        @media (max-width: 768px) {
            .section-title::after {
                width: 60px;
                bottom: -12px;
            }
            
            .floating-whatsapp {
                bottom: 20px;
                right: 20px;
            }
            
            .pricing-card.popular::before {
                font-size: 10px;
                padding: 4px 30px;
                right: -30px;
                top: 15px;
            }
        }
        
        /* === CUSTOM SCROLLBAR === */
        ::-webkit-scrollbar {
            width: 10px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.3);
        }
        
        ::-webkit-scrollbar-thumb {
            background: var(--gold);
            border-radius: 5px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: var(--gold-light);
        }
        
        /* === FORM STYLES === */
        .form-input {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: var(--transition);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
        }
        
        /* === GRID LAYOUT ENHANCEMENTS === */
        .grid-auto-fit {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        /* === TYPOGRAPHY ENHANCEMENTS === */
        .text-balance {
            text-wrap: balance;
        }
        
        .text-pretty {
            text-wrap: pretty;
        }
    </style>
    
    <style>
        <?php 
        // Include your original CSS
        $originalHtml = file_get_contents('index.html');
        if (preg_match('/<style>([\s\S]*?)<\/style>/', $originalHtml, $matches)) {
            echo $matches[1];
        } else {
            // Fallback CSS
            echo file_get_contents('fallback-styles.css');
        }
        ?>
        
        /* Additional styles */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            max-width: 400px;
            animation: slideInRight 0.3s ease-out;
        }
        
        @keyframes slideInRight {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
        }
        
        .debug-info {
            background: rgba(0,0,0,0.8);
            color: #0f0;
            padding: 10px;
            font-family: monospace;
            font-size: 12px;
            position: fixed;
            bottom: 10px;
            left: 10px;
            z-index: 9999;
            display: none;
        }
    </style>
    
    <!-- External dependencies -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body class="antialiased">
    <!-- Success/Error Messages -->
    <?php if ($errorMessage): ?>
    <div class="notification">
        <div class="bg-red-500 text-white px-6 py-4 rounded-xl shadow-lg">
            <div class="flex items-start">
                <i class="fas fa-exclamation-circle mt-1 mr-3"></i>
                <div class="flex-1"><?php echo $errorMessage; ?></div>
                <button onclick="this.parentElement.parentElement.remove()" class="ml-4 text-white hover:text-gray-200">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </div>
    <?php endif; ?>
    
    <?php if ($successMessage): ?>
    <div class="notification">
        <div class="bg-green-500 text-white px-6 py-4 rounded-xl shadow-lg">
            <div class="flex items-start">
                <i class="fas fa-check-circle mt-1 mr-3"></i>
                <div class="flex-1"><?php echo $successMessage; ?></div>
                <button onclick="this.parentElement.parentElement.remove()" class="ml-4 text-white hover:text-gray-200">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </div>
    <?php endif; ?>
    
    <!-- Debug info (remove in production) -->
    <div class="debug-info" id="debugInfo">
        PHP <?php echo phpversion(); ?> | 
        DB: <?php echo $db_connected ? 'Connected' : 'Error'; ?>
    </div>
    
    <!-- Include your original HTML content -->
    <?php
    // Read and output the HTML content from your original file
    if (file_exists('index.html')) {
        $html = file_get_contents('index.html');
        
        // Extract only the body content
        if (preg_match('/<body[^>]*>(.*?)<\/body>/s', $html, $matches)) {
            $bodyContent = $matches[1];
            
            // Remove the existing JavaScript since we'll add our own
            $bodyContent = preg_replace('/<script[\s\S]*?>[\s\S]*?<\/script>/', '', $bodyContent);
            
            // Replace form actions with our PHP processing
            $bodyContent = preg_replace_callback(
                '/<form[^>]*>[\s\S]*?<\/form>/',
                function($matches) {
                    $form = $matches[0];
                    
                    // Check if this is a booking form
                    if (strpos($form, 'booking') !== false || strpos($form, 'Book') !== false) {
                        return str_replace(
                            '<form',
                            '<form method="post" onsubmit="return validateBookingForm(this)"',
                            $form
                        );
                    }
                    
                    // Check if this is a healing form
                    if (strpos($form, 'healing') !== false || strpos($form, 'Healing') !== false) {
                        return str_replace(
                            '<form',
                            '<form method="post"',
                            $form
                        );
                    }
                    
                    return $form;
                },
                $bodyContent
            );
            
            echo $bodyContent;
        }
    } else {
        // Fallback content if original file not found
        ?>
        <!-- Floating WhatsApp -->
        <div class="floating-whatsapp">
            <a href="https://wa.me/<?php echo WHATSAPP_NUMBER; ?>?text=Hi%20EL,%20I%20saw%20your%20website%20and%20need%20assistance" 
               target="_blank"
               class="bg-green-500 text-white w-16 h-16 rounded-full flex items-center justify-center shadow-2xl hover:shadow-3xl transition-all duration-300 hover:scale-110">
                <i class="fab fa-whatsapp text-2xl"></i>
            </a>
        </div>
        
        <!-- Navigation -->
        <nav class="fixed w-full z-40 px-4 md:px-8 py-4 bg-black/80 backdrop-blur-lg">
            <div class="max-w-7xl mx-auto flex justify-between items-center">
                <a href="#" class="text-2xl font-black">
                    <span class="text-white">EL</span>
                    <span class="text-yellow-500">BETHUEL</span>
                </a>
                <div class="hidden md:flex space-x-8">
                    <a href="#home" class="text-gray-300 hover:text-white">Home</a>
                    <a href="#services" class="text-gray-300 hover:text-white">Services</a>
                    <a href="#contact" class="text-gray-300 hover:text-white">Contact</a>
                </div>
            </div>
        </nav>
        
        <!-- Hero Section -->
        <section id="home" class="min-h-screen flex items-center justify-center text-center px-4">
            <div>
                <h1 class="text-5xl md:text-7xl font-bold mb-6">
                    Be The <span class="text-yellow-500">Magick</span><br>
                    Live The <span class="text-yellow-500">Miracle</span>
                </h1>
                <p class="text-xl text-gray-300 mb-8">Peace, Love, and Bliss.</p>
                <a href="#contact" class="bg-yellow-500 text-black px-8 py-4 rounded-lg font-bold">
                    Book Free Discovery Call
                </a>
            </div>
        </section>
        
        <!-- Contact Section -->
        <section id="contact" class="py-24 px-4">
            <div class="max-w-2xl mx-auto">
                <h2 class="text-4xl font-bold text-center mb-12">Book a Session</h2>
                <form method="post" class="space-y-6 bg-white/10 p-8 rounded-2xl">
                    <input type="hidden" name="action" value="book_service">
                    <input type="hidden" name="service_type" id="service_type" value="consultation">
                    <input type="hidden" name="service_name" id="service_name" value="Discovery Call">
                    <input type="hidden" name="amount" id="amount" value="0">
                    
                    <div class="grid md:grid-cols-2 gap-6">
                        <input type="text" name="first_name" placeholder="First Name" required 
                               class="bg-white/5 border border-white/10 rounded-xl p-4 text-white">
                        <input type="text" name="last_name" placeholder="Last Name" required 
                               class="bg-white/5 border border-white/10 rounded-xl p-4 text-white">
                    </div>
                    
                    <input type="email" name="email" placeholder="Email" required 
                           class="w-full bg-white/5 border border-white/10 rounded-xl p-4 text-white">
                    
                    <input type="tel" name="phone" placeholder="Phone" required 
                           class="w-full bg-white/5 border border-white/10 rounded-xl p-4 text-white">
                    
                    <textarea name="message" placeholder="Tell us about your needs..." 
                              rows="4" class="w-full bg-white/5 border border-white/10 rounded-xl p-4 text-white"></textarea>
                    
                    <button type="submit" class="w-full bg-yellow-500 text-black py-4 rounded-xl font-bold">
                        Book Free Call
                    </button>
                </form>
            </div>
        </section>
        <?php
    }
    ?>
    
    <!-- Custom JavaScript -->
    <script>
        // Auto-remove notifications after 10 seconds
        setTimeout(() => {
            document.querySelectorAll('.notification').forEach(el => el.remove());
        }, 10000);
        
        // Quick booking functions
        function bookService(serviceCode, serviceName, amount, serviceType = 'development') {
            document.getElementById('service_type').value = serviceType;
            document.getElementById('service_name').value = serviceName;
            document.getElementById('amount').value = amount;
            
            // Scroll to contact form
            const contactSection = document.getElementById('contact');
            if (contactSection) {
                contactSection.scrollIntoView({ behavior: 'smooth' });
            }
        }
        
        function enrollCourse(courseCode, courseName, amount) {
            bookService(courseCode, courseName, amount, 'course');
        }
        
        function bookMentorship(serviceCode, serviceName, amount) {
            bookService(serviceCode, serviceName, amount, 'mentorship');
        }
        
        function requestHealing() {
            bookService('free_healing', 'Free Energy Healing', 0, 'healing');
        }
        
        function bookHealing(serviceCode, serviceName, amount) {
            bookService(serviceCode, serviceName, amount, 'healing');
        }
        
        function selectPackage(packageCode, packageName, amount) {
            bookService(packageCode, packageName, amount, 'development');
        }
        
        // Form validation
        function validateBookingForm(form) {
            const firstName = form.querySelector('[name="first_name"]');
            const lastName = form.querySelector('[name="last_name"]');
            const email = form.querySelector('[name="email"]');
            const phone = form.querySelector('[name="phone"]');
            
            let isValid = true;
            
            // Simple validation
            [firstName, lastName, email, phone].forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = '#ef4444';
                    isValid = false;
                } else {
                    field.style.borderColor = '';
                }
            });
            
            // Email validation
            if (email.value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                email.style.borderColor = '#ef4444';
                isValid = false;
            }
            
            if (!isValid) {
                alert('Please fill in all required fields correctly.');
                return false;
            }
            
            return true;
        }
        
        // Toggle debug info with Ctrl+Shift+D
        document.addEventListener('keydown', (e) => {
            if (e.ctrlKey && e.shiftKey && e.key === 'D') {
                const debugInfo = document.getElementById('debugInfo');
                debugInfo.style.display = debugInfo.style.display === 'none' ? 'block' : 'none';
            }
        });
        
        // Mobile menu toggle (if needed)
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const mobileMenu = document.getElementById('mobileMenu');
            const closeMenuBtn = document.getElementById('closeMenuBtn');
            
            if (mobileMenuBtn && mobileMenu) {
                mobileMenuBtn.addEventListener('click', () => {
                    mobileMenu.classList.add('active');
                    document.body.style.overflow = 'hidden';
                });
                
                if (closeMenuBtn) {
                    closeMenuBtn.addEventListener('click', () => {
                        mobileMenu.classList.remove('active');
                        document.body.style.overflow = '';
                    });
                }
                
                // Close menu when clicking links
                mobileMenu.querySelectorAll('a').forEach(link => {
                    link.addEventListener('click', () => {
                        mobileMenu.classList.remove('active');
                        document.body.style.overflow = '';
                    });
                });
            }
        });
    </script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"><!-- JavaScript -->
    <script>
        // === CONSTANTS AND STATE ===
        const DOM = {
            mobileMenuBtn: document.getElementById('mobileMenuBtn'),
            closeMenuBtn: document.getElementById('closeMenuBtn'),
            mobileMenu: document.getElementById('mobileMenu'),
            progressBar: document.getElementById('progressBar'),
            loginModal: document.getElementById('loginModal'),
            bookingModal: document.getElementById('bookingModal'),
            successModal: document.getElementById('successModal'),
            loadingOverlay: document.getElementById('loadingOverlay'),
            bookingSteps: document.getElementById('bookingSteps'),
            successContent: document.getElementById('successContent')
        };

        let state = {
            currentBookingStep: 1,
            bookingData: {},
            isMobileMenuOpen: false,
            isAnimating: false
        };

        // === UTILITY FUNCTIONS ===
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        function showNotification(message, type = 'success') {
            const notification = document.createElement('div');
            notification.className = `fixed top-6 right-6 z-50 px-6 py-4 rounded-xl glass-card border-l-4 ${
                type === 'success' ? 'border-green-500' : 'border-red-500'
            } animate-fade-in`;
            notification.innerHTML = `
                <div class="flex items-center">
                    <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'} mr-3 ${
                type === 'success' ? 'text-green-500' : 'text-red-500'
            }"></i>
                    <span>${message}</span>
                </div>
            `;
            document.body.appendChild(notification);
            setTimeout(() => notification.remove(), 5000);
        }

        // === MOBILE MENU ===
        DOM.mobileMenuBtn.addEventListener('click', () => {
            state.isMobileMenuOpen = true;
            DOM.mobileMenu.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        DOM.closeMenuBtn.addEventListener('click', closeMobileMenu);

        function closeMobileMenu() {
            state.isMobileMenuOpen = false;
            DOM.mobileMenu.classList.remove('active');
            document.body.style.overflow = '';
        }

        // === SCROLL PROGRESS ===
        window.addEventListener('scroll', debounce(() => {
            const winScroll = document.documentElement.scrollTop;
            const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
            const scrolled = (winScroll / height) * 100;
            DOM.progressBar.style.width = `${scrolled}%`;
        }, 10));

        // === COUNT UP ANIMATION ===
        function animateCountUp() {
            const counters = document.querySelectorAll('.count-up');
            counters.forEach(counter => {
                const target = parseInt(counter.getAttribute('data-count'));
                const increment = target / 50;
                let current = 0;
                
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        counter.textContent = target.toLocaleString();
                        clearInterval(timer);
                    } else {
                        counter.textContent = Math.floor(current).toLocaleString();
                    }
                }, 30);
            });
        }

        // === INTERSECTION OBSERVER ===
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-fade-in');
                    if (entry.target.classList.contains('count-up') && !entry.target.dataset.animated) {
                        entry.target.dataset.animated = 'true';
                        setTimeout(animateCountUp, 300);
                    }
                }
            });
        }, { threshold: 0.1, rootMargin: '0px 0px -100px 0px' });

        // Observe elements
        document.querySelectorAll('.count-up, .glass-card, .section-title, .node-card').forEach(el => {
            observer.observe(el);
        });

        // === SCROLL TO ID ===
        function scrollToId(id) {
            if (state.isAnimating) return;
            state.isAnimating = true;
            
            const element = document.getElementById(id);
            if (element) {
                const offset = 80;
                const elementPosition = element.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - offset;
                
                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
            
            closeMobileMenu();
            setTimeout(() => state.isAnimating = false, 1000);
        }

        // === MODAL FUNCTIONS ===
        function showLoginModal() {
            DOM.loginModal.classList.remove('hidden');
            DOM.loginModal.classList.add('flex');
            document.body.style.overflow = 'hidden';
        }

        function hideLoginModal() {
            DOM.loginModal.classList.add('hidden');
            DOM.loginModal.classList.remove('flex');
            document.body.style.overflow = '';
        }

        function closeSuccessModal() {
            DOM.successModal.classList.add('hidden');
            DOM.successModal.classList.remove('flex');
            document.body.style.overflow = '';
        }

        function showLoading() {
            DOM.loadingOverlay.classList.remove('hidden');
            DOM.loadingOverlay.classList.add('flex');
            document.body.style.overflow = 'hidden';
        }

        function hideLoading() {
            DOM.loadingOverlay.classList.add('hidden');
            DOM.loadingOverlay.classList.remove('flex');
            document.body.style.overflow = '';
        }

        // === BOOKING SYSTEM ===
        function startBookingFlow(service = null) {
            if (service) {
                const serviceMap = {
                    'ai-automation': 'development',
                    'web3-development': 'development',
                    'ecommerce': 'development',
                    'healing': 'healing',
                    'mentorship': 'course',
                    'consultation': 'consultation'
                };
                
                state.bookingData.type = serviceMap[service] || 'development';
                if (service === 'consultation') {
                    state.bookingData.package = 'Free Discovery Call';
                    state.bookingData.price = 'FREE';
                }
            }
            
            state.currentBookingStep = 1;
            loadBookingStep();
            DOM.bookingModal.classList.remove('hidden');
            DOM.bookingModal.classList.add('flex');
            document.body.style.overflow = 'hidden';
        }

        function loadBookingStep() {
            let html = '';
            
            switch(state.currentBookingStep) {
                case 1:
                    html = `
                        <div class="text-center mb-10">
                            <h3 class="text-2xl font-bold mb-4">Let's Get Started</h3>
                            <p class="text-gray-400">Choose what you need help with</p>
                        </div>
                        <div class="grid gap-5">
                            <button onclick="selectBookingType('development')" class="p-8 glass-card text-left hover:border-gold transition rounded-2xl">
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 bg-gold/10 rounded-xl flex items-center justify-center mr-4">
                                        <i class="fas fa-code text-gold text-xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="text-xl font-bold">Professional Service</h4>
                                        <p class="text-gray-400 text-sm">Custom development, AI automation, or business solutions</p>
                                    </div>
                                </div>
                            </button>
                            <button onclick="selectBookingType('course')" class="p-8 glass-card text-left hover:border-gold transition rounded-2xl">
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 bg-gold/10 rounded-xl flex items-center justify-center mr-4">
                                        <i class="fas fa-graduation-cap text-gold text-xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="text-xl font-bold">Course or Training</h4>
                                        <p class="text-gray-400 text-sm">Learn skills through automated courses or live mentorship</p>
                                    </div>
                                </div>
                            </button>
                            <button onclick="selectBookingType('healing')" class="p-8 glass-card text-left hover:border-gold transition rounded-2xl">
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 bg-gold/10 rounded-xl flex items-center justify-center mr-4">
                                        <i class="fas fa-heart text-gold text-xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="text-xl font-bold">Energy Healing</h4>
                                        <p class="text-gray-400 text-sm">Spiritual guidance, energy balancing, or distance healing</p>
                                    </div>
                                </div>
                            </button>
                        </div>
                        <div class="flex justify-between mt-10">
                            <button onclick="closeBooking()" class="px-8 py-3 glass-card rounded-xl hover:bg-white/10 transition">Cancel</button>
                            <div></div>
                        </div>
                    `;
                    break;
                    
                case 2:
                    html = `
                        <div class="text-center mb-10">
                            <h3 class="text-2xl font-bold mb-4">Select Package</h3>
                            <p class="text-gray-400">Choose the option that best fits your needs</p>
                        </div>
                        <div class="space-y-5" id="packageOptions"></div>
                        <div class="flex justify-between mt-10">
                            <button onclick="previousStep()" class="px-8 py-3 glass-card rounded-xl hover:bg-white/10 transition">Back</button>
                            <button onclick="nextStep()" class="cta-button px-8 py-3 rounded-xl font-bold">Next</button>
                        </div>
                    `;
                    loadPackageOptions();
                    break;
                    
                case 3:
                    html = `
                        <div class="text-center mb-10">
                            <h3 class="text-2xl font-bold mb-4">Your Details</h3>
                            <p class="text-gray-400">We'll use this to contact you</p>
                        </div>
                        <form id="contactForm" class="space-y-5">
                            <div class="grid md:grid-cols-2 gap-5">
                                <input type="text" placeholder="First Name" required class="form-input p-4 rounded-xl">
                                <input type="text" placeholder="Last Name" required class="form-input p-4 rounded-xl">
                            </div>
                            <input type="email" placeholder="Email Address" required class="w-full form-input p-4 rounded-xl">
                            <input type="tel" placeholder="Phone Number" required class="w-full form-input p-4 rounded-xl">
                            <textarea placeholder="Tell us about your needs..." rows="4" class="w-full form-input p-4 rounded-xl"></textarea>
                        </form>
                        <div class="flex justify-between mt-10">
                            <button onclick="previousStep()" class="px-8 py-3 glass-card rounded-xl hover:bg-white/10 transition">Back</button>
                            <button onclick="submitBooking()" class="cta-button px-8 py-3 rounded-xl font-bold">Submit Booking</button>
                        </div>
                    `;
                    break;
                    
                case 4:
                    html = `
                        <div class="text-center py-10">
                            <div class="w-24 h-24 bg-green-500/20 rounded-full flex items-center justify-center mx-auto mb-8">
                                <i class="fas fa-check text-green-500 text-4xl"></i>
                            </div>
                            <h3 class="text-2xl font-bold mb-6">Booking Confirmed!</h3>
                            <p class="text-gray-400 mb-10">We've received your booking request and will contact you within 24 hours.</p>
                            <div class="space-y-4 mb-10 glass-card p-8 rounded-2xl text-left">
                                <p><strong class="text-gold">Service:</strong> <span class="ml-2">${state.bookingData.type}</span></p>
                                <p><strong class="text-gold">Package:</strong> <span class="ml-2">${state.bookingData.package}</span></p>
                                <p><strong class="text-gold">Estimated Cost:</strong> <span class="ml-2">${state.bookingData.price}</span></p>
                            </div>
                            <button onclick="closeBooking()" class="cta-button px-10 py-4 rounded-xl font-bold">Done</button>
                        </div>
                    `;
                    break;
            }
            
            DOM.bookingSteps.innerHTML = html;
        }

        function selectBookingType(type) {
            state.bookingData.type = type;
            state.currentBookingStep = 2;
            loadBookingStep();
        }

        function loadPackageOptions() {
            const packages = {
                development: [
                    { name: 'Discovery Call (Free)', price: 'FREE', desc: '30-minute consultation' },
                    { name: 'Basic Development', price: 'R12,500', desc: 'Simple website or app' },
                    { name: 'AI Automation', price: 'R25,000', desc: 'Custom AI solutions' },
                    { name: 'Full Business Suite', price: 'R85,000', desc: 'Complete digital transformation' }
                ],
                course: [
                    { name: 'AI Automation Course', price: 'R1,750', desc: 'Self-paced learning' },
                    { name: 'Live Mentorship', price: 'R5,550', desc: '90-minute session' },
                    { name: 'Web3 Basics', price: 'R2,500', desc: 'Blockchain fundamentals' }
                ],
                healing: [
                    { name: 'Free Distance Healing', price: 'FREE', desc: 'Energy healing session' },
                    { name: 'Energy Alignment', price: 'R850', desc: 'Professional balancing' },
                    { name: 'Spiritual Guidance', price: 'R1,200', desc: 'One-on-one counseling' }
                ]
            };

            const optionsDiv = document.getElementById('packageOptions');
            if (!optionsDiv) return;

            optionsDiv.innerHTML = packages[state.bookingData.type]?.map((pkg, index) => `
                <div class="p-6 glass-card rounded-2xl cursor-pointer transition-all duration-300 border ${
                    index === 0 ? 'border-gold bg-gold/5' : 'border-white/10'
                } hover:border-gold hover:bg-gold/5" onclick="selectPackageOption('${pkg.name}', '${pkg.price}')">
                    <div class="flex justify-between items-center">
                        <div class="text-left">
                            <h4 class="font-bold text-lg">${pkg.name}</h4>
                            <p class="text-gray-400 text-sm mt-1">${pkg.desc}</p>
                        </div>
                        <div class="text-xl font-bold gold-gradient">${pkg.price}</div>
                    </div>
                </div>
            `).join('');
        }

        function selectPackageOption(pkg, price) {
            state.bookingData.package = pkg;
            state.bookingData.price = price;
            
            const options = document.querySelectorAll('#packageOptions > div');
            options.forEach(div => {
                div.classList.remove('border-gold', 'bg-gold/5');
                div.classList.add('border-white/10');
            });
            
            event.currentTarget.classList.remove('border-white/10');
            event.currentTarget.classList.add('border-gold', 'bg-gold/5');
        }

        function previousStep() {
            if (state.currentBookingStep > 1) {
                state.currentBookingStep--;
                loadBookingStep();
            }
        }

        function nextStep() {
            if (state.currentBookingStep < 4) {
                state.currentBookingStep++;
                loadBookingStep();
            }
        }

        function submitBooking() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                state.currentBookingStep = 4;
                loadBookingStep();
                showNotification('Booking submitted successfully! We will contact you soon.', 'success');
            }, 2000);
        }

        function closeBooking() {
            DOM.bookingModal.classList.add('hidden');
            DOM.bookingModal.classList.remove('flex');
            state.currentBookingStep = 1;
            state.bookingData = {};
            document.body.style.overflow = '';
        }

        // === QUICK BOOKING FUNCTIONS ===
        function bookService(serviceName) {
            state.bookingData.type = 'development';
            state.bookingData.package = serviceName;
            startBookingFlow();
        }

        function enrollCourse(courseId) {
            const courseMap = {
                'ai-automation': { name: 'AI Automation Mastery', price: 'R1,750' },
                'web3-basics': { name: 'Web3 & Blockchain Basics', price: 'R2,500' },
                'process-automation': { name: 'Business Process Automation', price: 'R3,000' }
            };
            
            const course = courseMap[courseId];
            if (course) {
                state.bookingData.type = 'course';
                state.bookingData.package = course.name;
                state.bookingData.price = course.price;
                startBookingFlow();
            }
        }

        function bookMentorship() {
            state.bookingData.type = 'course';
            state.bookingData.package = 'Live Mentorship';
            state.bookingData.price = 'R5,550';
            startBookingFlow();
        }

        function requestHealing() {
            state.bookingData.type = 'healing';
            state.bookingData.package = 'Free Distance Healing';
            state.bookingData.price = 'FREE';
            startBookingFlow();
        }

        function bookHealing(type) {
            state.bookingData.type = 'healing';
            state.bookingData.package = type === 'chakra' ? 'Energy Alignment' : 'Spiritual Guidance';
            state.bookingData.price = type === 'chakra' ? 'R850' : 'R1,200';
            startBookingFlow();
        }

        function selectPackage(type) {
            const packageMap = {
                'starter': { name: 'Starter Package', price: 'R12,500' },
                'growth': { name: 'Growth Package', price: 'R35,000' },
                'enterprise': { name: 'Enterprise Package', price: 'R120,000' }
            };
            
            const pkg = packageMap[type];
            if (pkg) {
                state.bookingData.type = 'development';
                state.bookingData.package = pkg.name;
                state.bookingData.price = pkg.price;
                startBookingFlow();
            }
        }

        // === REFERRAL SYSTEM ===
        function showReferralModal() {
            const referralCode = generateReferralCode();
            DOM.successContent.innerHTML = `
                <div class="text-center py-8">
                    <div class="w-20 h-20 bg-gold/20 rounded-full flex items-center justify-center mx-auto mb-6">
                        <i class="fas fa-gift text-gold text-3xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold mb-4">Your Referral Link</h3>
                    <p class="text-gray-400 mb-6">Share this link to earn 15% commission on referrals!</p>
                    <div class="glass-card p-4 rounded-xl mb-6">
                        <p class="font-mono text-sm break-all">https://secretmatchesclub.co.za/elbethuel?ref=${referralCode}</p>
                    </div>
                    <button onclick="copyReferralLink('${referralCode}')" class="cta-button w-full py-4 rounded-xl font-bold">
                        <i class="fas fa-copy mr-2"></i> Copy Link
                    </button>
                </div>
            `;
            DOM.successModal.classList.remove('hidden');
            DOM.successModal.classList.add('flex');
        }

        function generateReferralCode() {
            return Math.random().toString(36).substring(2, 10).toUpperCase();
        }

        function copyReferralLink(code) {
            const link = `https://secretmatchesclub.co.za/elbethuel?ref=${code}`;
            navigator.clipboard.writeText(link).then(() => {
                showNotification('Referral link copied to clipboard!', 'success');
            });
        }

        // === FORM HANDLING ===
        document.addEventListener('DOMContentLoaded', () => {
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', (e) => {
                    e.preventDefault();
                    showLoading();
                    
                    setTimeout(() => {
                        hideLoading();
                        showNotification('Thank you! We\'ll be in touch soon.', 'success');
                        form.reset();
                    }, 1500);
                });
            });

            // Smooth scroll for all anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href !== '#') {
                        e.preventDefault();
                        const targetId = href.substring(1);
                        scrollToId(targetId);
                    }
                });
            });

            // Initialize count animation on load
            animateCountUp();
        });

        // === SOCIAL SHARE ===
        function shareProfile() {
            if (navigator.share) {
                navigator.share({
                    title: 'EL Bethuel Molaadira - Be The Magick Live The Miracle',
                    text: 'Check out this amazing web developer and spiritual guide!',
                    url: window.location.href
                });
            } else {
                navigator.clipboard.writeText(window.location.href);
                showNotification('Link copied to clipboard!', 'success');
            }
        }

        // === ANIMATION TRIGGERS ===
        window.addEventListener('load', () => {
            document.body.classList.add('loaded');
            setTimeout(() => {
                document.querySelectorAll('.animate-on-load').forEach(el => {
                    el.classList.add('animate-fade-in');
                });
            }, 300);
        });
    </script>
</body>
</html>