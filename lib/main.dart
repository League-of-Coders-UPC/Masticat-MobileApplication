import 'package:flutter/material.dart';
import 'package:masticat/presentation/dashboard_screen.dart';
import 'package:masticat/presentation/login_screen.dart';
import 'package:masticat/presentation/notification_screen.dart';
import 'package:masticat/presentation/profile.dart';
import 'package:masticat/presentation/addPett_screen.dart';
import 'package:masticat/presentation/deviceManager_screen.dart';
import 'package:masticat/presentation/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masticat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        // Ruta dinámica para manejar el userId y otras configuraciones
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/dashboard':
            final args = settings.arguments as Map<String, dynamic>?; // Extraemos argumentos
            final userId = args?['userId'] ?? ''; // Pasamos el userId
            return MaterialPageRoute(builder: (context) => DashboardScreen(userId: userId));
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>?; // Extraemos argumentos
            final userId = args?['userId'] ?? ''; // Pasamos el userId
            return MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId));
          case '/addPet':
            final args = settings.arguments as Map<String, dynamic>?; // Extraemos argumentos
            final userId = args?['userId'] ?? ''; // Pasamos el userId
            return MaterialPageRoute(builder: (context) => PetScreen(userId: userId));
          case '/deviceManager':
            final args = settings.arguments as Map<String, dynamic>?; // Extraemos argumentos
            final userId = args?['userId'] ?? ''; // Pasamos el userId
            return MaterialPageRoute(builder: (context) => DeviceManagerScreen(userId: userId));
          case '/notifications':
            final args = settings.arguments as Map<String, dynamic>?; // Extraemos argumentos
            final userId = args?['userId'] ?? ''; // Pasamos el userId
            return MaterialPageRoute(builder: (context) => NotificationsScreen(userId: userId));
          case '/register':
            return MaterialPageRoute(builder: (context) => SignUpScreen());
          default:
            return MaterialPageRoute(builder: (context) => LoginScreen());
        }
      },
    );
  }
}
