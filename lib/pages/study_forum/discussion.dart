import 'package:flutter/material.dart';
import 'package:study_app/pages/study_forum/add_replies.dart';
import 'package:study_app/pages/study_forum/post_home.dart';
import 'package:study_app/pages/study_forum/widgets/selected_post.dart';
import 'package:study_app/pages/study_forum/widgets/show_replies.dart';

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
      body: Column(
        children: [
          SizedBox(height: 16.0,),
          SelectedPost(pk: pk),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Balasan",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          SizedBox(height: 12.0,),
          OutlinedButton(
            onPressed: () {
              // Perform button action
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => AddRepliesPage(pk: pk)
                )
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black45,
            ),
            child: Icon(Icons.add),
          ),
          ShowReplies(pk: pk),
        ],
      )
    );
  }
}