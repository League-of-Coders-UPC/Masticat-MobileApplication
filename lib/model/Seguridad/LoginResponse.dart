import 'package:json_annotation/json_annotation.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  final String refresh;
  final String access;

  LoginResponse({
    required this.refresh,
    required this.access,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['refresh'] == null || json['access'] == null) {
      throw Exception('Error: "refresh" o "access" no pueden ser nulos.');
    }
    return LoginResponse(
      refresh: json['refresh'] as String,
      access: json['access'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
