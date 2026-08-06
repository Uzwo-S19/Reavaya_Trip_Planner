<?php
header("Content-Type: application/json; charset=UTF-8");

include '../connection.php';

$filterType = $_GET['filter_type']; // Get the filter type from the query string

$startDate = "";
$endDate = date('Y-m-d H:i:s'); // Current date and time

switch ($filterType) {
    case "last_day":
        $startDate = date('Y-m-d H:i:s', strtotime('-1 day'));
        break;
    case "last_week":
        $startDate = date('Y-m-d H:i:s', strtotime('-1 week'));
        break;
    case "last_month":
        $startDate = date('Y-m-d H:i:s', strtotime('-1 month'));
        break;
    default:
        // No filter type provided, retrieve all data
        break;
}

$sql = "SELECT COUNT(*) AS login_count FROM users_table WHERE is_active = 1";

// Apply filter if a valid start date is available
if ($startDate !== "") {
    $sql .= " WHERE last_login >= '$startDate' AND last_login <= '$endDate'";
}
$result = $connectNow->query($sql);

$output = [];

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $output[] = $row;
} else {
    $output[] = "0 results";
}

echo json_encode($output);

$connectNow->close();
?>
