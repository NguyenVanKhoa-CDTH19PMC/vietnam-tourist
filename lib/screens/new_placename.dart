// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';
import 'package:vietnam_tourist/widget/text_form_field_builder.dart';

class NewPlacename extends StatefulWidget {
  const NewPlacename({Key? key}) : super(key: key);
  @override
  _NewPlacenameState createState() => _NewPlacenameState();
}

class _NewPlacenameState extends State<NewPlacename> {
  Container buildNewPlacenameForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: const [
          TextFormBuilder(
              hintText: "Name...",
              prefixIcon: Icons.location_history_sharp,
              suffixIcon: Icons.near_me),
          TextFormBuilder(
              hintText: "Longitude...",
              prefixIcon: Icons.location_city,
              suffixIcon: Icons.near_me),
          TextFormBuilder(
              hintText: "Latitude...",
              prefixIcon: Icons.location_history_sharp,
              suffixIcon: Icons.near_me),
          TextFormBuilder(
              hintText: "Description...",
              prefixIcon: Icons.description,
              suffixIcon: Icons.near_me),
          TextFormBuilder(
              hintText: "Specialties...",
              prefixIcon: Icons.spellcheck,
              suffixIcon: Icons.near_me)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.grey.shade200,
        title: Row(
          children: [
            Container(
              child: Text(
                "SEND NEW PLACENAME",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      body: Container(
          color: Colors.white,
          child: ListView(children: [
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                "Let's give us somewhere you experienced",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
              child: const Text(
                "We're really excited and appriciate your kindness that help us develop our app",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            buildNewPlacenameForm(),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 30),
                    height: 75,
                    width: 75,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(' + Add '),
                    )),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                Container(
                    //  padding: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                    child: Column(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("assets/images/demo.jpg"),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            )
          ])),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [ButtonBuilder(text: "Send")],
          ),
        ),
      ),
    );
  }
}
