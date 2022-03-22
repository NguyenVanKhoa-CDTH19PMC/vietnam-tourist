import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/comment.dart';
import 'package:vietnam_tourist/models/like.dart';
import 'package:vietnam_tourist/models/placename.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/models/image.dart';
import 'package:vietnam_tourist/models/user.dart';
import 'package:vietnam_tourist/providers/placename_picture_provider.dart';
import 'package:vietnam_tourist/providers/placename_provider.dart';
import 'package:vietnam_tourist/providers/post_comment_provider.dart';
import 'package:vietnam_tourist/providers/post_image_provider.dart';
import 'package:vietnam_tourist/providers/post_like_provider.dart';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:vietnam_tourist/providers/user_provider.dart';
import 'package:vietnam_tourist/widget/comment_builder.dart';
import 'package:vietnam_tourist/widget/placename_item_builder.dart';
import 'package:vietnam_tourist/widget/text_form_field_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  const PostDetail({
    Key? key,
    required this.post,
  });

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isLoading = false;
  User fetchedUser = User();
  int like = 0;
  int dislike = 0;
  Placename fetchedPlacename = Placename();
  List<Picture> fetchedPostPicture = [];
  List<Comment> fetchedPostComment = [];
  int myId = 1;
  bool _liked = true;
  bool _disliked = true;
  TextEditingController _content = TextEditingController();
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
    Provider.of<PlacenameProvider>(context, listen: false)
        .fetchAndSetPlacename(widget.post.placenameId.toString())
        .then((value) {
      setState(() {
        fetchedPlacename = value;
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
  }

  _commentPost(String userId, postId, content) {
    Provider.of<PostCommentProvider>(context, listen: false)
        .commentPost(userId, postId, content)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    _content.text = "";
    Provider.of<PostCommentProvider>(context, listen: false)
        .fetchAndSetPostComments(widget.post.id.toString())
        .then((value) {
      setState(() {
        fetchedPostComment = value;
        _isLoading = false;
      });
    });
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "COMMENTS",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: [
          ///author if
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0)),
              color: Colors.white,
            ),
            child:

                ///author if
                Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /// avartar
                            _isLoading
                                ? Text('...')
                                : CircleAvatar(
                                    radius: 22,
                                    backgroundImage: NetworkImage(serverUrl() +
                                        fetchedUser.avatar.toString()),
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
                                      child: Text(
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
                                                                DateTime.now()
                                                                    .second
                                                            ? (DateTime.now().second - widget.post.createdAt.second)
                                                                    .toString() +
                                                                " second ago"
                                                            : (DateTime.now().minute - widget.post.createdAt.minute)
                                                                    .toString() +
                                                                " minute ago"
                                                        : (DateTime.now().hour -
                                                                    widget
                                                                        .post
                                                                        .createdAt
                                                                        .hour)
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
                        Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Divider()),
                        Container(
                          padding:
                              EdgeInsets.only(right: 10, left: 10, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.post.content.toString(),
                              style: TextStyle(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    )),
          ),
          fetchedPostPicture.length == 0
              ? Container()
              : Container(
                  color: Colors.white,
                  child: CarouselSlider.builder(
                      itemCount: fetchedPostPicture.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Builder(builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(serverUrl() +
                                      'images/posts/' +
                                      widget.post.id.toString() +
                                      "/" +
                                      fetchedPostPicture[itemIndex]
                                          .path
                                          .toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                      options: CarouselOptions(height: 300.0)),
                ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0)),
              color: Colors.white,
            ),
            child: Container(
                padding:
                    EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
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
                              onPressed: null),

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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (fetchedPostComment.length == 0) ...[
                Align(
                    alignment: Alignment.center,
                    child: Text("No comment still!"))
              ] else ...[
                ...(fetchedPostComment).map(
                  (e) => CommentBuilder(comment: e),
                ),
              ]
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white.withOpacity(0),
        height: 75,
        child: BottomAppBar(
            child: Container(
          padding: EdgeInsets.only(left: 15, right: 5),
          child: Row(
            children: [
              Expanded(
                child: TextFormBuilder(
                  controller: _content,
                  hintText: "How about that?",
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send, color: Colors.grey.shade600),
                  onPressed: () {
                    _commentPost(myId.toString(), widget.post.id,
                        _content.text.isEmpty ? "" : _content.text);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
