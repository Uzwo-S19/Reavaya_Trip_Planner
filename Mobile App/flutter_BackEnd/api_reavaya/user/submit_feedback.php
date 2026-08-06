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

// Get feedback data from POST request
$user_id = $_POST['user_id'];
$cleanliness = $_POST['cleanliness'];
$driver = $_POST['driver'];
$comments = $connectNow->real_escape_string($_POST['comments']); // Prevent SQL injection

// Insert feedback into the database
$sqlQuery = "INSERT INTO feedback_table SET user_id = '$user_id', cleanliness = '$cleanliness', driver = '$driver', comments = '$comments'";

$queryResponse = $connectNow->query($sqlQuery);

if($queryResponse){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
$connectNow->close();
?>
