import 'package:flutter/material.dart';
import 'package:masticat/presentation/dashboard_screen.dart';
import 'package:masticat/presentation/login_screen.dart';
import 'package:masticat/presentation/notification_screen.dart';
import 'package:masticat/presentation/profile.dart';
import 'package:masticat/presentation/addPett_screen.dart';
import 'package:masticat/presentation/deviceManager_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masticat App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        '/addPet': (context) => AddPetDialog(),
        '/deviceManager': (context) => DeviceManagerScreen(),
        '/notifications': (context) => NotificationsScreen(),
      },
    );
  }
}
