class UsageLog {
  final String uuid;
  final String deviceUuid;
  final String type;
  final int quantity;
  final String time;
  final int duration;

  UsageLog({
    required this.uuid,
    required this.deviceUuid,
    required this.type,
    required this.quantity,
    required this.time,
    required this.duration,
  });

  factory UsageLog.fromJson(Map<String, dynamic> json) {
    return UsageLog(
      uuid: json['uuid'],
      deviceUuid: json['deviceUuid'],
      type: json['type'],
      quantity: json['quantity'],
      time: json['time'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'deviceUuid': deviceUuid,
      'type': type,
      'quantity': quantity,
      'time': time,
      'duration': duration,
    };
  }
}
