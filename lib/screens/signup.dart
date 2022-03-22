import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/login.dart';
import 'package:vietnam_tourist/providers/auth.dart';

import '/widget/button_builder.dart';
import '/widget/text_form_field_builder.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget title = Text("Đăng kí Tài Khoản");

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocListener<AuthcubitCubit, AuthcubitState>(
          listener: (context, state) async {
            if (state is AuthcubitLoged) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("Signuped in with success !"),
                ),
              );

              await Future.delayed(Duration(seconds: 2));
              // Navigator.pushNamed(context, '/main_screen');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            } else if (state is AuthcubitFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("Signuped in Failed !"),
                ),
              );
            }
          },
          child: Scaffold(
              body: Center(
                  child: Container(
                      padding: EdgeInsets.all(30),
                      child: ListView(
                        children: <Widget>[
                          Container(
                              width: 100,
                              height: 50,
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                "SIGNUP",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                          TextFormBuilder(
                            controller: _emailController,
                            hintText: "Email",
                            prefixIcon: Icons.email,
                          ),
                          TextFormBuilder(
                              controller: _nameController,
                              hintText: "Name",
                              prefixIcon: Icons.supervisor_account_rounded),
                          TextFormBuilder(
                            controller: _passwordController,
                            hintText: "Password",
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          TextFormBuilder(
                            controller: _confirmPasswordController,
                            hintText: "Confirm Password",
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          SizedBox(height: 10.0),
                          ButtonBuilder(
                            text: "SIGN UP",
                            onPressed: () {
                              BlocProvider.of<AuthcubitCubit>(context)
                                  .registerMethod(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      confirmPassword: _passwordController.text,
                                      name: _nameController.text);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account  ',
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login())),
                                  child: Text('Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))),
        ));
  }
}
