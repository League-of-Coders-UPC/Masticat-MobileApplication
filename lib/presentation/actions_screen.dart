import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/UsageLog.dart';
import '../model/Device/Device.dart';
import '../services/Service/UsageLogService.dart';
import '../services/Service/DeviceService.dart';
import 'app_scaffold.dart';

class ActionsScreen extends StatelessWidget {
  final String userId;

  ActionsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 2,
      body: Center(child: Text('Acciones para el usuario: $userId')),
      userId: userId,
    );
  }
}

