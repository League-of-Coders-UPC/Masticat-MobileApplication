class UserDetails {
  final String userUuid;
  final String firstName;
  final String lastName;
  final String? birthDate; // Opcional
  final String phoneNumber;
  final String? imageUrl; // Opcional
  final String email;
  final String password;

  UserDetails({
    required this.userUuid,
    required this.firstName,
    required this.lastName,
    this.birthDate, // Ya no es requerido
    required this.phoneNumber,
    this.imageUrl, // Ya no es requerido
    required this.email,
    required this.password,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userUuid: json['userUuid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'], // Opcional
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'], // Opcional
      email: json['email'],
      password: json['password'],
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
      'email': email,
      'password': password,
    };
  }

  UserDetails copyWith({
    String? userUuid,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? phoneNumber,
    String? imageUrl,
    String? email,
    String? password,
  }) {
    return UserDetails(
      userUuid: userUuid ?? this.userUuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
