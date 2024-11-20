import 'package:json_annotation/json_annotation.dart';

import '../Pet/Pet.dart';
import '../UserData/User.dart';

part 'Device.g.dart';

@JsonSerializable()
class Device {
  final String id;
  final Pet pet;
  final User user;
  final String serialNumber;
  final String status;
  final int? foodPercentage;
  final int? waterPercentage;
  final int? batteryPercentage;

  Device({
    required this.id,
    required this.pet,
    required this.user,
    required this.serialNumber,
    required this.status,
    this.foodPercentage,
    this.waterPercentage,
    this.batteryPercentage,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
