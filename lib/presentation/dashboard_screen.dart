import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 0,
      body: SingleChildScrollView(
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
                  MouseRegion(
                    onEnter: (_) {},
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Apagar Cámara',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.amber,
                      ),
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
            Text(
              'Mis Mascotas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                PetCard(petName: 'Luna', age: 3, weight: 5.5, imagePath: 'lib/images/cardluna.jpeg'),
                PetCard(petName: 'Charlie', age: 2, weight: 7.0, imagePath: ''),
              ],
            ),
          ],
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
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.amber),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E0E62),
              ),
            ),
            SizedBox(height: 10),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E0E62),
              ),
            ),
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
            : Icon(Icons.pets, size: 40),
        title: Text(
          petName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('$age años, $weight KG'),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
          },
        ),
      ),
    );
  }
}
