<?php

require 'vendor/autoload.php';

// Import the necessary class from the library
use Zxing\QrReader;



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

// Assuming the scanned QR code image data is passed as a GET parameter 'scannedCode'
$scannedQRCode = $_POST['firstScannedCode'];

$secondScannedCode = $_POST['secondScannedCode'];

$kingsway = 'Going to Kingsway';
$Braamfontein = 'Going to Braamfontein';
$Soweto = 'Going to Soweto Highway';
$Parktown = 'Going to Parktown';


// Validate the scanned QR code
    // Create a QrReader instance to decode the scanned QR code
    //$qrReader = new QrReader($scannedCode);
    //$decodedScannedCode = 'Life is too short to be generating QR codes';//$qrReader->text();

    // Database configuration
    $servername = "localhost"; // Change this if your database is hosted on a different server
    $username = "root"; // Change this to your database username
    $password = ""; // Change this to your database password
    $database = "inforsd"; // Change this to the name of your database

    
    // Function to validate the scanned QR code
    function validateQRCode($scannedCode)
    {
        global $conn;
        $sql = "SELECT * FROM QrCodes WHERE Qr = '$scannedCode'";
        $result = $conn->query($sql);
        return $result->num_rows > 0;
    }

;

    
if ($secondScannedCode == $kingsway && $scannedQRCode == $Braamfontein) {
    // Deduct 10 points
    $points = 10;
} else if ($secondScannedCode == $Parktown && $scannedQRCode == $kingsway) {
    // Deduct 9 points
    $points = 9;
} else if ($secondScannedCode == $Braamfontein && $scannedQRCode == $Soweto) {
    // Deduct 20 points
    $points = 20;
} else {
    // Invalid combination, set points to 0
    $points = 0;
}

$userID = 1;

//Deduct the amount from the user's balance in the database
$sql = "UPDATE users SET points = points - $points WHERE userID = $userID";




if ($conn->query($sql) === TRUE) {
    echo "Amount deducted successfully";
} else {
    echo "Error: " . $conn->error;
}

// Close the database connection
$conn->close();

// Return the points as the response
echo $points;



