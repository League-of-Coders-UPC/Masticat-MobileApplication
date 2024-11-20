import 'package:json_annotation/json_annotation.dart';

import '../Pet/Pet.dart';
import '../UserData/User.dart';

part 'Device.g.dart';

@JsonSerializable()
class Device {
  final String id;
  @JsonKey(name: 'pet')
  final Pet pet;
  @JsonKey(name: 'serial_number')
  final String serial_number;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'food_percentage')
  final int? food_percentage;
  @JsonKey(name: 'water_percentage')
  final int? water_percentage;
  @JsonKey(name: 'battery_percentage')
  final int? battery_percentage;

  Device({
    required this.id,
    required this.pet,
    required this.serial_number,
    required this.status,
    this.food_percentage,
    this.water_percentage,
    this.battery_percentage,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
