import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class NotificationsScreen extends StatelessWidget {
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
            NotificationCard(
              icon: Icons.battery_alert,
              iconColor: Colors.red,
              title: 'Batería Baja',
              subtitle: 'Conecta el dispensador, por favor.',
            ),
            SizedBox(height: 16),
            NotificationCard(
              icon: Icons.water_drop,
              iconColor: Colors.blue,
              title: 'Agua Baja',
              subtitle: 'Agrega más agua, por favor.',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const NotificationCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1E0E62),
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
