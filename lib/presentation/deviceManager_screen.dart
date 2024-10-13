import 'package:flutter/material.dart';

class DeviceManagerScreen extends StatelessWidget {
  final List<Map<String, String>> devices = [
    {'name': 'Device 1', 'id': 'h1h1h1h1h1'},
    {'name': 'Device 2', 'id': 'h2h2h2h2h2'},
    {'name': 'Device 3', 'id': 'h3h3h3h3h3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Dispositivos'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                print('Agregar Dispositivo');
              },
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
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(devices[index]['name']!),
                      subtitle: Text('ID: ${devices[index]['id']}'),
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
