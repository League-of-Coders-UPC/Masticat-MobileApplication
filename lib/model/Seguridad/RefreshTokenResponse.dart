import 'package:json_annotation/json_annotation.dart';

part 'RefreshTokenResponse.g.dart';

@JsonSerializable()
class RefreshTokenResponse {
  final String access;

  RefreshTokenResponse({required this.access});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
