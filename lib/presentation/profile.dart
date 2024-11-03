import 'package:flutter/material.dart';
import '../Services/UserService.dart';
import '../model/UserDetails.dart';
import 'app_scaffold.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileService userProfileService = UserProfileService();
  UserDetails? userDetails;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    const String userUuid = 'USER_UUID';

    try {
      final user = await userProfileService.getUserDetails(userUuid);
      setState(() {
        userDetails = user;
        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName;
        _phoneNumberController.text = user.phoneNumber;
        _imageUrlController.text = user.imageUrl ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el perfil')),
      );
    }
  }

  Future<void> _updateUser() async {
    if (userDetails != null) {
      UserDetails updatedUser = UserDetails(
        userUuid: userDetails!.userUuid,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        birthDate: userDetails!.birthDate, // Utiliza la fecha de nacimiento original si está disponible
        phoneNumber: _phoneNumberController.text,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null,
      );

      try {
        await userProfileService.updateUser(updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil actualizado con éxito')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el perfil')),
        );
      }
    }
  }

  Future<void> _deleteUser() async {
    if (userDetails != null) {
      try {
        await userProfileService.deleteUser(userDetails!.userUuid);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil eliminado con éxito')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el perfil')),
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
                    backgroundImage: userDetails?.imageUrl != null && userDetails!.imageUrl!.isNotEmpty
                        ? NetworkImage(userDetails!.imageUrl!)
                        : AssetImage('assets/default-profile.png') as ImageProvider,
                    onBackgroundImageError: (_, __) {
                      setState(() {
                        userDetails = userDetails?.copyWith(imageUrl: null);
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    userDetails?.firstName ?? 'Nombre de Usuario',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userDetails?.lastName ?? 'Apellido de Usuario',
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
                  onPressed: _deleteUser,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Eliminar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Cerrar sesión'),
              ),
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
    super.dispose();
  }
}
