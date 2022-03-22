import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/widget/icon_button_builder.dart';
import 'package:vietnam_tourist/widget/post_item/post_item_builder.dart';
import '/providers/post_provider.dart';

// import 'package:social_media_app/auth/login/login.dart';
// import 'package:social_media_app/auth/register/register.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool _isLoading = false;
  List<Post> fetchedPosts = [];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<PostProvider>(context, listen: false)
        .fetchAndSetPosts()
        .then((value) {
      setState(() {
        fetchedPosts = value;
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(children: [
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'assets/images/logo_full.png',
                  height: 15.0,
                  fit: BoxFit.cover,
                )),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: IconButtonBuilder(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/search'),
                        icon: Icon(Icons.search))))
          ]),
          backgroundColor: Colors.grey.shade200,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: fetchedPosts.length,
                itemBuilder: (context, index) =>
                    PostItemBuilder(post: fetchedPosts[index]),
              ));
  }
}
