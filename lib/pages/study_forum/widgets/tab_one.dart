import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_app/model/forum_post.dart';
import 'package:http/http.dart' as http;
import 'package:study_app/pages/menu.dart';
import 'package:study_app/pages/study_forum/create_post.dart';
import 'package:study_app/pages/study_forum/discussion.dart';

class Tab1Content extends StatefulWidget {
  const Tab1Content({Key? key}) : super(key: key);

  @override
  _Tab1ContentState createState() => _Tab1ContentState();
}

class _Tab1ContentState extends State<Tab1Content> {
  Future<List<Post>> fetchPost() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://localhost:8000/forum/json-post/');
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
    List<Post> listPost = [];
    for (var d in data) {
        if (d != null) {
            listPost.add(Post.fromJson(d));
        }
    }
    return listPost;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: OutlinedButton(
            onPressed: () {
              // Perform button action
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => const CreatePostPage()
                )
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black45,
            ),
            child: Icon(Icons.add),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: fetchPost(), 
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                    Text(
                      "Tidak ada data Post.",
                      style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) => DiscussionPage(pk: snapshot.data![index].pk),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16, 
                          vertical: 12
                        ),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.05),
                              offset: Offset(0.0,6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10
                            )
                          ]
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
                                            Container(
                                              child: Text(
                                                "${snapshot.data![index].fields.title}",
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .4
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Row(
                                              children: <Widget> [
                                                Text(
                                                  "${snapshot.data![index].fields.username}",
                                                  style: TextStyle(
                                                    color: Colors.grey.withOpacity(0.6)
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Text(
                                                  "${snapshot.data![index].fields.date}",
                                                  style: TextStyle(
                                                    color: Colors.grey.withOpacity(0.6)
                                                  ),
                                                )
                                              ],
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
                                  Text(
                                    "${snapshot.data![index].fields.content}"
                                  )
                                ]
                              ),
                            )
                          ]
                        )
                      ),
                    )
                  );
                }
              }
            }
          )
        )
      ]
    );
  }
}




  