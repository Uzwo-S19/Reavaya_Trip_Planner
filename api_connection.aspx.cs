public class API
{
    //  192.168.100.240
    public const string HostConnect = "http://172.16.4.18/api_reavaya";
    public const string HostConnectUser = HostConnect + "/user";

    // Other API endpoints...

    // Register user
    public const string ValidateEmail = HostConnectUser + "/validate_email.php";
    public const string Register = HostConnectUser + "/register.php";
    public const string Login = HostConnectUser + "/login.php";
    public const string UpdateAccount = HostConnectUser + "/update_account.php";
    public const string ValidateEmailManager = HostConnectUser + "/validate_manager_email.php";
    public const string RegisterManager = HostConnectUser + "/register_manager.php";
    public const string LoginManager = HostConnectUser + "/login_manager.php";
    public const string UpdateAccountManager = HostConnectUser + "/update_account_manager.php";
    public const string UpdatePoints = HostConnectUser + "/update_points.php";
    public const string QrScanner = HostConnectUser + "/db.php";
    public const string FetchDemographicData = HostConnectUser + "/fetch_demographic_data.php";
    public const string SubmitFeedback = HostConnectUser + "/submit_feedback.php";
    public const string FetchUserData = HostConnectUser + "/fetch_user_data.php";
    public const string DisplayTransaction = HostConnectUser + "/displayTransaction.php";
   // string phpUrl = "http://192.168.100.239:8080/api_reavaya/user/update_schedule.php"; // Replace with the actual URL
    public const string UpdateSchedule = HostConnectUser + "/update_schedule.php";
    public const string getRegisteredPassengers = HostConnectUser + "/getRegisteredPassengers.php";
    public const string loginCounter = HostConnectUser + "/loginCounter.php";
    public const string deleteAccount = HostConnectUser + "/deleteAccount.php";
    public const string deletePassengerAccount = HostConnectUser + "/deletePassengerAccount.php";
    public const string viewFeedback = HostConnectUser + "/view_feedback.php";
    public const string submitNotifications = HostConnectUser + "/submit_notifications.php";
    public const string fetchNotifications = HostConnectUser + "/fetch_notifications.php";
    public const string notifications = HostConnectUser + "/notifications.php";
    // string url = "http://192.168.91.69:8080/api_reavaya/user/add_schedule.php";
    public const string AddSchedule = HostConnectUser + "/add_schedule.php";
    public const string fetchRides = HostConnectUser + "/fetchRides.php";
}
