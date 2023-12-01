// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/class/myclass.dart';
import 'package:twitter_clone/pages/search2.dart';
import 'package:twitter_clone/pages/settings.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isFilled = false;
  TextEditingController search = TextEditingController();
  String name = "";
  List<Araba> newCar = [];
  // arama() {
  //   StreamBuilder(
  //     stream: (search.text != "" && search.text != null)
  //         ? FirebaseFirestore.instance
  //             .collection("icerik")
  //             .where("username", isNotEqualTo: search.text)
  //             .orderBy("username")
  //             .startAt([
  //             search.text,
  //           ]).endAt([search.text + "'\uf8ff"]).snapshots()
  //         : FirebaseFirestore.instance.collection("icerik").snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting)
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       final documents = snapshot.data!.docs;
  //       return ListView.builder(
  //           itemCount: documents.length, //
  //           itemBuilder: (ctx, index) {
  //             return Text(documents[index].data()["username"]);
  //           });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: FlutterLogo(),
        ),
        title: TextField(
          textInputAction: TextInputAction.search,
          controller: search,
          onSubmitted: (value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Search2(mesaj: value)));
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 34, 34, 34),
              hintText: "Twitter'da Ara",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffix: IconButton(
                onPressed: () {
                  search.text = "";
                  setState(() {
                    name = "";
                  });
                },
                icon: FaIcon(FontAwesomeIcons.xmark),
              ),
              suffixIcon:
                  isFilled ? Icon(Icons.cancel, color: Colors.grey) : null),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
              icon: Icon(Icons.settings)),
        ],
      ),
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
                    if (name.isEmpty) return Container();

                    if (data["userName"]
                        .toString()
                        .startsWith(name.toLowerCase())) {
                      return ListTile(
                        title: Text(
                          data["userName"],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          data["messages"],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return Container();
                  });
        },
      ),
    );
  }
}
