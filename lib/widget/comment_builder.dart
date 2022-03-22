import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/comment.dart';
import 'package:vietnam_tourist/models/user.dart';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:vietnam_tourist/providers/user_provider.dart';

class CommentBuilder extends StatefulWidget {
  final Comment comment;

  const CommentBuilder({
    Key? key,
    required this.comment,
  });
  @override
  _CommentBuilderState createState() => _CommentBuilderState();
}

class _CommentBuilderState extends State<CommentBuilder> {
  bool _isLoading = false;
  User user = User();
  @override
  void initState() {
    setState(() {
      _isLoading = true;
      Provider.of<UserProvider>(context, listen: false)
          .fetchAndSetUser(widget.comment.userId.toString())
          .then((value) {
        setState(() {
          user = value;
          _isLoading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Text('...')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                //author if
                ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(serverUrl() + user.avatar.toString()),
                    ),
                    title: Text(
                      user.name.toString(),
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.comment.createdAt.year == DateTime.now().year
                              ? widget.comment.createdAt.month ==
                                      DateTime.now().month
                                  ? widget.comment.createdAt.day ==
                                          DateTime.now().day
                                      ? widget.comment.createdAt.hour ==
                                              DateTime.now().hour
                                          ? widget.comment.createdAt.second ==
                                                  DateTime.now().second
                                              ? (DateTime.now().second -
                                                          widget.comment
                                                              .createdAt.second)
                                                      .toString() +
                                                  " second ago"
                                              : (DateTime.now().minute -
                                                          widget.comment
                                                              .createdAt.minute)
                                                      .toString() +
                                                  " minute ago"
                                          : (DateTime.now().hour -
                                                      widget.comment.createdAt
                                                          .hour)
                                                  .toString() +
                                              " hour ago"
                                      : (DateTime.now().day -
                                                  widget.comment.createdAt.day)
                                              .toString() +
                                          " day ago"
                                  : (DateTime.now().month -
                                              widget.comment.createdAt.month)
                                          .toString() +
                                      " month ago"
                              : widget.comment.createdAt.day.toString() +
                                  "/" +
                                  widget.comment.createdAt.month.toString() +
                                  "/" +
                                  widget.comment.createdAt.year.toString(),
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                          textAlign: TextAlign.left,
                        ))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.comment.content.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),

                Divider(),
              ]);
  }
}
