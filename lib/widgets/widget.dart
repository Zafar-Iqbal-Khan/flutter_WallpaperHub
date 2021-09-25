import 'package:flutter/material.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/views/image_view.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Wallpaper',
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        'Hub',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    ],
  );
  // return Container(
  //   width: double.infinity,
  //   child: RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //       children: const <TextSpan>[
  //         TextSpan(
  //           text: 'Wallpaper',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black,
  //             fontSize: 18,
  //           ),
  //         ),
  //         TextSpan(
  //           text: 'Hub',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             color: Colors.blue,
  //             fontSize: 18,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, BuildContext context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 0.5,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: Container(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ImageView(
                      imgUrl: wallpaper.src.portrait,
                    );
                  },
                ),
              ),
              child: Hero(
                tag: wallpaper.src.portrait,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget creator() {
  return Container(
    // color: Colors.red,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Created By',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' Zafar Khan',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
