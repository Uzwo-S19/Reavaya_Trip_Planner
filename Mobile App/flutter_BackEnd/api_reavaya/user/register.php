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

//POST = send/save data to mysql db
//GET = retrieve/read data from mysql db

$user_name = $_POST['user_name'];
$surname = $_POST['surname'];
$email = $_POST['email'];
$phone_number = $_POST['phone_number'];
$age = $_POST['age'];
$points_balance = $_POST['points_balance'];
$created_at = $_POST['created_at'];
$updated_at = $_POST['updated_at'];
$last_login = $_POST['last_login'];
$qr_code = $_POST['qr_code'];
$user_password = md5($_POST['user_password']);

$sqlQuery = "INSERT INTO users_table SET user_name = '".$user_name."', surname = '".$surname."', email = '".$email."', 
            phone_number = '".$phone_number."', age = '".$age."', points_balance = '".$points_balance."', created_at = '".$created_at."', 
			 is_active = 1, updated_at = '".$updated_at."', last_login = '".$last_login."', 
             qr_code = '".$qr_code."', user_password = '".$user_password."'";

$queryResponse = $connectNow->query($sqlQuery);

if($queryResponse){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
$connectNow->close();

?>