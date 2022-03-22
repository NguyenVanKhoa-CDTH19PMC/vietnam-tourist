import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/signup.dart';
import 'main_screen.dart';
import '/widget/button_builder.dart';
import '/widget/text_form_field_builder.dart';

import '../providers/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Widget title = Text("Đăng Nhập ");

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
                    content: Text("Loged in with success !"),
                  ),
                );

                await Future.delayed(Duration(seconds: 2));
                // Navigator.pushNamed(context, '/main_screen');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TabScreen()));
              } else if (state is AuthcubitFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Loged in Failed !"),
                  ),
                );
              }
            },
            child: Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(children: [
                    Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/logo.png",
                              width: 70,
                              height: 70,
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                'Welcome back!',
                                style: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Log into your account and get started!',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            TextFormBuilder(
                              controller: _emailController,
                              // validateFunction: (value) => value!.isEmpty
                              //     ? "please enter valid email"
                              //     : "",
                              hintText: "Email",
                              prefixIcon: Icons.email,
                            ),
                            TextFormBuilder(
                              // validateFunction: (value) => value!.isEmpty
                              //     ? "please enter valid password"
                              //     : "",
                              controller: _passwordController,
                              hintText: "Password",
                              prefixIcon: Icons.lock,
                              obscureText: true,
                            ),
                            // Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(left: 0.0),
                            //     child: InkWell(
                            //       onTap:
                            //           () {}, //=> viewModel.forgotPassword(context),
                            //       child: Container(
                            //         width: 130,
                            //         height: 40,
                            //         child: Align(
                            //           alignment: Alignment.bottomCenter,
                            //           child: TextButton(
                            //             onPressed: () => Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         ForgetPassword())),
                            //             child: Text(
                            //               'Forgot Password?',
                            //               style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 10.0),
                            ButtonBuilder(
                              onPressed: () {
                                BlocProvider.of<AuthcubitCubit>(context)
                                    .loginMethod(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                              },
                              text: "LOG IN",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?  ",
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
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
                        ))
                  ])),
            )));
  }
}
