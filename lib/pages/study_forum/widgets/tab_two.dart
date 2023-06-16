import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:study_app/model/forum_post.dart';
import 'package:http/http.dart' as http;
import 'package:study_app/pages/study_forum/create_post.dart';
import 'package:study_app/pages/study_forum/discussion.dart';
import 'package:study_app/pages/study_forum/post_home.dart';
import 'package:study_app/widgets/shared_data.dart';

class Tab2Content extends StatefulWidget {
  const Tab2Content({Key? key}) : super(key: key);

  @override
  _Tab2ContentState createState() => _Tab2ContentState();
}

class _Tab2ContentState extends State<Tab2Content> {
  String _username = SharedData.stored_username;

  Future<void> deletePost(String id) async {
    var url = Uri.parse('https://study-bee.domcloud.io/forum/delete-flutter/${id}');
    final response = await http.delete(
      url,
      headers: <String, String>{
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PostHomePage()),
      );
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text("Post berhasil dihapus.")));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.cancel_sharp),
          iconColor: Colors.red,
          title: const Text('Post gagal dihapus'),
          content: Text("Silahkan coba lagi"),
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
  }
  
  Future<List<Post>> fetchPost() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://study-bee.domcloud.io/forum/json-post/${_username}');
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
    for (var i = data.length - 1; i >= 0; i--) {
      var d = data[i];
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
        OutlinedButton(
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
        SizedBox(height: 4.0,),
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
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          deletePost("${snapshot.data![index].pk}");
                                        },
                                        child: Text("Hapus")
                                      ),
                                    ]
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




  