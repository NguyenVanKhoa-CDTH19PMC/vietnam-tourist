import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/placename.dart';
import 'package:vietnam_tourist/providers/placename_provider.dart';
import 'package:vietnam_tourist/providers/post_provider.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vietnam_tourist/widget/placename_item_builder.dart';
import '/widget/post_item/header.dart';

// import 'package:image_picker/image_picker.dart';
enum ImageSourceType { gallery, camera }

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _contentController = TextEditingController();
  List<File> _images = [];

  final _picker = ImagePicker();
  bool _isLoading = false;
  List<Placename> fetchedPlacename = [];
  String _choosedPlacenameId = '-1';
  String _choosedPlacenameName = '';
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<PlacenameProvider>(context, listen: false)
        .fetchAndSetPlacenames()
        .then((value) {
      setState(() {
        fetchedPlacename = value;
        _isLoading = false;
      });
    });

    super.initState();
  }

  void post() async {
    Provider.of<PostProvider>(context, listen: false)
        .createPost("1", _choosedPlacenameId, _contentController.text, _images)
        .then((_) {
      setState(() {
        Navigator.pop(context);
        // _isLoading = false;
      });
    });
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
    Navigator.pop(context);
  }

  _getFromGallery() async {
    List<XFile>? pickedFile = await ImagePicker().pickMultiImage();
    if (pickedFile != null) {
      setState(() {
        for (var file in pickedFile) {
          _images.add(File(file.path));
        }
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        actions: [
          ButtonBuilder(
            text: 'POST',
            onPressed: () {
              post();
            },
          )
        ],
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "Create post",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: ListView(children: [
          ///author if
          HearderPostBuilder(),
          _isLoading
              ? Text('')
              : Container(
                  color: Colors.white.withOpacity(0),
                  height: 50,
                  child: Column(children: [
                    DropdownButton<Placename>(
                        hint: Text(_choosedPlacenameId == '-1'
                            ? "Choose placename"
                            : _choosedPlacenameName),
                        items: fetchedPlacename.map((Placename value) {
                          return DropdownMenuItem<Placename>(
                            value: value,
                            child: Text(value.name.toString()),
                          );
                        }).toList(),
                        onChanged: (s) {
                          setState(() {
                            _choosedPlacenameId = s!.id.toString();
                            _choosedPlacenameName = s.name.toString();
                          });
                        }),
                  ]),
                ),
          TextFormField(
            maxLength: 300,
            controller: _contentController,
            decoration: const InputDecoration(
              hintText: "What's your mind?",
              border: InputBorder.none,
            ),

            minLines: 1,
            maxLines: 10, // allow user to enter 5 line in textfield
            keyboardType: TextInputType
                .multiline, // user keyboard will have a button to move cursor to next line
            // controller: _Textcontroller,
          ),
          GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(_images.length + 1, (index) {
                return index == _images.length
                    ? InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonBuilder(
                                      onPressed: () => _getFromCamera(),
                                      text: 'Camera'),
                                  ButtonBuilder(
                                      onPressed: () => _getFromGallery(),
                                      text: 'Gallery'),
                                ],
                              ),
                            ),
                          );

                          // call choose image function
                        },
                        child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: Text('Add Image')))
                    : Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: Column(
                          children: [
                            Expanded(
                                child: Image.file(_images[index],
                                    fit: BoxFit.cover)),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _images.removeAt(index);
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    color: Colors.white,
                                    child: Text('Remove')))
                          ],
                        ));
              }))
        ]),
      ),
    );
  }
}
