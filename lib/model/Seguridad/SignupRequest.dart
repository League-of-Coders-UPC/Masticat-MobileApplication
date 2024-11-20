import 'package:json_annotation/json_annotation.dart';

part 'SignupRequest.g.dart';

@JsonSerializable()
class SignupRequest {
  final String username;
  final String email;
  final String password;
  final String role;
  @JsonKey(name: 'first_name')
  final String first_name;
  @JsonKey(name: 'last_name')
  final String last_name;
  @JsonKey(name: 'birth_date')
  final String birth_date;
  @JsonKey(name: 'phone_number')
  final String phone_number;
  @JsonKey(name: 'image_url')
  final String image_url;

  SignupRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.first_name,
    required this.last_name,
    required this.birth_date,
    required this.phone_number,
    required this.image_url,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
