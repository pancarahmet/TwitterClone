// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TwitAt extends StatefulWidget {
  const TwitAt({super.key});

  @override
  State<TwitAt> createState() => _TwitAtState();
}

class _TwitAtState extends State<TwitAt> {
  TextEditingController twitAt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiwit At"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: twitAt,
            maxLines: 8,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Twitini buraya yaz...",
            ),
          ),
          ElevatedButton(
            child: Text("Twitleee"),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              final userUid = user!.uid;
              final ref = FirebaseDatabase.instance.ref();
              final userName = await ref.child(userUid).child("userName").get();
              final profilUrl =
                  await ref.child(userUid).child("profilUrl").get();
              Map<String, dynamic> data = {
                'userName': userName.value,
                'messages': twitAt.text,
                'profilUrl': profilUrl.value
              };

              await FirebaseFirestore.instance
                  .collection("icerik")
                  .doc()
                  .set(data)
                  .whenComplete(() => Navigator.pop(context));
            },
          )
        ],
      )),
    );
  }
}
