import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;

import 'package:study_app/pages/study_plan/planner.dart';

class PlannerFormPage extends StatefulWidget {
  const PlannerFormPage({super.key});

  @override
  State<PlannerFormPage> createState() => _PlannerFormPageState();
}

class _PlannerFormPageState extends State<PlannerFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String type = 'Individual'; // Set a default value that exists in typeList
  List<String> typeList = ['Individual', 'Group'];
  DateTime _date = DateTime.now();
  String _subject = "";
  String _location = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Form by Ardian'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                  ListTile(
                  title: const Text('Tipe Belajar:'),
                  leading: type == 'Individual'
                      ? const Icon(Icons.person)
                      : const Icon(Icons.people),
                  trailing: DropdownButton(
                    value: type,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: typeList.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        type = newValue!;
                      });
                    },
                  ),
                ),

                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Belajar flutter",
                      labelText: "Nama Plan:",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.assignment),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama plan tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Tanggal Belajar:",
                      icon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (selectedDate != null) {
                        setState(() {
                          _date = selectedDate;
                        });
                      }
                    },
                    readOnly: true,
                    validator: (value) {
                      if (value == null) {
                        return 'Tanggal harus diisi';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      text: _date != null
                          ? DateFormat('yyyy-MM-dd').format(_date!)
                          : '',
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        setState(() {
                          _date = DateTime.parse(value);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: PBP",
                      labelText: "Mata Kuliah:",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.book),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _subject = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _subject = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mata kuliah tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Walking Drums",
                      labelText: "Lokasi Belajar:",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.place),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _location = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _location = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Lokasi belajar tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText:
                          "Contoh: Belajar untuk UAS",
                      labelText: "Deskripsi Plan:",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.description),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi plan tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: -2,
                                blurRadius: 8,
                                offset: const Offset(0, -1),
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const PlannerPage()),
                              );
                            },
                            child: const Text(
                              "cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: -2,
                                blurRadius: 8,
                                offset: const Offset(0, -1),
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.yellow),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Menambahkan variabel untuk menyesuaikan format field date
                                final formattedDate = DateFormat('yyyy-MM-dd').format(_date);
                                final response = await request.postJson(
                                  "https://study-bee.domcloud.io/planner/add-flutter/",
                                  convert.jsonEncode(<String, String>{
                                    'name': _name,
                                    'type': type,
                                    'date': formattedDate,
                                    'subject': _subject.toString(),
                                    'location': _location,
                                    'description': _description
                                  }),
                                );
                                if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Plan baru berhasil disimpan!"),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const PlannerPage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Terdapat kesalahan, silakan coba lagi."),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "add",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
            ),
          ),
        )
      )
    );
  }
}
