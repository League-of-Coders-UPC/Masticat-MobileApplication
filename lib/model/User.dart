class User {
  final String uuid;
  final String email;
  final String password;
  final String roleId;

  User({
    required this.uuid,
    required this.email,
    required this.password,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      email: json['email'],
      password: json['password'],
      roleId: json['roleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'password': password,
      'roleId': roleId,
    };
  }
}
