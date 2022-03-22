import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/image.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/providers/placename_like_provider.dart';
import 'package:vietnam_tourist/providers/placename_picture_provider.dart';
import 'package:vietnam_tourist/providers/post_provider.dart';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:vietnam_tourist/screens/placename_details.dart';
import '/models/placename.dart';

class PlacenameItemBuilder extends StatefulWidget {
  final Placename placename;

  const PlacenameItemBuilder({
    Key? key,
    required this.placename,
  });
  @override
  _PlacenameItemBuilderState createState() => _PlacenameItemBuilderState();
}

class _PlacenameItemBuilderState extends State<PlacenameItemBuilder> {
  List<Picture> fetchedPlacenamePicture = [];
  List<Post> fetchedPosts = [];
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(milliseconds: 300)).then((_) {
        Provider.of<PlacenamePictureProvider>(context, listen: false)
            .fetchAndSetPlacenamePictures(widget.placename.id.toString())
            .then((value) {
          setState(() {
            fetchedPlacenamePicture = value;
            _isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/placenamedetail',
            arguments: widget.placename,
          );
        },
        child: Row(
          children: [
            Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  //  border: Border.all(width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      widget.placename.name.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.placename.area.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
          ],
        ));
  }
}

class PlacenameFullItemBuilder extends StatefulWidget {
  final Placename placename;

  const PlacenameFullItemBuilder({Key? key, required this.placename});
  @override
  _PlacenameItemFullBuilderState createState() =>
      _PlacenameItemFullBuilderState();
}

class _PlacenameItemFullBuilderState extends State<PlacenameFullItemBuilder> {
  List<Picture> fetchedPlacenamePicture = [];
  List<Post> fetchedPosts = [];
  int like = 0;
  int dislike = 0;
  int share = 0;
  bool _isLoading = false;
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
        _isLoading = false;
      });
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
    share =
        fetchedPosts.where((w) => w.placename == widget.placename.id).length;
    return _isLoading
        ? Text('...')
        : Container(
            padding: EdgeInsets.only(right: 15, left: 15),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlacenameDetail(placename: widget.placename)));
                },
                child: Row(
                  children: [
                    _isLoading
                        ? Text('...')
                        : Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width / 3 - 15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(serverUrl() +
                                    fetchedPlacenamePicture
                                        .firstWhere((element) => true,
                                            orElse: () => Picture())
                                        .path
                                        .toString()),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6.0),
                                  topLeft: Radius.circular(6.0)),
                            ),
                            alignment: Alignment.center,
                          ),
                    Container(
                        height: 80,
                        width:
                            MediaQuery.of(context).size.width / 3 * 2 - 15 - 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //  border: Border.all(width: 4),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(6.0),
                              topRight: Radius.circular(6.0)),
                        ),
                        padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.placename.name.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  widget.placename.description.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              size: 17,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(like.toString()),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_down,
                                              size: 17,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(dislike.toString()),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Icon(
                                              Icons.share,
                                              size: 17,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(share.toString()),
                                          ],
                                        ))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ])),
                    Container(
                      height: 80,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.share_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6.0),
                            topRight: Radius.circular(6.0)),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                )));
  }
}

class PlacenameDemoItemBuilder extends StatefulWidget {
  final Placename placename;

  const PlacenameDemoItemBuilder({Key? key, required this.placename});
  @override
  _PlacenameDemoItemBuilderState createState() =>
      _PlacenameDemoItemBuilderState();
}

class _PlacenameDemoItemBuilderState extends State<PlacenameDemoItemBuilder> {
  List<Picture> fetchedPlacenamePicture = [];
  bool _isLoading = false;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlacenameDetail(placename: widget.placename)));
      },
      child: _isLoading
          ? Text('...')
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(serverUrl() +
                      fetchedPlacenamePicture
                          .firstWhere((element) => true,
                              orElse: () => Picture())
                          .path
                          .toString()),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
            ),
    ));
  }
}
