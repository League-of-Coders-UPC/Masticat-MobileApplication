import 'package:flutter/material.dart';

class Notification {
  final String uuid;
  final String userUuid;
  final String notificationType;
  final String message;
  final String? createdAt; // Ahora es opcional

  Notification({
    required this.uuid,
    required this.userUuid,
    required this.notificationType,
    required this.message,
    this.createdAt, // Ya no es requerido
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      uuid: json['uuid'],
      userUuid: json['userUuid'],
      notificationType: json['notificationType'],
      message: json['message'],
      createdAt: json['createdAt'], // Ya no es requerido
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'userUuid': userUuid,
      'notificationType': notificationType,
      'message': message,
      'createdAt': createdAt,
    };
  }

  IconData get icon {
    switch (notificationType) {
      case 'Device':
        return Icons.devices;
      case 'Pet':
        return Icons.pets;
      default:
        return Icons.notification_important;
    }
  }
}
