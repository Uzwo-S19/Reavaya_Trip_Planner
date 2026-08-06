<?php
header("Content-Type: application/json; charset=UTF-8");

include '../connection.php';

/*$serverhost = "localhost";
$user = "root";
$password = "";
$database = "reavaya_app";

$connectNow = new mysqli($serverhost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}*/
<?php
header("Content-Type: application/json; charset=UTF-8");

include '../connection.php';

$filterType = $_GET['filter_type']; // Get the filter type from the query string

/*$serverhost = "localhost";
$user = "root";
$password = "";
$database = "reavaya_app";

$connectNow = new mysqli($serverhost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}*/

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

$sql = "SELECT Transaction_ID, User_ID, Points, TimeStamp, Amount FROM trasaction_table";

// Apply filter if a valid start date is available
if ($startDate !== "") {
    $sql .= " WHERE TimeStamp >= '$startDate' AND TimeStamp <= '$endDate'";
}
$result = $connectNow->query($sql);

$output = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $output[] = $row;
    }
} else {
    $output[] = "0 results";
}

echo json_encode($output);

$connectNow->close();
?>
