// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      id: (json['id'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      birthDate: json['birth_date'] as String,
      phoneNumber: json['phone_number'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birth_date': instance.birthDate,
      'phone_number': instance.phoneNumber,
      'image_url': instance.imageUrl,
    };
