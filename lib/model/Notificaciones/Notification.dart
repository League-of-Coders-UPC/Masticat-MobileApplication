import 'package:json_annotation/json_annotation.dart';

part 'Notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String userId;
  final String type;
  final String message;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
