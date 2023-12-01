// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/companents/myloginbutton.dart';
import 'package:twitter_clone/pages/basepage.dart';
import 'package:twitter_clone/pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(height: 80),
              Text(
                "Twitter'a giriş yap",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(height: 50),
              MyLoginButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.google,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Google ile giriş yap")
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.002),
              MyLoginButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.apple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Apple ile giriş yap",
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      thickness: 3,
                      endIndent: 5,
                      indent: 65,
                    ),
                  ),
                  Text(
                    "veya",
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      indent: 4,
                      thickness: 3,
                      endIndent: 65,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 70, right: 70),
                padding: EdgeInsets.only(left: 7, right: 7),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: userEmail,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    labelText:
                        "Telefon numarası, email veya kullanıcı adı giriniz",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 70, right: 70),
                padding: EdgeInsets.only(left: 7, right: 7),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: userPass,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: userEmail.text, password: userPass.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BasePage()));
                    } on FirebaseAuthException catch (e) {
                      print("Hatalı Giriş");
                      print(e.code);
                      if (e.code == "user-not-found") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Mail adresi yalnış")));
                      }
                      if (e.code == "wrong-password") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Hatalı Şifre")));
                      }
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    labelText: "Şifrenizi giriniz...",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MyLoginButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("İleri"),
                  ],
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: userEmail.text, password: userPass.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BasePage()));
                  } on FirebaseAuthException catch (e) {
                    print("Hatalı Giriş");
                    print(e.code);
                    if (e.code == "user-not-found") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Mail adresi yalnış")));
                    }
                    if (e.code == "wrong-password") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Hatalı Şifre")));
                    }
                  }
                },
              ),
              SizedBox(height: size.height * 0.002),
              MyLoginButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Şifreni mi Unuttun?"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 70),
                child: Row(
                  children: [
                    Text(
                      "Henüz bir hesabın yok mu?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "Kaydol",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
