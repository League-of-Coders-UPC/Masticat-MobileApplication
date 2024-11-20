import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/DeviceService.dart';
import '../Services/Service/PetService.dart';
import '../model/Device/Device.dart';
import '../model/Pet/Pet.dart';
import 'app_scaffold.dart';

class DeviceManagerScreen extends StatefulWidget {
  final String userId;

  DeviceManagerScreen({required this.userId});

  @override
  _DeviceManagerScreenState createState() => _DeviceManagerScreenState();
}

class _DeviceManagerScreenState extends State<DeviceManagerScreen> {
  List<Device> devices = [];
  List<Pet> pets = [];

  late  DeviceService deviceService;
  late  PetService petService;

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    deviceService = DeviceService(dio);
    petService = PetService(dio);
    _fetchPets();
    _fetchDevices();
  }

  Future<void> _fetchPets() async {
    try {
      final fetchedPets = await petService.getPets();
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


  Future<void> _fetchDevices() async {
    try {
      final allDevices = await deviceService.getDevice();
      print(allDevices);
      final userDevices = allDevices.where((device) => device.pet.id == widget.userId).toList();

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

  void _showDeviceForm({Device? device}) {
    final _serialNumberController = TextEditingController(
      text: device?.serial_number ?? '',
    );
    final _statusController = TextEditingController(
      text: device?.status ?? '',
    );
    Pet? selectedPet = device?.pet;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(device == null ? 'Agregar Dispositivo' : 'Editar Dispositivo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<Pet>(
                  value: selectedPet,
                  items: pets.map((pet) {
                    return DropdownMenuItem(
                      value: pet,
                      child: Text(pet.name),
                    );
                  }).toList(),
                  onChanged: (pet) {
                    setState(() {
                      selectedPet = pet!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Seleccionar Mascota',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _serialNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número de Serie',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (selectedPet == null ||
                    _serialNumberController.text.isEmpty ||
                    _statusController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor completa los campos requeridos')),
                  );
                  return;
                }

                final payload = {
                  'pet_id': '"${selectedPet!.id}"',
                  'serial_number': '"${_serialNumberController.text}"',
                  'status': '"${_statusController.text}"',
                };

                print('Payload enviado: $payload');

                try {
                  if (device == null) {
                    await deviceService.addDevice(payload);
                  } else {
                    await deviceService.patchDevice(device.id, payload);
                  }
                  Navigator.of(context).pop();
                  _fetchDevices();
                } catch (e) {
                  print('Error saving device: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al guardar el dispositivo')),
                  );
                }

                print('Datos enviados Device: $payload');
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteDevice(String deviceId) async {
    try {
      await deviceService.deleteDevice(deviceId);
      setState(() {
        devices.removeWhere((device) => device.id == deviceId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dispositivo eliminado exitosamente')),
      );
    } catch (e) {
      print('Error deleting device: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar dispositivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 3,
      userId: widget.userId,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showDeviceForm(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: Text('Agregar Dispositivo'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: devices.isEmpty
                  ? Center(child: Text('No hay dispositivos registrados.'))
                  : ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Dispositivo: ${device.serial_number}'),
                      subtitle: Text('Mascota: ${device.pet.name}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showDeviceForm(device: device),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteDevice(device.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
