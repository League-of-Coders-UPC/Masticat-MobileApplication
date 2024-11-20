// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      id: json['id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      name: json['name'] as String,
      breed: json['breed'] as String,
      species: json['species'] as String,
      birthDate: json['birth_date'] as String,
      weight: (json['weight'] as num).toInt(),
      age: (json['age'] as num).toInt(),
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'breed': instance.breed,
      'species': instance.species,
      'birth_date': instance.birthDate,
      'weight': instance.weight,
      'age': instance.age,
      'image_url': instance.image_url,
    };
