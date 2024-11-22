import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/DeviceService.dart';
import '../Services/Service/PetService.dart';
import '../model/Device/Device.dart';
import '../model/Pet/Pet.dart';
import 'app_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DeviceService deviceService;
  late PetService petService;
  List<Device> devices = [];
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    deviceService = DeviceService(dio);
    petService = PetService(dio);
    _fetchDevices();
    _fetchPets();
  }

  Future<void> _fetchDevices() async {
    try {
      final allDevices = await deviceService.getUserDeviceByQuery(widget.userId);
      setState(() {
        devices = allDevices;
      });
    } catch (e) {
      print('Error fetching devices: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener los dispositivos')),
      );
    }
  }

  Future<void> _fetchPets() async {
    try {
      final fetchedPets = await petService.getPets();
      final userPets = fetchedPets.where((pet) => pet.user.id == widget.userId).toList();
      setState(() {
        pets = userPets;
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
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.dashboard,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Bienvenido a tu tablero",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Usuario ID: ${widget.userId}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Mascotas
            Text(
              "Tus Mascotas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            pets.isNotEmpty
                ? Wrap(
              spacing: 10,
              runSpacing: 10,
              children: pets.map((pet) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          pet.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ID: ${pet.id}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                : Center(
              child: Text(
                "No tienes mascotas registradas.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),

            // Dispositivos
            Text(
              "Tus Dispositivos IoT",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            devices.isNotEmpty
                ? Wrap(
              spacing: 10,
              runSpacing: 10,
              children: devices.map((device) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Dispositivo: ${device.serial_number}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPercentageIndicator(
                              label: "Comida",
                              percentage: device.foodPercentage,
                              color: Colors.redAccent,
                            ),
                            _buildPercentageIndicator(
                              label: "Agua",
                              percentage: device.waterPercentage,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                : Center(
              child: Text(
                "No tienes dispositivos registrados.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageIndicator({required String label, required double percentage, required Color color}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 6,
                color: color,
                backgroundColor: color.withOpacity(0.2),
              ),
            ),
            Text(
              "${percentage.toStringAsFixed(0)}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
