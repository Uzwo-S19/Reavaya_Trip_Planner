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

$queryDestinations = "SELECT name FROM locations";
$resultDestinations = $conn->query($queryDestinations);

$destinations = array();
while ($rowDestinations = $resultDestinations->fetch_assoc()) {
    $destinations[] = $rowDestinations["name"];
}

echo json_encode($destinations);


?>
