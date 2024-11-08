class Subscription {
  final String uuid;
  final String userUuid;
  final String planType;
  final String startDate;
  final String endDate;
  final String status;

  Subscription({
    required this.uuid,
    required this.userUuid,
    required this.planType,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      planType: json['planType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'userUuid': userUuid,
      'planType': planType,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }
}
