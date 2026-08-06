<?php
include '../connection.php';

// Query to get the count of registered passengers
$sqlQuery = "SELECT COUNT(*) AS registered_passengers FROM users_table WHERE is_active = 1";
$queryResponse = $connectNow->query($sqlQuery);

if ($queryResponse->num_rows > 0) {
    $rowFound = $queryResponse->fetch_assoc();
    $registeredPassengersCount = $rowFound['registered_passengers'];
    echo json_encode(array("success" => true, "count" => $registeredPassengersCount));
} else {
    echo json_encode(array("success" => false));
}

$connectNow->close();
?>
