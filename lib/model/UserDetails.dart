class UserDetails {
  final String userUuid;
  final String firstName;
  final String lastName;
  final String? birthDate; // Ahora es opcional
  final String phoneNumber;
  final String? imageUrl; // Ahora es opcional

  UserDetails({
    required this.userUuid,
    required this.firstName,
    required this.lastName,
    this.birthDate, // Ya no es requerido
    required this.phoneNumber,
    this.imageUrl, // Ya no es requerido
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userUuid: json['userUuid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'], // Ya no es requerido
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'], // Ya no es requerido
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUuid': userUuid,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }

  UserDetails copyWith({
    String? userUuid,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? phoneNumber,
    String? imageUrl,
  }) {
    return UserDetails(
      userUuid: userUuid ?? this.userUuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
