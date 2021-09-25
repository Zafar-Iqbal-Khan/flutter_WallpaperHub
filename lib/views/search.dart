import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuerry;

  Search({this.searchQuerry});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> searchedWallpapers = [];

  getSearchWallpapers(String querry) async {
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$querry&per_page=100",
      headers: {
        'Authorization': apiKey,
      },
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach(
      (element) {
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        searchedWallpapers.add(wallpaperModel);
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuerry);
    super.initState();
    searchController.text = widget.searchQuerry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xfff5f8fd),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: '${widget.searchQuerry}',
                      ),
                    ),
                  ),
                  InkWell(
                    // onTap: getSearchWallpapers(searchController.text),
                    child: Container(
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: wallpapersList(
                    context: context, wallpapers: searchedWallpapers)),
          ],
        ),
      ),
    );
  }
}
