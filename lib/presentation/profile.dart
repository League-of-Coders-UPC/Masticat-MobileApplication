import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Services/Service/UserDetailsService.dart';
import '../model/UserData/UserDetails.dart';
import 'app_scaffold.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://animal-shelter-p65z.onrender.com/api"));
  late final UserDetailsService userDetailsService;

  UserDetails? userDetails;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController(); // Para username
  final TextEditingController _emailController = TextEditingController(); // Para email

  @override
  void initState() {
    super.initState();
    userDetailsService = UserDetailsService(dio);
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      print("Fetching user details for user_id: ${widget.userId}");
      final List<UserDetails> users = await userDetailsService.getUserDetailsByQuery(widget.userId);

      if (users.isNotEmpty) {
        final user = users.first;
        setState(() {
          userDetails = user;

          // Asignar valores a los controladores
          _firstNameController.text = user.firstName;
          _lastNameController.text = user.lastName;
          _phoneNumberController.text = user.phoneNumber;
          _imageUrlController.text = user.imageUrl ?? '';
          _usernameController.text = user.user.username;
          _emailController.text = user.user.email;
        });

        print("User details loaded successfully: ${user.toJson()}");
      } else {
        print("No user details found for user_id: ${widget.userId}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontraron detalles del usuario')),
        );
      }
    } catch (e) {
      print("Error fetching user details: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el perfil')),
      );
    }
  }


  Future<void> _updateUser() async {
    if (userDetails != null) {
      // Crear un mapa con los campos actualizados
      final updatedFields = {
        "first_name": _firstNameController.text,
        "last_name": _lastNameController.text,
        "phone_number": _phoneNumberController.text,
        "image_url": _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null,
      };

      try {
        // Llamar al servicio para actualizar los detalles del usuario
        print("Updating user details with ID: ${userDetails!.id}");
        await userDetailsService.patchUserDetail(userDetails!.id.toString(), updatedFields);

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil actualizado con éxito')),
        );

        // Recargar los datos para reflejar los cambios
        _fetchUserDetails();
      } catch (e) {
        // Manejo de errores
        print("Error updating user details: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el perfil')),
        );
      }
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 1,
      userId: widget.userId,
      body: userDetails == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userDetails!.imageUrl != null && userDetails!.imageUrl!.isNotEmpty
                        ? NetworkImage(userDetails!.imageUrl!)
                        : AssetImage('assets/default-profile.png') as ImageProvider,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _usernameController.text,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _emailController.text,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            _buildTextField('Nombre', _firstNameController),
            SizedBox(height: 16),
            _buildTextField('Apellido', _lastNameController),
            SizedBox(height: 16),
            _buildTextField('Número de Teléfono', _phoneNumberController),
            SizedBox(height: 16),
            _buildTextField('URL de Imagen', _imageUrlController),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _updateUser,
                  child: Text('Guardar'),
                ),
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Cerrar sesión'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ingresa $label',
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _imageUrlController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
