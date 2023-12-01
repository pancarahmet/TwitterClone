// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bildirimler"),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FlutterLogo(),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          ],
          bottom: TabBar(
            tabs: [
              Text("Tümü"),
              Text("Onaylanmış"),
              Text("Bahsedenler"),
            ],
          ),
        ),
        body: TabBarView(children: [
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Column(
              children: [
                index == 0
                    ? Container()
                    : Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                Card(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: FlutterLogo()),
                    title: Text(
                      "${index + 1}. Kişinin bildirimi",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("Onaylanmış", style: TextStyle(color: Colors.white)),
          Text("Bahsedenler", style: TextStyle(color: Colors.white)),
        ]),
      ),
    );
  }
}
