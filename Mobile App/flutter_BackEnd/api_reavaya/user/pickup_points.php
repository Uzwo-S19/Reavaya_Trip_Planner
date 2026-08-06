<?php

// Database configuration
$servername = "localhost"; // Change this if your database is hosted on a different server
$username = "root"; // Change this to your database username
$password = ""; // Change this to your database password
$database = "inforsd"; // Change this to the name of your database

// Create a connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$queryPickupPoints = "SELECT name FROM locations";
$resultPickupPoints = $conn->query($queryPickupPoints);

$pickupPoints = array();
while ($rowPickupPoints = $resultPickupPoints->fetch_assoc()) {
    $pickupPoints[] = $rowPickupPoints["name"];
}

echo json_encode($pickupPoints);

?>
