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
}
