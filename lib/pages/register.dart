import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:study_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
    home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ), 
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong!';
                        } else if (value.length > 150) {
                          return 'Username harus memiliki 150 karakter atau kurang!!';
                        } else if (!RegExp(r'^[a-zA-Z0-9@.+_-]*$').hasMatch(value)) {
                          return 'Username hanya boleh terdiri dari huruf, angka, dan karakter @/./+/-/_.';
                        }
                        return null;
                      },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong!';
                        } else if (value.length < 8) {
                          return 'Password harus memiliki 8 karakter atau lebih!';
                        } 
                        return null;
                      },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi password tidak boleh kosong!';
                        } else if (value != _passwordController.text) {
                          return 'Konfirmasi password tidak cocok!';
                        } 
                        return null;
                      },
                    )
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
        
                       if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "https://study-bee.domcloud.io/auth/register/",
                          convert.jsonEncode(<String, String>{
                            'username': username,
                            'password': password,
                          })
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text("Registrasi berhasil! Silakan login untuk melanjutkan."),
                            ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                            )
                          );
                        }
                       }
                    },
                    child: const Text('Register'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Sudah punya akun? ",
                              style:  TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer() 
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginApp()),
                                  );
                                }
                            )
                          ]
                        )
                      ),
                    ),
                  ),
                ] 
              ) 
            )
          ),
        )
      )
    ); 
  }
}