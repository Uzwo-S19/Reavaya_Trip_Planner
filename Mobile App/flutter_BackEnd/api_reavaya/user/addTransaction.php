<?php
header('Content-Type: application/json');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include '../connection.php';

/*$serverhost = "localhost";
$user = "root";
$password = "";
$database = "reavaya_app";

$connectNow = new mysqli($serverhost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}*/


// Retrieve values from POST request
$User_ID = (int) $_POST['User_ID'];
$email = $_POST['email'];
$amount = (int) $_POST['amount']; // Casting to int
$Points = (int) $_POST['Points']; // Casting to int

// Prepare and bind
$stmt = $connectNow->prepare("INSERT INTO trasaction_table (User_ID, email, amount, Points) VALUES (?, ?, ?, ?)");
$stmt->bind_param("isii", $User_ID, $email, $amount, $Points);

// Execute
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'New record created successfully']);
} else {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $stmt->error]);
}

$stmt->close();
$connectNow->close();
?>
