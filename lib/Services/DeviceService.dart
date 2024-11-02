import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Device.dart';
import 'NotificationService.dart';

class DeviceService {
  final String baseUrl = 'https://your-backend-url.com/api/devices';
  final NotificationService _notificationService = NotificationService();

  // Método para obtener la lista de dispositivos
  Future<List<Device>> fetchDevices() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((deviceJson) => Device.fromJson(deviceJson)).toList();
    } else {
      throw Exception('Error al cargar la lista de dispositivos');
    }
  }

  // Método para crear un dispositivo
  Future<void> createDevice(Device device) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(device.toJson()),
    );

    if (response.statusCode == 201) {
      // Crear una notificación cuando se añade un dispositivo
      await _notificationService.createDeviceNotification('userUuid_placeholder');
    } else {
      throw Exception('Error al crear el dispositivo');
    }
  }

  // Método para eliminar un dispositivo
  Future<void> deleteDevice(String deviceUuid) async {
    final response = await http.delete(Uri.parse('$baseUrl/$deviceUuid'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el dispositivo');
    }
  }
}
