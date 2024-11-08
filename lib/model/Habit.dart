class Habit {
  final String uuid;
  final String petUuid;
  final int waterConsumption;
  final int foodConsumption;
  final String startDate;
  final String endDate;

  Habit({
    required this.uuid,
    required this.petUuid,
    required this.waterConsumption,
    required this.foodConsumption,
    required this.startDate,
    required this.endDate,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      uuid: json['uuid'],
      petUuid: json['petUuid'],
      waterConsumption: json['waterConsumption'],
      foodConsumption: json['foodConsumption'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'petUuid': petUuid,
      'waterConsumption': waterConsumption,
      'foodConsumption': foodConsumption,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
