import 'dart:convert';

import 'package:flutter/material.dart';
import '../Services/Service/SignupService.dart';
import '../model/Seguridad/SignupRequest.dart';
import '../model/Seguridad/SignupResponse.dart';

import 'package:dio/dio.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://animal-shelter-p65z.onrender.com/api",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ))
    ..interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      logPrint: (log) => print(log),
    ));

  late final SignupService _signupService = SignupService(dio);

  String username = '';
  String first_name = '';
  String last_name = '';
  String email = '';
  String password = '';
  String birth_date = '';
  String phone_number = '';
  String image_url = 'http://example.com/profile.jpg'; // Default value
  String role = 'user'; // Default role

  void _onSignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Crear el objeto de solicitud
        SignupRequest signupRequest = SignupRequest(
          username: username,
          email: email,
          password: password,
          role: role,
          first_name: first_name,
          last_name: last_name,
          birth_date: birth_date,
          phone_number: phone_number,
          image_url: image_url,
        );

        print('Request Data Sent: ${signupRequest.toJson()}');

        // Enviar la solicitud y manejar la respuesta
        final response = await _signupService.signup(signupRequest);

        // Imprimir la respuesta del servidor
        print('Response Data Received: ${response.toJson()}');

        if (response.message == 'User created successfully') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User created successfully! Username: ${response.user.username}, Email: ${response.user.email}, Role: ${response.user.role}',
              ),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          throw Exception('Unexpected response: ${response.toJson()}');
        }
      } on DioError catch (dioError) {
        print('Request Data Sent: ${dioError.requestOptions.data}');
        print('Response Data Received: ${dioError.response?.data}');

        if (dioError.response?.statusCode == 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Internal server error. Please try again later.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to create user: ${dioError.response?.data ?? dioError.message}',
              ),
            ),
          );
        }
    } catch (e) {
        print('Unexpected error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) => username = value!,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'First Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (value) => first_name = value!,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Last Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onSaved: (value) => last_name = value!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) => password = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Birth Date (YYYY-MM-DD)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birth date';
                      }
                      return null;
                    },
                    onSaved: (value) => birth_date = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => phone_number = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _onSignUp,
                    child: Text('Sign up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
