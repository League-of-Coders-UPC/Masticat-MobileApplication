// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignupRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      birth_date: json['birth_date'] as String,
      phone_number: json['phone_number'] as String,
      image_url: json['image_url'] as String,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'birth_date': instance.birth_date,
      'phone_number': instance.phone_number,
      'image_url': instance.image_url,
    };
