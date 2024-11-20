// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      uuid: json['uuid'] as String,
      pet: Pet.fromJson(json['pet'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      waterConsumption: (json['waterConsumption'] as num).toInt(),
      foodConsumption: (json['foodConsumption'] as num).toInt(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'pet': instance.pet,
      'user': instance.user,
      'waterConsumption': instance.waterConsumption,
      'foodConsumption': instance.foodConsumption,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
