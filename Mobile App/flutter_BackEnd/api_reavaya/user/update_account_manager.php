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

$user_id = $_POST['user_id'];
$user_name = $_POST['user_name'];
$surname = $_POST['surname'];
$email = $_POST['email'];
$phone_number = $_POST['phone_number'];
$qr_code = $_POST['qr_code'];
$user_password = md5($_POST['user_password']);
$currentDateTime = date('Y-m-d H:i:s'); // Current date and time

// Check if the user_id exists in the database
$checkQuery = "SELECT * FROM manager_users_table WHERE user_id = '$user_id' AND is_active = 1";
$checkResult = $connectNow->query($checkQuery);

if ($checkResult->num_rows == 0) {
    echo json_encode(array("success" => false));
    exit();
}

// Update the user record with the new data and set last_updated to current date and time
$updateQuery = "UPDATE manager_users_table SET 
                user_name = '$user_name',
                surname = '$surname',
                email = '$email',
                phone_number = '$phone_number',
                qr_code = '$qr_code',
                user_password = '$user_password',
                last_updated = '$currentDateTime'
                WHERE user_id = '$user_id', 
                is_active = 1";

$queryResponse = $connectNow->query($updateQuery);

if($queryResponse){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
$connectNow->close();

?>
