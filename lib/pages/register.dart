// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/companents/myloginbutton.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 70, right: 70),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Kullanıcı Adınızı Giriniz",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 70),
              child: TextField(
                controller: userPhone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Telefon no giriniz",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 70),
              child: TextField(
                controller: userEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Email Adresinizi giriniz",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 70),
              child: TextField(
                obscureText: isShow,
                controller: userPass,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Şifrenizi Giriniz",
                  suffixIcon: isShow
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          icon: Icon(Icons.visibility))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          icon: Icon(Icons.visibility_off)),
                ),
              ),
            ),
            MyLoginButton(
              child: Text("Kayıt Ol"),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: userEmail.text, password: userPass.text);

                  final user = FirebaseAuth.instance.currentUser;
                  final userUid = user!.uid;
                  final ref = FirebaseDatabase.instance.ref(userUid);

                  final Directory systemTempDir = Directory.systemTemp;
                  final byteData =
                      await rootBundle.load("assets/icons/nullUserProfil.jpg");
                  final file = File("${systemTempDir.path}/$userUid");
                  await file.writeAsBytes(byteData.buffer.asInt8List(
                      byteData.offsetInBytes, byteData.lengthInBytes));
                  final storage = FirebaseStorage.instance;
                  TaskSnapshot taskSnapshot = await storage
                      .ref("profilResimleri/$userUid")
                      .putFile(file);
                  final url = await taskSnapshot.ref.getDownloadURL();
                  Map<String, dynamic> userAdd = {
                    "userName": userName.text,
                    "userEmail": userEmail.text,
                    "userPass": userPass.text,
                    "userPhone": userPhone.text,
                    "profilUrl": url
                  };

                  await ref.set(userAdd).whenComplete(() {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Kayıt Başarılı")));
                  });
                } on FirebaseAuthException catch (e) {
                  print("Kayıt başarısız");
                  print(e.code);
                  if (e.code == "email-already-in-use") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Bu Email zaten kayıtlı")));
                  }
                  if (e.code == "weak-password") {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Zayıf Şifre")));
                  }
                  if (e.code == "invalid-email") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Geçersiz Email Adresi")));
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
