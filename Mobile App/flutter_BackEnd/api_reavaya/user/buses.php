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

$pickup = $_GET['pickup'];
$destination = $_GET['destination'];

$queryBuses = "SELECT name, departure_time FROM buses WHERE pickup_point = '$pickup' AND destination = '$destination'";
$resultBuses = $conn->query($queryBuses);

$buses = array();
while ($rowBuses = $resultBuses->fetch_assoc()) {
    $bus = array(
        'name' => $rowBuses['name'],
        'departureTime' => $rowBuses['departure_time'],
    );
    $buses[] = $bus;
}

echo json_encode($buses);

?>