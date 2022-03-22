import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/login.dart';
import '/screens/signup.dart';

import '/widget/button_builder.dart';
import '/widget/text_form_field_builder.dart';
// import 'package:social_media_app/auth/login/login.dart';
// import 'package:social_media_app/auth/register/register.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 30, left: 30),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo img
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Vietnam Tourist',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Ubuntu-Regular',
                    ),
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBuilder(
                text: "LOGIN",
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login())),
              ),
              ButtonBuilder(
                text: "SIGN UP",
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signup())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
