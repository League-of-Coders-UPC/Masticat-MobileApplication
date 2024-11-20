import 'package:json_annotation/json_annotation.dart';

import '../UserData/User.dart';

part 'Pet.g.dart';

@JsonSerializable()
class Pet {
  final String id;
  @JsonKey(name: 'user')
  final User user;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'breed')
  final String breed;
  @JsonKey(name: 'species')
  final String species;
  @JsonKey(name: 'birth_date')
  final String birthDate;
  @JsonKey(name: 'weight')
  final int weight;
  @JsonKey(name: 'age')
  final int age;
  @JsonKey(name: 'image_url')
  final String? image_url;

  Pet({
    required this.id,
    required this.user,
    required this.name,
    required this.breed,
    required this.species,
    required this.birthDate,
    required this.weight,
    required this.age,
    this.image_url,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
}
