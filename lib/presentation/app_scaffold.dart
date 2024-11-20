import 'package:flutter/material.dart';
import 'addPett_screen.dart';
import 'dashboard_screen.dart';
import 'actions_screen.dart';
import 'deviceManager_screen.dart';
import 'profile.dart';
import 'notification_screen.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final String userId;

  AppScaffold({required this.body, required this.userId, required int currentIndex});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0; // Variable interna para manejar el índice

  // Este método se llamará cuando se toque un ítem en el BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;  // Actualiza el índice
    });

    // Usamos Navigator.push para no reemplazar la pila de navegación
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(userId: widget.userId)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActionsScreen(userId: widget.userId)),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceManagerScreen(userId: widget.userId)),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetScreen(userId: widget.userId)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Masticat',
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontWeight: FontWeight.w400,
            fontSize: 40.0,
            color: Color(0xFF1E0E62),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.grey),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId)),
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.grey),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsScreen(userId: widget.userId)),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      body: widget.body,  // Aquí se coloca el body que se pasa al AppScaffold
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Acciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
          ),
        ],
        currentIndex: _currentIndex,  // Usamos la variable interna _currentIndex
        onTap: _onItemTapped,  // Llama a _onItemTapped cuando un ítem es tocado
      ),
    );
  }
}
