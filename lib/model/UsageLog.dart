import 'package:json_annotation/json_annotation.dart';

part 'UsageLog.g.dart';

@JsonSerializable()
class UsageLog {
  final String id;
  final String deviceId;
  final String logType;
  final int quantity;
  final DateTime time;
  final String duration;

  UsageLog({
    required this.id,
    required this.deviceId,
    required this.logType,
    required this.quantity,
    required this.time,
    required this.duration,
  });

  factory UsageLog.fromJson(Map<String, dynamic> json) => _$UsageLogFromJson(json);

  Map<String, dynamic> toJson() => _$UsageLogToJson(this);
}
