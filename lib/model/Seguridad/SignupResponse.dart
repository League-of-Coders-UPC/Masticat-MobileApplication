import 'package:json_annotation/json_annotation.dart';

part 'SignupResponse.g.dart';

@JsonSerializable()
class SignupResponse {
  final String message;
  final User user;

  SignupResponse({required this.message, required this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class User {
  final String username;
  final String email;
  final String role;

  User({required this.username, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
