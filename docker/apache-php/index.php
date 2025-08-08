<?php
$host = getenv('DB_HOST') ?: 'mysql';
$user = getenv('DB_USER') ?: 'appuser';
$pass = getenv('DB_PASSWORD') ?: 'apppass';
$db   = getenv('DB_NAME') ?: 'appdb';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo "DB connection failed: " . $conn->connect_error;
    exit;
}
echo "Connected to DB successfully!<br>";
echo "PHP version: " . phpversion();
?>

