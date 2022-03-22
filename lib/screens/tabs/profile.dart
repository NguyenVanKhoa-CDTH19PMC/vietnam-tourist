import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/providers/post_provider.dart';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:vietnam_tourist/widget/post_item/post_item_builder.dart';
import '../login.dart';
import '../signup.dart';
import '/screens/edit_profile.dart';
import 'package:vietnam_tourist/providers/auth.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';

class Profile extends StatefulWidget {
  // In the constructor, require a Todo.
  const Profile({
    Key? key,
  }) : super(key: key);

  // Declare a field that holds the Todo.

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = const FlutterSecureStorage();
  bool _isLoading = false;
  String? token;
  String? name = '';
  String? id = '';
  String? isLogined = 'n';
  List<Post> fetchedPosts = [];
  Future<void> getToken() async {
    token = (await storage.read(key: 'token'));
    name = (await storage.read(key: 'name'));
    id = (await storage.read(key: 'id'));
    isLogined = (await storage.read(key: 'isLogined'));
    _isLoading = false;
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getToken();
    Provider.of<PostProvider>(context, listen: false)
        .fetchAndSetPosts()
        .then((value) {
      setState(() {
        fetchedPosts = value.where((a) => a.userId == id).toList();
        _isLoading = false;
      });
    });
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Consumer<AuthcubitCubit>(builder: (context, auth, child) {
          return _isLoading
              ? Text('---')
              : auth.accessToken.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonBuilder(
                          text: 'LOGIN',
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login())),
                        ),
                        TextButton(
                          child: Text("Sign up if you don't have account!"),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup())),
                        ),
                      ],
                    ))
                  : _isLoading
                      ? Text('---')
                      : CustomScrollView(slivers: <Widget>[
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            pinned: true,
                            floating: false,
                            toolbarHeight: 5.0,
                            collapsedHeight: 6.0,
                            expandedHeight: 200.0,
                            flexibleSpace: FlexibleSpaceBar(
                                background: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.0, top: 30),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            serverUrl() +
                                                                auth.user.avatar
                                                                    .toString()),
                                                    radius: 40.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 20.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 32.0),
                                                    Row(
                                                      children: [
                                                        const Visibility(
                                                          visible: false,
                                                          child: SizedBox(
                                                              width: 10.0),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                auth.user.name
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        22.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                                maxLines: null,
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  auth.user
                                                                      .email
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    // color: Color(0xff4D4D4D),
                                                                    fontSize:
                                                                        15.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // InkWell(
                                                        //   onTap: () {},
                                                        //   child: Column(
                                                        //     children: [
                                                        //       Icon(Icons.settings,
                                                        //           color:
                                                        //               Theme.of(context)
                                                        //                   .accentColor),
                                                        //       const Text(
                                                        //         'settings',
                                                        //         style: TextStyle(
                                                        //             fontSize: 11.5),
                                                        //       )
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(_isLoading
                                                      ? ""
                                                      : fetchedPosts.length
                                                          .toString()),
                                                  Text('POSTS')
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('0'),
                                                  Text('FOLLOWERS')
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('0'),
                                                  Text('FOLLOWING')
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          // Column(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: [
                                          //     ButtonBuilder(
                                          //       text: "Edit Profile",
                                          //       onPressed: () => Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 EditProfile()),
                                          //       ),
                                          //     )
                                          //   ],
                                          // )
                                        ]))),
                          ),
                          // _isLoading
                          //     ? const Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     : ListView.builder(
                          //         itemCount: fetchedPosts
                          //             .where((a) => a.userId == auth.user.id)
                          //             .length,
                          //         itemBuilder: (context, index) =>
                          //             PostItemBuilder(
                          //                 post: fetchedPosts
                          //                     .where((a) =>
                          //                         a.userId == auth.user.id)
                          //                     .toList()[index]),
                          //       )
                        ]);
        }));
  }
}
