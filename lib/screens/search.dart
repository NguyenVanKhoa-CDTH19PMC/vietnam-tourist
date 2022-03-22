import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vietnam_tourist/models/placename.dart';
import 'package:vietnam_tourist/providers/placename_provider.dart';
import 'package:vietnam_tourist/widget/button_builder.dart';
import 'package:vietnam_tourist/widget/placename_item_builder.dart';
import 'package:vietnam_tourist/widget/text_form_field_builder.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();
  List<Placename> fetchedPlacenames = [];
  List<Placename> searchPlacenames = [];
  String _area = 'All';
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<PlacenameProvider>(context, listen: false)
        .fetchAndSetPlacenames()
        .then((value) {
      setState(() {
        fetchedPlacenames = value;
        _isLoading = false;
      });
    });
    super.initState();
  }

  search(String value) {
    setState(() {
      //tim chinh xac
      searchPlacenames = fetchedPlacenames
          .where((w) => w.name.toString().toLowerCase() == value.toLowerCase())
          .toList();

      //tim gan dung
      if (searchPlacenames.length == 0) {
        searchPlacenames = fetchedPlacenames
            .where((w) =>
                w.name.toString().toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
      if (value.length == 0) {
        searchPlacenames = [];
      }
      // if(_area.toLowerCase()!='all')
      // {
      //   searchPlacenames=searchPlacenames.
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => PlacenameProvider(),
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey.shade200,
            title: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextFormBuilder(
                    hintText: "Enter placename's name...",
                    controller: _searchController,
                    onChange: (String) {
                      search(_searchController.text);
                    }),
          ),
          body: ListView(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text('Area: '),
                      DropdownButton<String>(
                          hint: Text(_area),
                          items: <String>['All', 'South', 'Central', 'North']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (s) {})
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchPlacenames.length == 0
                      ? Center(child: Text('What do you find?'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: searchPlacenames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                PlacenameFullItemBuilder(
                                  placename: searchPlacenames[index],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        )
            ],
          ),
        ));
  }
}
