import 'package:flutter/material.dart';
import 'app_scaffold.dart';
import 'package:flutter/services.dart';
import '../model/Pet.dart';
import '../services/PetService.dart';

class AddPetDialog extends StatefulWidget {
  @override
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  String _species = 'Gato';

  final PetService _petService = PetService();
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _fetchPets();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  Future<void> _fetchPets() async {
    try {
      List<Pet> fetchedPets = await _petService.fetchPets();
      setState(() {
        pets = fetchedPets;
      });
    } catch (e) {
      _showErrorSnackBar('Error al cargar la lista de mascotas');
    }
  }

  Future<void> _addPet() async {
    if (_formKey.currentState!.validate()) {
      final newPet = Pet(
        uuid: '',
        userUuid: 'userUuid_placeholder',
        name: _nameController.text,
        breed: _breedController.text,
        species: _species,
        birthDate: DateTime.now().toString(),
        weight: double.tryParse(_weightController.text) ?? 0.0,
        age: int.tryParse(_ageController.text) ?? 0,
        imageUrl: '',
      );

      try {
        await _petService.createPet(newPet);
        setState(() {
          pets.add(newPet);
        });
        _clearForm();
        Navigator.pop(context);
      } catch (e) {
        _showErrorSnackBar('Error al crear la mascota');
      }
    }
  }

  Future<void> _deletePet(String petUuid) async {
    try {
      await _petService.deletePet(petUuid);
      setState(() {
        pets.removeWhere((pet) => pet.uuid == petUuid);
      });
    } catch (e) {
      _showErrorSnackBar('Error al eliminar la mascota');
    }
  }

  void _clearForm() {
    _nameController.clear();
    _weightController.clear();
    _ageController.clear();
    _breedController.clear();
    _species = 'Gato';
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showAddPetForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Nueva Mascota'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre'),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa el nombre de tu mascota',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Especie'),
                  DropdownButtonFormField<String>(
                    value: _species,
                    onChanged: (newValue) {
                      setState(() {
                        _species = newValue!;
                      });
                    },
                    items: ['Gato', 'Perro'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Selecciona la especie',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Peso (kg)'),
                  TextFormField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa el peso de la mascota',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa el peso';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Edad'),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa la edad de la mascota',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la edad';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Raza'),
                  TextFormField(
                    controller: _breedController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa la raza',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la raza';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: _addPet,
              child: Text('Agregar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 1,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mis Mascotas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddPetForm,
                  icon: Icon(Icons.add),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return PetCard(
                    petName: pet.name,
                    species: pet.species,
                    weight: pet.weight,
                    age: pet.age,
                    breed: pet.breed,
                    onDelete: () => _deletePet(pet.uuid),
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

class PetCard extends StatelessWidget {
  final String petName;
  final String species;
  final double weight;
  final int age;
  final String breed;
  final VoidCallback onDelete;

  PetCard({
    required this.petName,
    required this.species,
    required this.weight,
    required this.age,
    required this.breed,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.pets, size: 40, color: Colors.amber),
        title: Text(
          petName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('$species, $breed\nEdad: $age años, Peso: ${weight.toStringAsFixed(1)} kg'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
