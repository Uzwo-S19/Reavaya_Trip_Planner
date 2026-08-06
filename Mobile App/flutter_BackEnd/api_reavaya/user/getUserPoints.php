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


// Get the user ID from the request body
$user_id = $_POST['user_id'];

// Prepare the SQL query to get the user points
$sql = "SELECT points_balance FROM users WHERE user_id = $user_id";

// Execute the query
$result = $connectNow->query($sql);

// Check if the query was successful
if ($result) {
    // Check if there is a record returned
    if ($result->num_rows > 0) {
        // Fetch the user points from the result
        $row = $result->fetch_assoc();
        $user_points = $row['points_balance'];

        // Return the user points as the response
        echo $user_points;
    } else {
        // If no record found, return an error message
        echo "User not found";
    }
} else {
    // If query execution failed, return an error message
    echo "Error: " . $sql . "<br>" . $connectNow->error;
}

// Close the database connection
$connectNow->close();
?>
