import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/Service/NotificationService.dart';
import '../model/Notificaciones/Notification.dart' as ModelNotification;

import 'app_scaffold.dart';

class NotificationsScreen extends StatelessWidget {
  final String userId;

  NotificationsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notificaciones')),
      body: Center(child: Text('Notificaciones del usuario: $userId')),
    );
  }
}

