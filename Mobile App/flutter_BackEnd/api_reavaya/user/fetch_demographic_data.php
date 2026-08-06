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

$query = "SELECT age FROM users_table WHERE is_active = 1";
$result = $connectNow->query($query);

$data = array();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
$connectNow->close();

?>
