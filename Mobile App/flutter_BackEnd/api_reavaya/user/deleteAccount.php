<?php
include '../connection.php';

$email = $_POST['email'];
$user_password = md5($_POST['password']);

$updateQuery = "UPDATE users_table SET is_active = 0 WHERE email = '".$email."' AND user_password = '".$user_password."' AND is_active = 1";

$queryUpdateResponse = $connectNow->query($updateQuery);

if($queryUpdateResponse){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}
$connectNow->close();
?>
