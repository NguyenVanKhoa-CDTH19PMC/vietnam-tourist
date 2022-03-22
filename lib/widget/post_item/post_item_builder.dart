import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/comment.dart';
import 'package:vietnam_tourist/models/image.dart';
import 'package:vietnam_tourist/models/like.dart';
import 'package:vietnam_tourist/providers/placename_picture_provider.dart';
import 'package:vietnam_tourist/providers/post_comment_provider.dart';
import 'package:vietnam_tourist/providers/post_image_provider.dart';
import 'package:vietnam_tourist/providers/post_like_provider.dart';
import 'package:vietnam_tourist/providers/server_url.dart';

import '../placename_item_builder.dart';
import '/models/placename.dart';
import '/models/post.dart';
import '/models/user.dart';
import '/screens/post_detail.dart';
import '/providers/placename_provider.dart';
import '/providers/user_provider.dart';

import '../image_buider.dart';

List<Color> _mainColor() {
  return [Colors.blue.shade500, Colors.blue.shade700, Colors.blue.shade800];
}

class PostItemBuilder extends StatefulWidget {
  final Post post;

  const PostItemBuilder({Key? key, required this.post});
  @override
  _PostItemBuilderState createState() => _PostItemBuilderState();
}

class _PostItemBuilderState extends State<PostItemBuilder> {
  final EdgeInsets _postPadding =
      EdgeInsets.only(top: 10, bottom: 3, right: 15, left: 15);
  int like = 0;
  int dislike = 0;
  bool _isLoading = false;
  User fetchedUser = User();
  String? firstHalf;
  String? secondHalf;

  bool flag = true;
  Placename fetchedPlacename = Placename();
  List<Picture> fetchedPostPicture = [];
  List<Comment> fetchedPostComment = [];
  int myId = 1;
  bool _liked = true;
  bool _disliked = true;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<UserProvider>(context, listen: false)
        .fetchAndSetUser(widget.post.userId.toString())
        .then((value) {
      setState(() {
        fetchedUser = value;
        _isLoading = false;
      });
    });

    Provider.of<PostPictureProvider>(context, listen: false)
        .fetchAndSetPostPictures(widget.post.id.toString())
        .then((value) {
      setState(() {
        fetchedPostPicture = value;
        _isLoading = false;
      });
    });
    Provider.of<PostCommentProvider>(context, listen: false)
        .fetchAndSetPostComments(widget.post.id.toString())
        .then((value) {
      setState(() {
        fetchedPostComment = value;
        _isLoading = false;
      });
    });
    Provider.of<PlacenameProvider>(context, listen: false)
        .fetchAndSetPlacename(widget.post.placenameId.toString())
        .then((value) {
      setState(() {
        fetchedPlacename = value;

        _isLoading = false;
      });
    });
    Provider.of<PostLikeProvider>(context, listen: false)
        .fetchAndSetPostLikes(widget.post.id.toString())
        .then((value) {
      setState(() {
        like = value.where((w) => w.like == 1).length;
        dislike = value.where((w) => w.like == 0).length;

        _liked = value
                    .where((w) => w.like == 1)
                    .where((w) => w.userId == myId)
                    .length !=
                0
            ? true
            : false;
        _disliked = value
                    .where((w) => w.like == 0)
                    .where((w) => w.userId == myId)
                    .length !=
                0
            ? true
            : false;
        _isLoading = false;
      });
    });
    super.initState();

    if (widget.post.content.toString().length > 100) {
      firstHalf = widget.post.content.toString().substring(0, 100);
      secondHalf = widget.post.content
          .toString()
          .substring(100, widget.post.content.toString().length);
    } else {
      firstHalf = widget.post.content.toString();
      secondHalf = "";
    }
  }

  _likePost(Like li) {
    Provider.of<PostLikeProvider>(context, listen: false)
        .likePost(li)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    Provider.of<PostLikeProvider>(context, listen: false)
        .fetchAndSetPostLikes(widget.post.id.toString())
        .then((value) {
      setState(() {
        like = value.where((w) => w.like == 1).length;
        dislike = value.where((w) => w.like == 0).length;
        _liked = value
                    .where((w) => w.like == 1)
                    .where((w) => w.userId == myId)
                    .length !=
                0
            ? true
            : false;
        _disliked = value
                    .where((w) => w.like == 0)
                    .where((w) => w.userId == myId)
                    .length !=
                0
            ? true
            : false;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Text('...'))
        : Container(
            margin: _postPadding,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              color: Colors.white,
            ),
            child: Container(
                child: Column(
              children: [
                //author's info
                Container(
                  padding:
                      EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 0),
                  child: Row(
                    children: [
                      /// avartar
                      _isLoading
                          ? Text('...')
                          : CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                  serverUrl() + fetchedUser.avatar.toString()),
                            ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _isLoading
                                    ? Text('...')
                                    : Text(
                                        fetchedUser.name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.post.createdAt.year ==
                                          DateTime.now().year
                                      ? widget.post.createdAt.month ==
                                              DateTime.now().month
                                          ? widget.post.createdAt.day ==
                                                  DateTime.now().day
                                              ? widget.post.createdAt.hour ==
                                                      DateTime.now().hour
                                                  ? widget.post.createdAt.second ==
                                                          DateTime.now().second
                                                      ? (DateTime.now().second -
                                                                  widget
                                                                      .post
                                                                      .createdAt
                                                                      .second)
                                                              .toString() +
                                                          " second ago"
                                                      : (DateTime.now().minute -
                                                                  widget
                                                                      .post
                                                                      .createdAt
                                                                      .minute)
                                                              .toString() +
                                                          " minute ago"
                                                  : (DateTime.now().hour - widget.post.createdAt.hour)
                                                          .toString() +
                                                      " hour ago"
                                              : (DateTime.now().day - widget.post.createdAt.day)
                                                      .toString() +
                                                  " day ago"
                                          : (DateTime.now().month - widget.post.createdAt.month)
                                                  .toString() +
                                              " month ago"
                                      : widget.post.createdAt.day.toString() +
                                          "/" +
                                          widget.post.createdAt.month.toString() +
                                          "/" +
                                          widget.post.createdAt.year.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600),
                                  textAlign: TextAlign.left,
                                ))
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider()),
//content

                Container(
                    padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: secondHalf.toString().isEmpty
                          ? new Text(firstHalf.toString())
                          : Column(children: <Widget>[
                              Text(flag
                                  ? (firstHalf.toString() + "...")
                                  : (firstHalf.toString() +
                                      secondHalf.toString())),
                              InkWell(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    new Text(
                                      flag ? "show more" : "show less",
                                      style: new TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    flag = !flag;
                                  });
                                },
                              ),
                            ]),
                    )),

                //show img

                if (fetchedPostPicture.length == 1) ...[
                  // 1 images
                  // Image.asset("assets/images/demo.png")
                  Image.network(serverUrl() +
                      'images/posts/' +
                      widget.post.id.toString() +
                      "/" +
                      fetchedPostPicture.first.path.toString())
                ] else if (fetchedPostPicture.length == 2) ...[
                  if (true) ...[
                    // 2 img h
                    Column(
                      children: [
                        ...(fetchedPostPicture as List<Picture>)
                            .map((post_image) {
                          return ImageBuilder(
                              href: serverUrl() +
                                  'images/posts/' +
                                  widget.post.id.toString() +
                                  "/" +
                                  post_image.path.toString(),
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width -
                                  _postPadding.left -
                                  _postPadding.right);
                        }),
                      ],
                    )
                  ]
                ] else if (fetchedPostPicture.length == 3) ...[
                  // 3 images
                  Column(
                    children: [
                      for (int x = 0; x < 1; x++) ...[
                        ImageBuilder(
                            href: serverUrl() +
                                'images/posts/' +
                                widget.post.id.toString() +
                                "/" +
                                fetchedPostPicture[x].path.toString(),
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width -
                                _postPadding.left -
                                _postPadding.right),
                      ],
                      Row(
                        children: [
                          for (int x = 1; x < 3; x++) ...[
                            ImageBuilder(
                                href: serverUrl() +
                                    'images/posts/' +
                                    widget.post.id.toString() +
                                    "/" +
                                    fetchedPostPicture[x].path.toString(),
                                height: MediaQuery.of(context).size.width / 2,
                                width: (MediaQuery.of(context).size.width -
                                        _postPadding.left -
                                        _postPadding.right) /
                                    2),
                          ],
                        ],
                      )
                    ],
                  )
                ] else if (fetchedPostPicture.length == 4) ...[
                  // 4 images
                  Column(
                    children: [
                      Row(
                        children: [
                          for (int x = 0; x < 2; x++) ...[
                            ImageBuilder(
                                href: serverUrl() +
                                    'images/posts/' +
                                    widget.post.id.toString() +
                                    "/" +
                                    fetchedPostPicture[x].path.toString(),
                                height: MediaQuery.of(context).size.width / 2,
                                width: (MediaQuery.of(context).size.width -
                                        _postPadding.left -
                                        _postPadding.right) /
                                    2),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          for (int x = 2; x < 4; x++) ...[
                            ImageBuilder(
                                href: serverUrl() +
                                    'images/posts/' +
                                    widget.post.id.toString() +
                                    "/" +
                                    fetchedPostPicture[x].path.toString(),
                                height: MediaQuery.of(context).size.width / 2,
                                width: (MediaQuery.of(context).size.width -
                                        _postPadding.left -
                                        _postPadding.right) /
                                    2),
                          ],
                        ],
                      )
                    ],
                  )
                ] else if (fetchedPostPicture.length > 4) ...[
                  // >4 images
                  Column(
                    children: [
                      Row(
                        children: [
                          for (int x = 0; x < 2; x++) ...[
                            ImageBuilder(
                                href: serverUrl() +
                                    'images/posts/' +
                                    widget.post.id.toString() +
                                    "/" +
                                    fetchedPostPicture[x].path.toString(),
                                height: MediaQuery.of(context).size.width / 2,
                                width: (MediaQuery.of(context).size.width -
                                        _postPadding.left -
                                        _postPadding.right) /
                                    2),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          for (int x = 2; x < 4; x++) ...[
                            if (x == 3) ...[
                              ImageBuilder(
                                href: serverUrl() +
                                    'images/posts/' +
                                    widget.post.id.toString() +
                                    "/" +
                                    fetchedPostPicture[x].path.toString(),
                                height: MediaQuery.of(context).size.width / 2,
                                width: (MediaQuery.of(context).size.width -
                                        _postPadding.left -
                                        _postPadding.right) /
                                    2,
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                        child: Center(
                                          child: Text(
                                            "+ " +
                                                (fetchedPostPicture.length - 3)
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ))),
                              )
                            ] else ...[
                              ImageBuilder(
                                  href: serverUrl() +
                                      'images/posts/' +
                                      widget.post.id.toString() +
                                      "/" +
                                      fetchedPostPicture[x].path.toString(),
                                  height: MediaQuery.of(context).size.width / 2,
                                  width: (MediaQuery.of(context).size.width -
                                          _postPadding.left -
                                          _postPadding.right) /
                                      2),
                            ]
                          ],
                        ],
                      )
                    ],
                  )
                ],

                //fooder post

                Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: PlacenameItemBuilder(
                          placename: fetchedPlacename,
                        )),

                        // like button
                        Container(
                          width: 60,
                          child: Column(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    _liked
                                        ? Icons.thumb_up_alt
                                        : Icons.thumb_up_alt_outlined,
                                    color: Colors.green.shade600,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Like a = Like(
                                        postId: widget.post.id,
                                        userId: myId,
                                        like: 1);
                                    _likePost(a);
                                  }),
                              //no. like
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                ),
                                child: Text(
                                  like.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  "like",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          child: Column(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    _disliked
                                        ? Icons.thumb_down_alt
                                        : Icons.thumb_down_alt_outlined,
                                    color: Colors.red.shade600,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Like a = Like(
                                        postId: widget.post.id,
                                        userId: myId,
                                        like: 0);
                                    _likePost(a);
                                  }),
                              //no. like
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                ),
                                child: Text(
                                  dislike.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  "dislike",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              )
                            ],
                          ),
                        ),
                        //cmt button
                        Container(
                          width: 60,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.message,
                                  color: Colors.grey.shade600,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetail(
                                            post: widget.post,
                                          )),
                                ),
                              ),

                              //no. comt
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  fetchedPostComment.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  "comment",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                      fontSize: 11),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            )));
  }
}
