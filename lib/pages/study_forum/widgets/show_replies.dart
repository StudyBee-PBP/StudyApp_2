import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:study_app/model/forum_replies.dart';
import 'package:http/http.dart' as http;

class ShowReplies extends StatefulWidget {
  final int pk;

  ShowReplies({required this.pk});

  @override
  _ShowRepliesState createState() => _ShowRepliesState();
}

class _ShowRepliesState extends State<ShowReplies> {
  Future<List<Replies>> fetchReplies() async {
    final int pk = widget.pk;
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://study-bee.domcloud.io/forum/json-answer/${pk}');
    var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Post
    List<Replies> listReplies = [];
    for (var d in data) {
        if (d != null) {
            listReplies.add(Replies.fromJson(d));
        }
    }
    return listReplies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchReplies(), 
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData) {
            return Column(
              children: const [
              Text(
                "Tidak ada data Replies.",
                style:
                  TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
              SizedBox(height: 8),
              ],
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16, 
                    vertical: 12
                  ),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget> [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: AssetImage('assets/icon/default-profile-icon.jpg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "by ${snapshot.data![index].fields.username} - ${
                                          DateFormat('EEEE, d MMMM yyyy, hh:mm a').format(
                                          DateTime.parse('${snapshot.data![index].fields.date}'
                                          ))}",
                                        style: TextStyle(
                                          color: Colors.black87
                                        ),
                                      )
                                    ]
                                  ),
                                )
                              ],
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "${snapshot.data![index].fields.content}"
                              ),
                            )
                          ]
                        ),
                      )
                    ]
                  )
                )
              ),
            );
          }
        }
      }
    );
  }
}