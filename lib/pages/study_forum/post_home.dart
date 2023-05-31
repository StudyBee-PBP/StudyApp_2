import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_app/model/forum_post.dart';
import 'package:http/http.dart' as http;
import 'package:study_app/pages/menu.dart';
import 'package:study_app/pages/study_forum/widgets/tab_one.dart';
import 'package:study_app/pages/study_forum/widgets/tab_two.dart';

class PostHomePage extends StatefulWidget {
  const PostHomePage({Key? key}) : super(key: key);

  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => const MyHomePage()
                )
              );
            }, 
            icon: const Icon(
              Icons.arrow_back_sharp)
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'My Forum'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tab1Content(),
            Tab2Content(),
          ],
        ),
      ),
    );
  }
}