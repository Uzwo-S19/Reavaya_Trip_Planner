<?php
include '../connection.php';

// Get the current date
$currentDate = date('Y-m-d');

// Query to get the count of logins for the current day
$sqlQuery = "SELECT COUNT(*) AS logins_today FROM users_table WHERE DATE(last_login) = '$currentDate' AND is_active = 1";
$queryResponse = $connectNow->query($sqlQuery);

if ($queryResponse->num_rows > 0) {
    $rowFound = $queryResponse->fetch_assoc();
    $loginsTodayCount = $rowFound['logins_today'];
    echo json_encode(array("success" => true, "count" => $loginsTodayCount));
} else {
    echo json_encode(array("success" => false));
}

$connectNow->close();
?>
