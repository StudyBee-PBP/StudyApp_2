import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:study_app/pages/study_forum/discussion.dart';
import 'package:study_app/widgets/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class AddRepliesPage extends StatefulWidget {
  final int pk;

  AddRepliesPage({required this.pk});

  @override
  State<AddRepliesPage> createState() => _AddRepliesPageState();
}

class _AddRepliesPageState extends State<AddRepliesPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = SharedData.stored_username;
  String _content = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final int post_pk = widget.pk;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Balasan"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => DiscussionPage(pk: post_pk)
              )
            );
          }, 
          icon: const Icon(
            Icons.arrow_back_sharp)
        ),
      ),
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
                      labelText: "Isi",
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
                        _content = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _content = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Tambah",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Kirim ke Django dan tunggu respons
                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                      final response = await request.postJson(
                      "http://localhost:8000/forum/add-replies-flutter/",
                      convert.jsonEncode(<String, String>{
                          'username': _username,
                          'id': post_pk.toString(),
                          'content': _content
                      }));
                      if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                          content: Text("Balasan baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => DiscussionPage(pk: post_pk)),
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
                ),
              ]
            )
          )
        )
      )
    );

  }
}