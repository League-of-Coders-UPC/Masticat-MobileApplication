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

  final int? food_quantity;
  final int? water_quantity;
  final int? food_limit;
  final int? water_limit;

  Device({
    required this.id,
    required this.pet,
    required this.serial_number,
    required this.status,
    this.food_percentage,
    this.water_percentage,
    this.food_quantity,
    this.water_quantity,
    this.food_limit,
    this.water_limit,
    this.battery_percentage,
  });


  double get foodPercentage {
    if (food_quantity != null && food_limit != null && food_limit! > 0) {
      return (food_quantity! / food_limit!) * 100;
    }
    return 0;
  }


  double get waterPercentage {
    if (water_quantity != null && water_limit != null && water_limit! > 0) {
      return (water_quantity! / water_limit!) * 100;
    }
    return 0;
  }


  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
