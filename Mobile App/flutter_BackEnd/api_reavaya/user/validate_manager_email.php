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

$email = $_POST['email'];

$sqlQuery = "SELECT * FROM manager_users_table WHERE email = '".$email."' AND is_active = 1";

$queryResponse = $connectNow->query($sqlQuery);

if($queryResponse->num_rows > 0){
    echo json_encode(array("emailFound"=>true));
}else{
    echo json_encode(array("emailFound"=>false));
}
$connectNow->close();
?>