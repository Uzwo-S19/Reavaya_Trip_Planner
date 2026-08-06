class User{
  int userID;
  String userName;
  String surname;
  String email;
  int phoneNo;
  int age;
  int pointsBalance;
  DateTime createdAt;
  int isActive;
  DateTime updatedAt;
  DateTime lastLogin;
  String qrCode;
  String password;

  User(this.userID, this.userName, this.surname, this.email, this.password,
      this.phoneNo, this.age, this.pointsBalance, this.createdAt, this.isActive,
      this.updatedAt, this.lastLogin, this.qrCode,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
    int.parse(json['user_id']),
    json['user_name'],
    json['surname'],
    json['email'],
    json['user_password'],
    int.parse(json['phone_number']),
    int.parse(json['age']),
    int.parse(json['points_balance']),
    DateTime.parse(json['created_at']),
    int.parse(json['is_active']),
    DateTime.parse(json['updated_at']),
    DateTime.parse(json['last_login']),
    json['qr_code'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': userID.toString(),
    'user_name': userName,
    'surname': surname,
    'email': email,
    'user_password': password,
    'phone_number': phoneNo.toString(),
    'age': phoneNo.toString(),
    'points_balance': pointsBalance.toString(),
    'created_at': createdAt.toString(),
    'is_active': isActive.toString(),
    'updated_at': updatedAt.toString(),
    'last_login': lastLogin.toString(),
    'qr_code': qrCode,
  };
}