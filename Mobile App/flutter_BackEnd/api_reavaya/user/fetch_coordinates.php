<?php

$servername = "localhost"; // Change this if your database is hosted on a different server
$username = "root"; // Change this to your database username
$password = ""; // Change this to your database password
$database = "inforsd"; // Change this to the name of your database

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$pickup = $_GET['pickup']; // Get pickup point from URL parameter
$destination = $_GET['destination']; // Get destination from URL parameter

// Fetch coordinates for pickup point
$pickupQuery = "SELECT latitude, longitude FROM locations WHERE name = '$pickup' LIMIT 1";
$pickupResult = $conn->query($pickupQuery);
$pickupCoordinates = $pickupResult->fetch_assoc();

// Fetch coordinates for destination
$destinationQuery = "SELECT latitude, longitude FROM locations WHERE name = '$destination' LIMIT 1";
$destinationResult = $conn->query($destinationQuery);
$destinationCoordinates = $destinationResult->fetch_assoc();

$response = [
    'pickupCoordinates' => [
        'latitude' => $pickupCoordinates['latitude'],
        'longitude' => $pickupCoordinates['longitude'],
    ],
    'destinationCoordinates' => [
        'latitude' => $destinationCoordinates['latitude'],
        'longitude' => $destinationCoordinates['longitude'],
    ],
];

header('Content-Type: application/json');

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

$response['buses'] = $buses;

echo json_encode($response);

$conn->close();

?>
