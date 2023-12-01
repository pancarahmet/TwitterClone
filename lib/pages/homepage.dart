// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getUrl() async {
    final userUid = await FirebaseAuth.instance.currentUser!.uid;
    final ref = await FirebaseDatabase.instance.ref();
    final url = await ref.child(userUid).child("profilUrl").get();
    return url.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: FaIcon(
            FontAwesomeIcons.twitter,
            size: 30,
            color: Colors.blue,
          ),
          centerTitle: true,
          leading: FutureBuilder(
            future: getUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data.toString()),
              );
            },
          ),
          // leading: CircleAvatar(
          //   child: FlutterLogo(),
          //   backgroundColor: Colors.transparent,
          // ),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              Text("Sana Özel"),
              Text("Takip Ettiklerin"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("icerik")
                    .orderBy("messages", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data!.docs.toString() == "[]") {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  print(snapshot.data!.docs);
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx, index) => Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Card(
                        color: Colors.transparent,
                        child: ListTile(
                          title: Text(
                            documents[index].data()["userName"],
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                documents[index].data()["profilUrl"]),
                          ),
                          // leading: CircleAvatar(
                          //   backgroundColor: Colors.transparent,
                          //   backgroundImage:
                          //       AssetImage("assets/icons/nullUserProfil.jpg"),
                          // ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documents[index].data()["messages"],
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(FontAwesomeIcons.comment,
                                          color: Colors.white)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(FontAwesomeIcons.retweet,
                                          color: Colors.white)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.favorite_outline,
                                          color: Colors.white)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bar_chart,
                                          color: Colors.white)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Center(
              child: Text(
                "Takip Ettiklerin",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
