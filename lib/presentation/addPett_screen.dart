import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPetDialog extends StatefulWidget {
  @override
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _nameController = TextEditingController();
  String _species = 'Cat';
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      print('Pet added');

      print('Name: ${_nameController.text}');
      print('Species: $_species');
      print('Weight: ${_weightController.text}');
      print('Age: ${_ageController.text}');
      print('Breed: ${_breedController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet',
            style: TextStyle(
              fontFamily: 'Satisfy',
              fontWeight: FontWeight.w400,
              fontSize: 40.0,
              letterSpacing: -0.29,
              color: Color(0xFF1E0E62),
            )
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name'),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your pet\'s name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),


              Text('Race'),
              DropdownButtonFormField<String>(
                value: _species,
                onChanged: (newValue) {
                  setState(() {
                    _species = newValue!;
                  });
                },
                items: ['Cat', 'Dog'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  hintText: 'Select species',
                ),
              ),
              SizedBox(height: 20),


              Text('Weight (kg)'),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  hintText: 'Enter pet\'s weight',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),


              Text('Age'),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'Enter pet\'s age',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),


              Text('Species'),
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(
                  hintText: 'Enter breed',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the breed';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      print('Add Photo');
                    },
                    child: Text('Add Photo'),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Add Pet'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
