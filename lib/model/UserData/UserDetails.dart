import 'package:json_annotation/json_annotation.dart';
import 'User.dart';

part 'UserDetails.g.dart';

@JsonSerializable()
class UserDetails {
  final int id;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'birth_date')
  final String birthDate;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  UserDetails({
    required this.id,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
