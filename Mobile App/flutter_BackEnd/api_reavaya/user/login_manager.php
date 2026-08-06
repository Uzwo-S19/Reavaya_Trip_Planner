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
$user_password = md5($_POST['user_password']);
$currentDateTime = date('Y-m-d H:i:s');

$sqlQuery = "SELECT * FROM manager_users_table WHERE email = '".$email."' AND user_password = '".$user_password."' AND is_active = 1";

$queryResponse = $connectNow->query($sqlQuery);

if($queryResponse -> num_rows > 0){ //allow user to login
    $userRecord = array();
    while($rowFound = $queryResponse->fetch_assoc()){
        $userRecord = $rowFound;
    }

    $updateQuery = "UPDATE manager_users_table SET last_login = '".$currentDateTime."' WHERE email = '".$email."' AND is_active = 1";
    $queryUpdateResponse = $connectNow->query($updateQuery);

    if($queryUpdateResponse){
        echo json_encode(
            array(
                "success" => true, 
                "user_id" => $userRecord['user_id'],  // assuming 'user_id' is the field name in your database
                "userData" => $userRecord,
            )
        );
    } else {
        echo json_encode(
            array(
                "success" => false, 
                "message" => "Failed to update last login.",
            )
        );
    }
} else { //do not allow user to login
    echo json_encode(array("success" => false, "message" => "Invalid email or password."));
}
$connectNow->close();

?>
