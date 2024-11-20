import 'package:json_annotation/json_annotation.dart';

import '../Pet/Pet.dart';
import '../UserData/User.dart';

part 'Habit.g.dart';

@JsonSerializable()
class Habit {
  final String uuid;
  final Pet pet;
  final User user;
  final int waterConsumption;
  final int foodConsumption;
  final String startDate;
  final String endDate;

  Habit({
    required this.uuid,
    required this.pet,
    required this.user,
    required this.waterConsumption,
    required this.foodConsumption,
    required this.startDate,
    required this.endDate,
  });

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
