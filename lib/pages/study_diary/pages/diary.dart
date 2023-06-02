import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:study_app/model/diary_record.dart';
import 'package:study_app/widgets/drawer.dart';

import 'diary_home.dart';

class DiaryPage extends StatefulWidget {
const DiaryPage({Key? key}) : super(key: key);

@override
_DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
Future<List<DiaryRecord>> fetchDiaryRecord() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/diary/json/');
    var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object DiaryRecord
    List<DiaryRecord> listDiaryRecord = [];
    for (var d in data) {
        if (d != null) {
            listDiaryRecord.add(DiaryRecord.fromJson(d));
        }
    }
    return listDiaryRecord;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Diary Tracker'),
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
        body: FutureBuilder(
            future: fetchDiaryRecord(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return Column(
                        children: const [
                        Text(
                            "Tidak ada data transaksi.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    ),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.description}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.date}"),
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}

