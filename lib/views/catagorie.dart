import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/categories_model.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/widgets/widget.dart';

class Categorie extends StatefulWidget {
  String categorieName;
  Categorie({this.categorieName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapersCategory = [];
  getCategorieWallpapers(String category) async {
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$category&per_page=100",
      headers: {
        'Authorization': apiKey,
      },
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach(
      (element) {
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapersCategory.add(wallpaperModel);
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    getCategorieWallpapers(widget.categorieName);
    super.initState();
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: wallpapersList(
                  context: context, wallpapers: wallpapersCategory),
            ),
          ],
        ),
      ),
    );
  }
}
