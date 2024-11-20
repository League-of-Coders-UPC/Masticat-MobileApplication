import 'package:json_annotation/json_annotation.dart';

import '../Role.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'role')
  final Role role;  // Añadido el campo role

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,  // Asegúrate de incluir el role aquí
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

