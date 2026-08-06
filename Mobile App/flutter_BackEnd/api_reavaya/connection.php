<?php

header("Access-Control-Allow-Origin: *"); // Replace * with specific origins if needed
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");

$serverHost ="localhost";
$user="root";
$password="";
$database="reavaya_app";

//code for checking if the connection is established. Assign to connect variable
$connectNow = new mysqli($serverHost, $user, $password, $database);

// Check connection
if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}
?>
