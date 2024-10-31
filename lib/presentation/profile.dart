import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 1,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/default-profile.png'), // Cambia la ruta según tu imagen
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nombre de Usuario',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'correo@ejemplo.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text('Nombre'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa tu nombre',
              ),
            ),
            SizedBox(height: 16),
            Text('Apellido'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa tu apellido',
              ),
            ),
            SizedBox(height: 16),
            Text('País'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa tu país',
              ),
            ),
            SizedBox(height: 16),
            Text('Género'),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                DropdownMenuItem(value: 'Otro', child: Text('Otro')),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Selecciona tu género',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
