class Pet {
  final String uuid;
  final String userUuid;
  final String name;
  final String? breed; // Ahora es opcional
  final String species;
  final String? birthDate; // Ahora es opcional
  final double weight;
  final int age;
  final String? imageUrl; // Ahora es opcional

  Pet({
    required this.uuid,
    required this.userUuid,
    required this.name,
    this.breed, // Ya no es requerido
    required this.species,
    this.birthDate, // Ya no es requerido
    required this.weight,
    required this.age,
    this.imageUrl, // Ya no es requerido
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      name: json['name'],
      breed: json['breed'], // Ya no es requerido
      species: json['species'],
      birthDate: json['birthDate'], // Ya no es requerido
      weight: json['weight'],
      age: json['age'],
      imageUrl: json['imageUrl'], // Ya no es requerido
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'userUuid': userUuid,
      'name': name,
      'breed': breed,
      'species': species,
      'birthDate': birthDate,
      'weight': weight,
      'age': age,
      'imageUrl': imageUrl,
    };
  }
}
