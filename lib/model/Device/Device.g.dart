// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String,
      pet: Pet.fromJson(json['pet'] as Map<String, dynamic>),
      serial_number: json['serial_number'] as String,
      status: json['status'] as String,
      food_percentage: (json['food_percentage'] as num?)?.toInt(),
      water_percentage: (json['water_percentage'] as num?)?.toInt(),
      battery_percentage: (json['battery_percentage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'pet': instance.pet,
      'serial_number': instance.serial_number,
      'status': instance.status,
      'food_percentage': instance.food_percentage,
      'water_percentage': instance.water_percentage,
      'battery_percentage': instance.battery_percentage,
    };
