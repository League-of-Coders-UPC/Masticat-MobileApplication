import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Device.dart';

class DeviceService {
  final String baseUrl = 'https://your-backend-url.com/api/devices';

  // Listar todos los dispositivos
  Future<List<Device>> fetchDevices() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((deviceJson) => Device.fromJson(deviceJson)).toList();
    } else {
      throw Exception('Error al cargar la lista de dispositivos');
    }
  }

  // Crear un nuevo dispositivo
  Future<void> createDevice(Device device) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(device.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el dispositivo');
    }
  }

  // Eliminar un dispositivo
  Future<void> deleteDevice(String deviceUuid) async {
    final response = await http.delete(Uri.parse('$baseUrl/$deviceUuid'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el dispositivo');
    }
  }
}
