import 'package:flutter/material.dart';
import '../Services/NotificationService.dart';
import '../model/Notification.dart' as CustomNotification;
import 'app_scaffold.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationService _notificationService = NotificationService();
  List<CustomNotification.Notification> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final userUuid = 'userUuid_placeholder';
    try {
      List<CustomNotification.Notification> notifications =
      await _notificationService.getUserNotifications(userUuid);
      setState(() {
        _notifications = notifications;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar notificaciones')),
      );
    }
  }

  Future<void> _deleteNotification(String notificationUuid) async {
    try {
      await _notificationService.deleteNotification(notificationUuid);
      setState(() {
        _notifications.removeWhere((n) => n.uuid == notificationUuid);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notificación eliminada')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar notificación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 2,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(notification.icon, color: Colors.amber, size: 30),
                      title: Text(
                        notification.message,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E0E62),
                        ),
                      ),
                      subtitle: notification.createdAt != null
                          ? Text(
                        'Fecha: ${notification.createdAt}',
                        style: TextStyle(color: Colors.grey),
                      )
                          : null,
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNotification(notification.uuid),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
