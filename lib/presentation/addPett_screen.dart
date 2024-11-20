import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/PetService.dart';
import '../model/Pet/Pet.dart';

class PetScreen extends StatefulWidget {
  final String userId;

  PetScreen({required this.userId});

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  List<Pet> pets = [];
  late PetService petService;

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    petService = PetService(dio);
    _fetchPets(); // Obtén la lista inicial de mascotas
  }

  // Obtener la lista de mascotas según el user_id
  Future<void> _fetchPets() async {
    try {
      final allPets = await petService.getPets();
      final userPets = allPets.where((pet) => pet.user.id == widget.userId).toList();
      setState(() {
        pets = userPets;
      });
    } catch (e) {
      print('Error fetching pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar la lista de mascotas')),
      );
    }
  }

  // Agregar una nueva mascota
  Future<void> _addPet() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrUpdatePetScreen(
          userId: widget.userId,
        ),
      ),
    );

    if (result == true) {
      _fetchPets(); // Refresca la lista después de agregar
    }
  }

  // Actualizar una mascota existente
  Future<void> _updatePet(Pet pet) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrUpdatePetScreen(
          userId: widget.userId,
          pet: pet,
        ),
      ),
    );

    if (result == true) {
      _fetchPets(); // Refresca la lista después de actualizar
    }
  }

  // Eliminar una mascota
  Future<void> _deletePet(String petId) async {
    try {
      await petService.deletePet(petId, widget.userId);
      setState(() {
        pets.removeWhere((pet) => pet.id == petId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mascota eliminada')),
      );
    } catch (e) {
      print('Error deleting pet: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la mascota')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Mascotas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addPet, // Navega a la pantalla de agregar mascota
          ),
        ],
      ),
      body: pets.isEmpty
          ? Center(child: Text('No hay mascotas registradas.'))
          : ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: pet.image_url != null && pet.image_url!.isNotEmpty
                  ? CircleAvatar(backgroundImage: NetworkImage(pet.image_url!))
                  : CircleAvatar(child: Icon(Icons.pets)),
              title: Text(pet.name),
              subtitle: Text('${pet.species} - ${pet.breed}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _updatePet(pet), // Navega a la pantalla de actualizar mascota
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePet(pet.id), // Llama al método para eliminar
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla para agregar o actualizar mascota
class AddOrUpdatePetScreen extends StatefulWidget {
  final String userId;
  final Pet? pet; // Si es null, se está agregando una nueva mascota

  AddOrUpdatePetScreen({required this.userId, this.pet});

  @override
  _AddOrUpdatePetScreenState createState() => _AddOrUpdatePetScreenState();
}

class _AddOrUpdatePetScreenState extends State<AddOrUpdatePetScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, breed, species, birthDate;
  late double weight;
  late int age;

  @override
  void initState() {
    super.initState();

    if (widget.pet != null) {
      // Si se está actualizando una mascota, llenamos los datos iniciales
      name = widget.pet!.name;
      breed = widget.pet!.breed;
      species = widget.pet!.species;
      birthDate = widget.pet!.birthDate;
      weight = widget.pet!.weight.toDouble();
      age = widget.pet!.age;
    } else {
      // Valores por defecto para agregar nueva mascota
      name = '';
      breed = '';
      species = '';
      birthDate = '';
      weight = 0.0;
      age = 0;
    }
  }

  // Método para agregar una nueva mascota
  Future<void> _addPet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final Dio dio = Dio();
        final petService = PetService(dio);

        await petService.addPet({
          'user_id': widget.userId,
          'name': name,
          'breed': breed,
          'species': species,
          'birth_date': birthDate,
          'weight': weight,
          'age': age,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mascota agregada exitosamente')),
        );

        Navigator.pop(context, true); // Redirigir con éxito
      } catch (e) {
        print('Error adding pet: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar la mascota')),
        );
      }
    }
  }

  // Método para actualizar una mascota
  Future<void> _updatePet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final Dio dio = Dio();
        final petService = PetService(dio);

        await petService.patchPet(widget.pet!.id, widget.userId, {
          'name': name,
          'breed': breed,
          'species': species,
          'birth_date': birthDate,
          'weight': weight,
          'age': age,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mascota actualizada exitosamente')),
        );

        Navigator.pop(context, true); // Redirigir con éxito
      } catch (e) {
        print('Error updating pet: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la mascota')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet == null ? 'Agregar Mascota' : 'Actualizar Mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la mascota';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: breed,
                decoration: InputDecoration(labelText: 'Raza'),
                onSaved: (value) => breed = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la raza de la mascota';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: species,
                decoration: InputDecoration(labelText: 'Especie'),
                onSaved: (value) => species = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la especie de la mascota';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: birthDate,
                decoration: InputDecoration(labelText: 'Fecha de Nacimiento (YYYY-MM-DD)'),
                onSaved: (value) => birthDate = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de nacimiento';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: weight.toString(),
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => weight = double.tryParse(value!) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el peso de la mascota';
                  }
                  if (double.tryParse(value) == null) {
                    return 'El peso debe ser un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: age.toString(),
                decoration: InputDecoration(labelText: 'Edad (años)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => age = int.tryParse(value!) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la edad de la mascota';
                  }
                  if (int.tryParse(value) == null) {
                    return 'La edad debe ser un número entero válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.pet == null ? _addPet : _updatePet,
                child: Text(widget.pet == null ? 'Agregar Mascota' : 'Actualizar Mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
