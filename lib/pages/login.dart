import 'package:flutter/gestures.dart';
import 'package:study_app/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:study_app/pages/register.dart';
import 'package:study_app/widgets/shared_data.dart';

void main() {
    runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
const LoginApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
      title: 'Login',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
  ),
  home: const LoginPage(),
  );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username',
                ),
            ),
            const SizedBox(height: 12.0),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                ),
                obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                final response = await request.login("https://study-bee.domcloud.io/auth/login/", {
                'username': username,
                'password': password,
                });
                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  
                  SharedData.stored_username = uname;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text("$message Selamat datang, $uname.")));
                  } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content:
                        Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Belum punya akun? ",
                        style:  TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Registrasi",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer() 
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterApp()),
                            );
                          }
                      )
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
