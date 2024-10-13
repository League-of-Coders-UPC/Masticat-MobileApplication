import 'package:flutter/material.dart';
import 'package:masticat/presentation/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Masticat',
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontWeight: FontWeight.w400,
            fontSize: 40.0,
            letterSpacing: -0.29,
            color: Color(0xFF1E0E62),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Batería',
                      icon: Icons.battery_charging_full,
                      percentage: '44%',
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: StatCard(
                      title: 'Comida',
                      icon: Icons.restaurant,
                      percentage: '50%',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Agua',
                      icon: Icons.water,
                      percentage: '9%',
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/deviceManager');
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 40),
                            Text('Agregar Dispositivo'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),


              Card(
                child: ListTile(
                  title: Text('Hábitos de Alimentación'),
                  subtitle: Placeholder(fallbackHeight: 100),
                ),
              ),
              SizedBox(height: 20),

              // Cámara en Vivo
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Cámara en Vivo'),
                      subtitle: Image.asset(
                        'lib/images/catcam.gif',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),


              ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Agregar Mascota'),
                onPressed: () {
                  Navigator.pushNamed(context, '/addPet');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
              ),
              SizedBox(height: 20),

              // Lista de mascotas
              Column(
                children: [
                  PetCard(petName: 'Luna', age: 3, weight: 5.5, imagePath: 'lib/images/cardluna.jpeg'),
                  PetCard(petName: 'Charlie', age: 2, weight: 7.0, imagePath: ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String percentage;

  StatCard({required this.title, required this.icon, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(percentage, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String petName;
  final int age;
  final double weight;
  final String imagePath;

  PetCard({required this.petName, required this.age, required this.weight, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: imagePath.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            imagePath,
            width: 80,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
            : Icon(Icons.pets),
        title: Text(petName),
        subtitle: Text('$age años, $weight KG'),
      ),
    );
  }
}

