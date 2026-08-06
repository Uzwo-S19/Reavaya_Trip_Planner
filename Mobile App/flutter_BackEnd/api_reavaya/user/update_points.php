<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$serverhost = "localhost";
$user = "root";
$password = "";
$database = "reavaya_app";

$connectNow = new mysqli($serverhost, $user, $password, $database);

// Check connection
if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}

// Check if userId is sent via POST request
////if (!isset($_POST['user_id']) || !is_numeric($_POST['user_id'])) {
    ////http_response_code(400);
    ////echo "Invalid or missing user_id";
    ////exit();
////}

$userId = (int)$_POST['user_id'];  // Convert to integer

// Check if points to add are sent via POST request
//if (!isset($_POST['points_balance']) || !is_numeric($_POST['points_balance']) || $_POST['points_balance'] < 0) {
  //  http_response_code(400);
    //echo "Invalid or missing points_balance data";
    //exit();
//}

$pointsToAdd =(int)$_POST['points_balance']; // Convert to integer

// Log the received data (for debugging purposes)
//error_log("Received points: $pointsToAdd for user ID: $userId");
//error_log("Received POST Data: " . print_r($_POST, true)); // Print the POST data

// Create a prepared statement to update the user's points balance
$stmt = $connectNow->prepare("UPDATE users_table SET points_balance = points_balance + ? WHERE user_id = ?");

if ($stmt === false) {
    http_response_code(500);
    echo "Error preparing statement: " . $connectNow->error;
    exit();
}

$stmt->bind_param('ii', $pointsToAdd, $userId);

// Execute the statement
if (!$stmt->execute()) {
    http_response_code(500);
    echo "Error adding points: " . $stmt->error;
    $stmt->close();
    $connectNow->close();
    exit();
}

if ($stmt->affected_rows === 0) {
    http_response_code(404);
    echo "User not found";
} else {
    echo "Points successfully added";
}

$stmt->close();
$connectNow->close();
?>