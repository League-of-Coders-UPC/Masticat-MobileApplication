import 'dart:ui';
import 'package:flutter/material.dart';
import '../Services/DeviceService.dart';
import '../model/Device.dart';
import 'app_scaffold.dart';

class DeviceManagerScreen extends StatefulWidget {
  @override
  _DeviceManagerScreenState createState() => _DeviceManagerScreenState();
}

class _DeviceManagerScreenState extends State<DeviceManagerScreen> {
  final List<Device> devices = [];
  final DeviceService _deviceService = DeviceService();

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    try {
      List<Device> fetchedDevices = await _deviceService.fetchDevices();
      setState(() {
        devices.clear();
        devices.addAll(fetchedDevices);
      });
    } catch (e) {
      _showErrorSnackBar('Error al obtener dispositivos');
    }
  }

  void _showAddDeviceForm() {
    final _serialNumberController = TextEditingController();
    final _statusController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Agregar Dispositivo"),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  if (_serialNumberController.text.isNotEmpty && _statusController.text.isNotEmpty) {
                    Device newDevice = Device(
                      uuid: DateTime.now().millisecondsSinceEpoch.toString(),
                      petUuid: 'petUuid_placeholder',
                      serialNumber: _serialNumberController.text,
                      status: _statusController.text,
                    );
                    try {
                      await _deviceService.createDevice(newDevice);
                      setState(() {
                        devices.add(newDevice);
                      });
                      Navigator.of(context).pop();
                    } catch (e) {
                      _showErrorSnackBar('Error al agregar dispositivo');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Text("Agregar Dispositivo"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteDevice(String deviceId) async {
    try {
      await _deviceService.deleteDevice(deviceId);
      setState(() {
        devices.removeWhere((device) => device.uuid == deviceId);
      });
    } catch (e) {
      _showErrorSnackBar('Error al eliminar dispositivo');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 3,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showAddDeviceForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: Text('Agregar Dispositivo'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Dispositivo ${device.serialNumber}'),
                      subtitle: Text('ID: ${device.uuid} - Estado: ${device.status}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteDevice(device.uuid);
                        },
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
