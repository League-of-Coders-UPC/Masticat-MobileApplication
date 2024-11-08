class Notification {
  final String uuid;
  final String userUuid;
  final String notificationType;
  final String message;
  final String createdAt;

  Notification({
    required this.uuid,
    required this.userUuid,
    required this.notificationType,
    required this.message,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      notificationType: json['notificationType'],
      message: json['message'],
      createdAt: json['createdAt'],
    );
  }
}
