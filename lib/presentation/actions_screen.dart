import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/DeviceService.dart';
import '../Services/Service/DeviceActionService.dart';
import '../model/Device/Device.dart';
import 'dart:convert';


class ActionsScreen extends StatefulWidget {
  final String userId;

  ActionsScreen({required this.userId});

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  late DeviceService deviceService;
  late DeviceActionService deviceActionService;
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    deviceService = DeviceService(dio);
    deviceActionService = DeviceActionService(dio);
    _fetchDevices();
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

  Future<void> _updateDeviceQuantity(String deviceId, String type, double quantity) async {
    try {
      final payload = {
        "device_id": deviceId,
        "type": type,
        "quantity": quantity.toInt(),
        "action": "subtract",
      };

      // Serializa el payload a JSON
      final serializedPayload = jsonEncode(payload);
      print("Payload enviado: $serializedPayload");

      // Realiza la solicitud al servidor
      final updatedDevice = await deviceActionService.updateDeviceQuantity(payload);

      setState(() {
        final index = devices.indexWhere((d) => d.id == deviceId);
        if (index != -1) {
          devices[index] = updatedDevice;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dispositivo actualizado correctamente')),
      );
    } catch (e) {
      print('Error updating device quantity: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el dispositivo')),
      );
    }
  }


  void _showUpdateForm(String deviceId) {
    String? selectedType = "food"; // Valor inicial por defecto
    final _quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Actualizar Cantidad'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                items: [
                  DropdownMenuItem(value: "food", child: Text("Comida")),
                  DropdownMenuItem(value: "water", child: Text("Agua")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final quantity = double.tryParse(_quantityController.text);
                if (quantity == null || quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor ingresa una cantidad válida')),
                  );
                  return;
                }

                await _updateDeviceQuantity(deviceId, selectedType!, quantity);

                Navigator.of(context).pop();
              },
              child: Text('Dispensar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acciones por Dispositivo')),
      body: devices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Número de Serie: ${device.serial_number}'),
                  subtitle: Text('ID: ${device.id}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Comida: ${device.foodPercentage.toStringAsFixed(1)}%'),
                      Text('Agua: ${device.waterPercentage.toStringAsFixed(1)}%'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showUpdateForm(device.id);
                      },
                      child: Text('Actualizar'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
