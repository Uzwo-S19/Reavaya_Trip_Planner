class API {
  static const hostConnect = 'http://10.126.33.185/api_reavaya';
  static const hostConnectUser = '$hostConnect/user';

  // Other API endpoints...

  //register user
  static const validateEmail = '$hostConnect/user/validate_email.php';
  static const register = '$hostConnect/user/register.php';
  static const login = '$hostConnect/user/login.php';
  static const updateAccount = '$hostConnect/user/update_account.php';
  static const validateEmailManager = '$hostConnect/user/validate_manager_email.php';
  static const registerManager = '$hostConnect/user/register_manager.php';
  static const loginManager = '$hostConnect/user/login_manager.php';
  static const updateAccountManager = '$hostConnect/user/update_account_manager.php';
  static const updatePoints = '$hostConnectUser/user/update_points.php';
  static const qrScanner = '$hostConnectUser/user/db.php';
  static const fetchStatistics = '$hostConnectUser/user/fetch_statistics.php';
  static const fetchDemographicData = '$hostConnectUser/user/fetch_demographic_data.php';
  static const submitFeedback = '$hostConnectUser/user/submit_feedback.php';
  static const fetchUserData = '$hostConnectUser/user/fetch_user_data.php';
  static const deleteAccount = '$hostConnectUser/user/deleteAccount.php';
  static const fetchCoordinates = '$hostConnectUser/user/fetch_coordinates.php';
  static const pickupPoints = '$hostConnectUser/user/pickup_points.php';
  static const destinations = '$hostConnectUser/user/destinations.php';

  static int counter = 0;
}
