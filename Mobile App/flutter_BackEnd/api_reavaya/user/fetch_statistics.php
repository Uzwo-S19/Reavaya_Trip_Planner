<?php
include '../connection.php';

/*$serverhost = "localhost";
$user = "root";
$password = "";
$database = "reavaya_app";

$connectNow = new mysqli($serverhost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}*/

// Fetch login statistics
$loginStatsQuery = "SELECT user_id, last_login FROM users_table WHERE is_active = 1";
$loginStatsResponse = $connectNow->query($loginStatsQuery);
$loginStatistics = array();
while ($row = $loginStatsResponse->fetch_assoc()) {
    $loginStatistics[] = $row;
}

$responseData = array(
    "loginStatistics" => $loginStatistics,
);

echo json_encode($responseData);
$connectNow->close();

?>
