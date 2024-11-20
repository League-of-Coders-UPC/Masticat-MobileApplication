// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String,
      pet: Pet.fromJson(json['pet'] as Map<String, dynamic>),
      serialNumber: json['serialNumber'] as String,
      status: json['status'] as String,
      foodPercentage: (json['foodPercentage'] as num).toInt(),
      waterPercentage: (json['waterPercentage'] as num).toInt(),
      batteryPercentage: (json['batteryPercentage'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'pet': instance.pet,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'foodPercentage': instance.foodPercentage,
      'waterPercentage': instance.waterPercentage,
      'batteryPercentage': instance.batteryPercentage,
      'user': instance.user,
    };
