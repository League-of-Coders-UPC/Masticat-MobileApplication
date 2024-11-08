class Pet {
  final String uuid;
  final String userUuid;
  final String name;
  final String breed;
  final String species;
  final String birthDate;
  final double weight;
  final int age;
  final String imageUrl;

  Pet({
    required this.uuid,
    required this.userUuid,
    required this.name,
    required this.breed,
    required this.species,
    required this.birthDate,
    required this.weight,
    required this.age,
    required this.imageUrl,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      name: json['name'],
      breed: json['breed'],
      species: json['species'],
      birthDate: json['birthDate'],
      weight: json['weight'],
      age: json['age'],
      imageUrl: json['imageUrl'],
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
