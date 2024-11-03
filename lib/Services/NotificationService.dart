import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Notification.dart';

class NotificationService {
  final String baseUrl = 'https://your-backend-url.com/api/notifications';

  Future<List<Notification>> getUserNotifications(String userUuid) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userUuid'));
    if (response.statusCode == 200) {
      List<dynamic> notificationsJson = json.decode(response.body);
      return notificationsJson.map((json) => Notification.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> createPetNotification(String userUuid) async {
    final notificationData = {
      'userUuid': userUuid,
      'notificationType': 'Pet',
      'message': 'Has añadido una nueva mascota a tu lista',
    };
    await _createNotification(notificationData);
  }

  Future<void> createDeviceNotification(String userUuid) async {
    final notificationData = {
      'userUuid': userUuid,
      'notificationType': 'Device',
      'message': 'Has añadido un nuevo dispositivo a tu equipo',
    };
    await _createNotification(notificationData);
  }

  Future<void> deleteNotification(String notificationUuid) async {
    final response = await http.delete(Uri.parse('$baseUrl/$notificationUuid'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification');
    }
  }

  Future<void> _createNotification(Map<String, dynamic> notificationData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(notificationData),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create notification');
    }
  }
}
