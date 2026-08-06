<?php
include '../connection.php';

// Fetch all feedback from the database
$sqlQuery = "SELECT * FROM feedback_table";

$queryResponse = $connectNow->query($sqlQuery);

if ($queryResponse) {
    $feedbackData = array();
    while ($row = $queryResponse->fetch_assoc()) {
        $feedbackData[] = $row;
    }

    // Get the number of feedbacks
    $feedbackCount = count($feedbackData);

    // Echo the feedback data and count as JSON
    echo json_encode(array("feedbackData" => $feedbackData, "feedbackCount" => $feedbackCount));
} else {
    echo json_encode(array("feedbackData" => array(), "feedbackCount" => 0)); // Empty array and count on error
}

$connectNow->close();
?>
