import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/DeviceService.dart';
import '../model/Device/Device.dart';
import '../model/Pet/Pet.dart';
import '../Services/Service/PetService.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Masticat Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Bienvenido a tu tablero Masticat 🐾",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              "Usuario ID: ${widget.userId}",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),

            // Lista de Mascotas
            Text(
              "Tus Mascotas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ID: ${pet.id}',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
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

            // Lista de Dispositivos
            Text(
              "Tus Dispositivos IoT",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            devices.isNotEmpty
                ? Wrap(
              spacing: 10,
              runSpacing: 10,
              children: devices.map((device) {
                return _buildDeviceCard(device);
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

  Widget _buildDeviceCard(Device device) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Títulos
            Text(
              "Device: ${device.serial_number}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Porcentaje de Comida
                _buildPercentageIndicator(
                  label: "Food",
                  percentage: device.foodPercentage,
                  color: Colors.redAccent,
                ),
                // Porcentaje de Agua
                _buildPercentageIndicator(
                  label: "Water",
                  percentage: device.waterPercentage,
                  color: Colors.blueAccent,
                ),
              ],
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
