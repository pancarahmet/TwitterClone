// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/homepage.dart';
import 'package:twitter_clone/pages/notifications.dart';
import 'package:twitter_clone/pages/search.dart';
import 'package:twitter_clone/pages/twitat.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: [
          HomePage(),
          Search(),
          Notifications(),
          Center(
            child: Text(
              "Mesajlar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _controller,
        tabs: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.notifications),
          Icon(Icons.message),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TwitAt()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
