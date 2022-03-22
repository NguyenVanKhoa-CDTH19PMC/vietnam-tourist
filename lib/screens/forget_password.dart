import 'package:flutter/material.dart';
import '/screens/signup.dart';
import '/widget/button_builder.dart';
import '/widget/text_form_field_builder.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    Widget title = Text("Fogget ForgetPassword");

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Center(
              child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Center(
            child: Text(
              'Fogget ForgetPassword',
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          TextFormBuilder(
            hintText: " Email",
            prefixIcon: Icons.email,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 130,
                  height: 40,
                  child: Text(
                    ' Send code again',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ButtonBuilder(
            text: "Send",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?  ",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
