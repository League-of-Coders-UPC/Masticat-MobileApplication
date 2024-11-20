import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Services/Service/AuthService.dart';
import '../model/Seguridad/LoginRequest.dart';
import 'dashboard_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://animal-shelter-p65z.onrender.com/api",
    connectTimeout: Duration.zero,
    receiveTimeout: Duration.zero,
  ));
  late final AuthService _authService = AuthService(_dio);

  String _username = '';
  String _password = '';
  String? _storedAccessToken;


// Dentro de tu método _onSubmit
  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        print('Iniciando login...');
        print('Datos enviados a /api/token: ${jsonEncode(
            {"username": _username, "password": _password})}');

        final loginResponse = await _authService.login(
          LoginRequest(username: _username, password: _password).toJson(),
        );

        print('Respuesta de /api/token: ${jsonEncode(loginResponse.toJson())}');

        final accessToken = loginResponse.access;

        // Decodificar el token para obtener el user_id
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['user_id'];
        print('user_id decodificado: $userId');

        // Aquí puedes guardar el user_id en una variable global o estado compartido, si lo necesitas:
        // Example: GlobalState.userId = userId;

        // Redirigir al dashboard
        print('Login exitoso. Redirigiendo al dashboard...');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DashboardScreen(
                    userId: userId), // Pasar el userId si es necesario
          ),
        );
      } catch (e) {
        if (e is DioError) {
          // Manejar DioError específicamente
          print('Error durante la petición a /api/token: ${e.message}');
          print('Datos recibidos: ${e.response?.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Error en el login: ${e.response?.data ?? e.message}'),
            ),
          );
        } else {
          // Manejar otros errores
          print('Error inesperado: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error inesperado: $e')),
          );
        }
      }
    }
  }
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/Logo.png',
                  height: 100,
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su username';
                    }
                    return null;
                  },
                  onSaved: (value) => _username = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text('Sign in'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿No tienes una cuenta? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
