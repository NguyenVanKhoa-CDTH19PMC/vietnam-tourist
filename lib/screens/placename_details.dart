import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/image.dart';
import 'package:vietnam_tourist/models/like.dart';
import 'package:vietnam_tourist/models/placename.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/providers/placename_like_provider.dart';
import 'package:vietnam_tourist/providers/placename_picture_provider.dart';
import 'package:vietnam_tourist/providers/placename_type_provider.dart';
import 'package:vietnam_tourist/providers/post_provider.dart';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';
import 'package:vietnam_tourist/widget/post_item/post_item_builder.dart';
import 'package:map_launcher/map_launcher.dart';

class PlacenameDetail extends StatefulWidget {
  const PlacenameDetail({Key? key, required this.placename}) : super(key: key);
  final Placename placename;

  @override
  _PlacenameDetailState createState() => _PlacenameDetailState();
}

class _PlacenameDetailState extends State<PlacenameDetail> {
  int like = 0;
  int dislike = 0;
  int share = 0;
  List<Post> fetchedPosts = [];
  String fetchedType = '';
  List<Picture> fetchedPlacenamePicture = [];
  bool _isLoading = false;
  int myId = 1;
  bool _liked = true;
  bool _disliked = true;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<PlacenamePictureProvider>(context, listen: false)
        .fetchAndSetPlacenamePictures(widget.placename.id.toString())
        .then((value) {
      setState(() {
        fetchedPlacenamePicture = value;
        _isLoading = false;
      });
    });
    Provider.of<PlacenameLikeProvider>(context, listen: false)
        .fetchAndSetPlacenameLikes(widget.placename.id.toString())
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
    Provider.of<PostProvider>(context, listen: false)
        .fetchAndSetPosts()
        .then((value) {
      setState(() {
        fetchedPosts =
            value.where((w) => w.placenameId == widget.placename.id).toList();
        _isLoading = false;
      });
    });
    Provider.of<PlacenameTypeProvider>(context, listen: false)
        .fetchAndSetPlacenameTypes(widget.placename.id.toString())
        .then((value) {
      setState(() {
        for (var i = 0; i < value.length; i++) {
          if (i == 0) fetchedType = fetchedType + value[i].type.toString();
          fetchedType = fetchedType + ", " + value[i].type.toString();
        }

        _isLoading = false;
      });
    });
    super.initState();
  }

  _likePlacename(Like li) {
    Provider.of<PlacenameLikeProvider>(context, listen: false)
        .likePlacename(li)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    Provider.of<PlacenameLikeProvider>(context, listen: false)
        .fetchAndSetPlacenameLikes(widget.placename.id.toString())
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
        appBar: AppBar(
          actions: [
            ButtonBuilder(
              text: 'GO',
              onPressed: () {
                MapLauncher.showMarker(
                  mapType: MapType.google,
                  coords: Coords(
                      widget.placename.latitude, widget.placename.latitude),
                  title: widget.placename.name.toString(),
                );
              },
            )
          ],
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
          title: Row(
            children: [
              Container(
                child: Text(
                  widget.placename.name.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        body: ListView(
          children: [
            fetchedPlacenamePicture.length == 0
                ? Container()
                : Container(
                    color: Colors.white,
                    child: CarouselSlider.builder(
                        itemCount: fetchedPlacenamePicture.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Builder(builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(serverUrl() +
                                        fetchedPlacenamePicture[itemIndex]
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
                //  padding: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      Text(
                          widget.placename.latitude.toString() +
                              ":" +
                              widget.placename.longitude.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            )),

            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  _isLoading
                      ? Text('')
                      : Text(
                          'Type: ' + fetchedType,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueAccent),
                        ),
                  Divider(),
                  Text(
                    "DESCRIPTION",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.placename.description.toString(),
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "SPECIALTIES",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.placename.specialties.toString(),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              child: Text(
                "Posts about",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: fetchedPosts.length,
                    itemBuilder: (context, index) =>
                        PostItemBuilder(post: fetchedPosts[index]),
                  )
            // con 1 cai cmt
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white.withOpacity(0),
          height: 50,
          child: BottomAppBar(
              child: Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _liked
                                  ? Icons.thumb_up_alt
                                  : Icons.thumb_up_alt_outlined,
                              size: 22,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              Like a = Like(
                                  postId: widget.placename.id,
                                  userId: myId,
                                  like: 1);
                              _likePlacename(a);
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(like.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _disliked
                                  ? Icons.thumb_down_alt
                                  : Icons.thumb_down_alt_outlined,
                              size: 22,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Like a = Like(
                                  postId: widget.placename.id,
                                  userId: myId,
                                  like: 0);
                              _likePlacename(a);
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(dislike.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              size: 22,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(share.toString()),
                        ],
                      )
                    ],
                  ))),
        ));
  }
}
