import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnam_tourist/providers/server_url.dart';

class HearderPostBuilder extends StatefulWidget {
  const HearderPostBuilder({
    Key? key,
  });
  @override
  _HearderPostBuilderState createState() => _HearderPostBuilderState();
}

class _HearderPostBuilderState extends State<HearderPostBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          /// avartar
          const CircleAvatar(
            radius: 22,
            backgroundImage:
                NetworkImage("http://127.0.0.1:8000/images/placenames/1/4.png"),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nguyễn Văn Khoa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Public",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      textAlign: TextAlign.left,
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
