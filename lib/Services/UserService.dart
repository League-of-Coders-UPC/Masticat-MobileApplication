import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/UserDetails.dart';

class UserProfileService {
  final String baseUrl = 'https://your-backend-url.com/api/users';
  Future<UserDetails> getUserDetails(String userUuid) async {
    final response = await http.get(Uri.parse('$baseUrl/$userUuid'));

    if (response.statusCode == 200) {
      return UserDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener los detalles del usuario');
    }
  }

  // Actualizar los detalles del usuario
  Future<void> updateUser(UserDetails user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.userUuid}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el perfil del usuario');
    }
  }

  // Eliminar usuario por ID
  Future<void> deleteUser(String userUuid) async {
    final response = await http.delete(Uri.parse('$baseUrl/$userUuid'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }
}
