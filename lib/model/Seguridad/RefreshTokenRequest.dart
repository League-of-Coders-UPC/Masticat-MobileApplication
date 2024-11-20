import 'package:json_annotation/json_annotation.dart';

part 'RefreshTokenRequest.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  final String refresh;

  RefreshTokenRequest({required this.refresh});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
