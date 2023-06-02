import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_app/model/StudyPlan.dart';
import 'package:study_app/pages/form.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:study_app/model/StudyPlan.dart';
import 'package:study_app/widgets/drawer.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({Key? key}) : super(key: key);

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  get http => null;

    Future<List<StudyPlan>> fetchStudyPlan() async {
      var url = Uri.parse(
          'https://study-bee.domcloud.io/planner/json');
      var response = await http.get(
          url,
          headers: {
              "Access-Control-Allow-Origin": "*",
              "Content-Type": "application/json",
          },
      );

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object StudyPlan
      List<StudyPlan> listStudyPlan = [];
      for (var d in data) {
          if (d != null) {
              listStudyPlan.add(StudyPlan.fromJson(d));
          }
      }
      return listStudyPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian atas app
      appBar: AppBar(
        title: const Text("Planner by Ardian"),
      ),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        // Tombol tambah plan
        onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PlannerFormPage()),
          );
        },
        tooltip: 'Add a plan',
        child: const Icon(Icons.add),
      ),

      body: FutureBuilder(
        future: fetchStudyPlan(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
          }
          else{
            if (!snapshot.hasData) {
              return Column(
                children: const [
                Text(
                    "Tidak ada plan.",
                    style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
                ],
              );
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.name}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.subject}"),
                    ],
                  ),
                )
              );
            }
          }
        }
      )
    );      
  }
}
