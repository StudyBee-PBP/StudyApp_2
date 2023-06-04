import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_app/model/forum_post.dart';
import 'package:http/http.dart' as http;
import 'package:study_app/pages/menu.dart';
import 'package:study_app/pages/study_forum/post_home.dart';
import 'package:study_app/pages/study_forum/widgets/selected_post.dart';
import 'package:study_app/pages/study_forum/widgets/show_replies.dart';
import 'package:study_app/pages/study_forum/widgets/tab_one.dart';
import 'package:study_app/pages/study_forum/widgets/tab_two.dart';

class DiscussionPage extends StatefulWidget {
  final int pk;

  DiscussionPage({required this.pk});

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage>{
  @override
  Widget build(BuildContext context) {
    final int pk = widget.pk;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diskusi"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => const PostHomePage()
              )
            );
          }, 
          icon: const Icon(
            Icons.arrow_back_sharp)
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 24.0,),
          SelectedPost(pk: pk),
          SizedBox(height: 10.0), // Add some spacing between SelectedPost and "halo" text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Balasan",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          ShowReplies(pk: pk),
        ],
      )
    );
  }
}