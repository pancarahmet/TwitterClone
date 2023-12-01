// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search2 extends StatefulWidget {
  const Search2({super.key, required this.mesaj});
  final String mesaj;
  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("icerik").snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var mesaj = widget.mesaj;
                    print("search 2 mesaj " + widget.mesaj);

                    // print(mesaj);
                    if (mesaj.isEmpty) {
                      if (index == 0)
                        return Text(
                          "herhangi bir arama gerçekleştirmediniz",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      return Container();
                    }
                    if (data["messages"]
                        .toString()
                        .startsWith(mesaj.toLowerCase())) {
                      print("if içi");
                      return ListTile(
                          title: Text(
                            data["userName"],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            data["messages"],
                            style: TextStyle(color: Colors.white),
                          ));
                    }

                    return Container();
                  });
        },
      ),
    );
  }
}
