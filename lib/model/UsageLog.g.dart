// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UsageLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsageLog _$UsageLogFromJson(Map<String, dynamic> json) => UsageLog(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      logType: json['logType'] as String,
      quantity: (json['quantity'] as num).toInt(),
      time: DateTime.parse(json['time'] as String),
      duration: json['duration'] as String,
    );

Map<String, dynamic> _$UsageLogToJson(UsageLog instance) => <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'logType': instance.logType,
      'quantity': instance.quantity,
      'time': instance.time.toIso8601String(),
      'duration': instance.duration,
    };
