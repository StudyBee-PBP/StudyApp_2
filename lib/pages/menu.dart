import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:study_app/pages/login.dart';
import 'package:study_app/pages/study_diary/pages/diary.dart';
import 'package:study_app/pages/study_diary/pages/diary_home.dart';
import 'package:study_app/pages/study_forum/post_home.dart';
import 'package:study_app/pages/study_plan/planner.dart';
import 'package:study_app/widgets/drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        // Set title aplikasi menjadi Money Tracker
        title: const Center(
          child: Text( 
            'StudyBee',
          ),
        ),
      ),
      drawer: const DrawerMenu(), // Menambahkan drawer pada halaman
      body: SingleChildScrollView( // Widget wrapper yang dapat discroll
        child: Padding( 
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column( // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Selamat datang!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: <Widget>[
                  Material(
                    color: Colors.yellow,
                    child: InkWell( // Area responsive terhadap sentuhan
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlannerPage()),
                        );
                      },
                      child: Container( // Container untuk menyimpan Icon dan Text
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.event_sharp,
                                color: Colors.black,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Study Plan",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.yellow,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PostHomePage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.forum_sharp,
                                color: Colors.black,
                                size: 40.0,
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "Forum",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.yellow,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyDiaryHomePage()),
                        );},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.desk_sharp,
                                color: Colors.black,
                                size: 40.0,
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "Diary",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.yellow,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                          content: Text("Kamu telah menekan tombol Notes!")));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.create_sharp,
                                color: Colors.black,
                                size: 40.0,
                              ),
                              Padding(padding: EdgeInsets.all(1)),
                              Text(
                                "Notes",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.yellow,
                    child: InkWell(
                      onTap: () async {
                        final response = await request.logout(
                          // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                          "https://study-bee.domcloud.io/auth/logout/");
                          String message = response["message"];
                          if (response['status']) {
                            String uname = response["username"];
                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                              content: Text("$message Sampai jumpa, $uname."),
                            ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$message"),
                            ));
                          }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                // Kamu juga dapat mengggunakan icon lainnya
                                // seperti Icons.logout
                                Icons.door_back_door,
                                color: Colors.black,
                                size: 30.0,
                              ),
                              Padding(padding: EdgeInsets.all(3)),
                              Text(
                                "Logout",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
