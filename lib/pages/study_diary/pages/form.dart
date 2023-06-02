import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:study_app/pages/study_diary/pages/diary.dart';
import 'package:study_app/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

import 'diary_home.dart';

class MyFormPage extends StatefulWidget {
    const MyFormPage({super.key});

    @override
    State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _deskripsiDiary = "";

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: Text('Form Diary'),
                leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => const MyDiaryHomePage()
                )
              );
            }, 
            icon: const Icon(
              Icons.arrow_back_sharp)
          ),

            ),
            drawer: const DrawerMenu(),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                        Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Contoh: Saya Sedih Karena Tidak Bisa Menyelesaikan Tugas",
                            labelText: "Deskripsi Diary",
                            // Menambahkan icon agar lebih intuitif
                            icon: const Icon(Icons.notes),
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              _deskripsiDiary = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              _deskripsiDiary = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Deskripsi Diary tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Tambah",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Memunculkan data (di sini)
                            final response = await request.postJson(
                            "http://127.0.0.1:8000/tracker/create-flutter/",
                            convert.jsonEncode(<String, String>{
                                'description': _deskripsiDiary,
                            }));
                            if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                content: Text("Diary baru berhasil disimpan!"),
                                ));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const DiaryPage()),
                                );
                            } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content:
                                        Text("Terdapat kesalahan, silakan coba lagi."),
                                ));
                            }
                          }
                        },
                      ),
                    ]
                  ),
                ),
              ),
            ),
        );
    }
}




