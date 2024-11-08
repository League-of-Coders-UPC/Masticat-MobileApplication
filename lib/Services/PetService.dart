import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Pet.dart';

class PetService {
  final String baseUrl = 'https://your-backend-url.com/api/pets';

  // Listar todas las mascotas
  Future<List<Pet>> fetchPets() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((petJson) => Pet.fromJson(petJson)).toList();
    } else {
      throw Exception('Error al cargar la lista de mascotas');
    }
  }

  // Crear una nueva mascota
  Future<void> createPet(Pet pet) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la mascota');
    }
  }

  // Actualizar los detalles de una mascota
  Future<void> updatePet(Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${pet.uuid}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la mascota');
    }
  }

  // Eliminar una mascota
  Future<void> deletePet(String petUuid) async {
    final response = await http.delete(Uri.parse('$baseUrl/$petUuid'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la mascota');
    }
  }
}
