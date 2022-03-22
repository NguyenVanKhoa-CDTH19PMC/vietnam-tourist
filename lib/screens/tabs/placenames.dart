import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/placename.dart';
import 'package:vietnam_tourist/providers/placename_provider.dart';
import 'package:vietnam_tourist/screens/search.dart';
import 'package:vietnam_tourist/widget/placename_item_builder.dart';
import 'package:vietnam_tourist/widget/text_form_field_builder.dart';

class Placenames extends StatefulWidget {
  @override
  _PlacenamesState createState() => _PlacenamesState();
}

class _PlacenamesState extends State<Placenames> {
  bool _isLoading = false;

  List<Placename> fetchedPlacenames = [];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      Provider.of<PlacenameProvider>(context, listen: false)
          .fetchAndSetPlacenames()
          .then((value) {
        setState(() {
          fetchedPlacenames = value;
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final southPlacenames = fetchedPlacenames
        .where((w) => w.area.toString().toLowerCase() == 'south')
        .toList();
    final centralPlacenames = fetchedPlacenames
        .where((w) => w.area.toString().toLowerCase() == 'central')
        .toList();
    final northPlacenames = fetchedPlacenames
        .where((w) => w.area.toString().toLowerCase() == 'north')
        .toList();
    print(fetchedPlacenames.length);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add_placename');
              },
              icon: Icon(
                Icons.add,
                color: Colors.blue,
              ))
        ],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/search');
          },
          child: TextFormBuilder(
              enabled: false,
              prefixIcon: Icons.search,
              hintText: "Enter placename's name..."),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15, left: 15),
                  child: Text(
                    "Top Placename",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval:
                              Duration(seconds: 4), // thoi gian chy
                          height: 150,
                          // onPageChanged: (index, reason) {
                          //   setState(
                          //     () {
                          //       _currentIndex = index;
                          //     },
                          //   );
                          // },
                        ),
                        items: fetchedPlacenames
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        PlacenameDemoItemBuilder(
                                            placename: item),
                                        Center(
                                          child: Text(
                                            " " + item.name.toString() + " ",
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor: Colors.black45,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: fetchedPlacenames.map((urlOfItem) {
                //     int index = fetchedPlacenames.indexOf(urlOfItem);
                //     return Container(
                //       width: 10.0,
                //       height: 10.0,
                //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2.0),
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: _currentIndex == index
                //             ? Color.fromRGBO(0, 0, 0, 0.8)
                //             : Color.fromRGBO(0, 0, 0, 0.3),
                //       ),
                //     );
                //   }).toList(),
                // ),
                Container(
                  margin:
                      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                  child: Text(
                    "New Placename",
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
                        itemCount: fetchedPlacenames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PlacenameFullItemBuilder(
                                placename: fetchedPlacenames[index],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
                Container(
                  margin:
                      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                  child: Text(
                    "South Placename",
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
                        itemCount: southPlacenames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PlacenameFullItemBuilder(
                                placename: southPlacenames[index],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
                Container(
                  margin:
                      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                  child: Text(
                    "Central Placename",
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
                        itemCount: centralPlacenames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PlacenameFullItemBuilder(
                                placename: centralPlacenames[index],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
                Container(
                  margin:
                      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                  child: Text(
                    "North Placename",
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
                        itemCount: northPlacenames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PlacenameFullItemBuilder(
                                placename: northPlacenames[index],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
              ],
            ),
    );
  }
}
