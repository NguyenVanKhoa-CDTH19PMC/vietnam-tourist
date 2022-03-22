// ignore_for_file: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';
import 'package:vietnam_tourist/widget/text_form_field_builder.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          title:
              // nut search
              Container(
                  child: Row(
            children: [
              Text('Edit Profile'),
            ],
          ))),
      body: Container(
          child: ListView(children: [
        // cai nay cai chu tieu de
        Container(
            child: Text(
          "Edit Personal Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          textAlign: TextAlign.center,
        )),

// cai nay avtar
        Container(
            width: 190.0,
            height: 190.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage("assets/images/demo.png")))),

// chinh cac text thay doi
        TextFormBuilder(
          hintText: "Name",
          prefixIcon: Icons.location_history_sharp,
          suffixIcon: Icons.edit,
          initialValue: "Nguyen zan khoa",
        ),
        TextFormBuilder(
          hintText: "Phone",
          prefixIcon: Icons.phone,
          suffixIcon: Icons.edit,
          initialValue: '0101040607',
        ),
        TextFormBuilder(
          hintText: "Born",
          prefixIcon: Icons.brightness_high,
          suffixIcon: Icons.edit,
          initialValue: '28/05/1995',
        ),
        TextFormBuilder(
          hintText: "Sex",
          prefixIcon: Icons.skip_next_outlined,
          suffixIcon: Icons.edit,
          initialValue: 'Nam',
        ),
        TextFormBuilder(
          hintText: "Gmail",
          prefixIcon: Icons.report_gmailerrorred,
          suffixIcon: Icons.edit,
          initialValue: 'boy123@gmai.com',
        ),
        TextFormBuilder(
          hintText: "Address",
          prefixIcon: Icons.add_reaction,
          suffixIcon: Icons.edit,
          initialValue: '21 Binh loi, TP.HCM',
        ),
        TextButton(
          onPressed: () {
            // Respond to button press
          },
          // cai nay doi matkhau
          child: Text("Change Password"),
        )
      ])),
      // nut save o duoi
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [ButtonBuilder(text: "Save")],
          ),
        ),
      ),
    );
  }
}
