// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  selectedSoruce(String source) async {
    switch (source) {
      case "galeri":
        final user = await FirebaseAuth.instance.currentUser;
        final userUid = user!.uid;
        File? insertImage;
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          insertImage = File(image!.path);
        });
        FirebaseStorage storage = FirebaseStorage.instance;
        final ref = storage.ref().child("profilResimleri").child(userUid);
        UploadTask uploadTask = ref.putFile(insertImage!);
        await uploadTask;
        final imageUrl = await ref.getDownloadURL();
        final databaseRef = FirebaseDatabase.instance.ref(userUid);
        await databaseRef.update({"profilUrl": imageUrl});
        break;
      case "kamera":
        final user = await FirebaseAuth.instance.currentUser;
        final userUid = user!.uid;
        File? insertImage;
        var image = await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          insertImage = File(image!.path);
        });
        FirebaseStorage storage = FirebaseStorage.instance;
        final ref = storage.ref().child("profilResimleri").child(userUid);
        UploadTask uploadTask = ref.putFile(insertImage!);
        await uploadTask;
        final imageUrl = await ref.getDownloadURL();
        final databaseRef = FirebaseDatabase.instance.ref(userUid);
        await databaseRef.update({"profilUrl": imageUrl});
        break;
    }
  }

  _showDialog(BuildContext context) {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Seçim"),
              content: Text("Nereden Yükleyeceksiniz?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      await selectedSoruce("galeri");
                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Galeri")),
                TextButton(
                    onPressed: () async {
                      await selectedSoruce("kamera");
                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Kamera"))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(
        child: Text("Upload Image"),
        onPressed: _showDialog(context),
        // onPressed: () async {
        //   final user = await FirebaseAuth.instance.currentUser;
        //   final userUid = user!.uid;
        //   File? insertImage;
        //   var image = await ImagePicker().pickImage(source: ImageSource.camera);
        //   setState(() {
        //     insertImage = File(image!.path);
        //   });
        //   FirebaseStorage storage = FirebaseStorage.instance;
        //   final ref = storage.ref().child("profilResimleri").child(userUid);
        //   UploadTask uploadTask = ref.putFile(insertImage!);
        //   await uploadTask;
        //   final imageUrl = await ref.getDownloadURL();
        //   final databaseRef = FirebaseDatabase.instance.ref(userUid);
        //   await databaseRef.update({"profilUrl": imageUrl});
        // },
      )),
    );
  }
}
