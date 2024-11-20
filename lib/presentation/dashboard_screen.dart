import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/Pet/Pet.dart';
import '../services/Service/PetService.dart';
import 'app_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://animal-shelter-p65z.onrender.com/api",
    connectTimeout: Duration.zero,
    receiveTimeout: Duration.zero,
  ));

  late final PetService _petService = PetService(dio);
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _fetchPets();
  }

  // Fetch pets from the service
  Future<void> _fetchPets() async {
    try {
      final fetchedPets = await _petService.getPets();
      final userPets = fetchedPets.where((pet) => pet.user.id == widget.userId).toList();

      setState(() {
        pets.clear();
        pets.addAll(userPets);
      });
    } catch (e) {
      print('Error fetching pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener las mascotas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 0,
      userId: widget.userId,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Título del dashboard
            Text(
              'Mascotas Registradas para el usuario: ${widget.userId}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Lista de Mascotas
            if (pets.isNotEmpty)
              Column(
                children: pets.map((pet) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Mascota: ${pet.name}'),
                      subtitle: Text('ID: ${pet.id}'),
                    ),
                  );
                }).toList(),
              ),
            if (pets.isEmpty)
              Center(
                child: Text('No tienes mascotas registradas.', style: TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}
