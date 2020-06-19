import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/menu/menu.dart';
import 'package:shared/shared.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  ThemeData _themeData;
  bool _isDarkTheme;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    _isDarkTheme = _themeData.appBarTheme?.color == null;
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            color: !_isDarkTheme
                ? ColorPalettes.darkAccent
                : ColorPalettes.lightAccent,
            height: 350,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 85),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(ImagesAssets.profile))),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "R Rifa Fauzi Komara",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: ColorPalettes.lightBG,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  ImagesAssets.instagram,
                                  height: 13,
                                  width: 13,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "rifafauzi6",
                                  style: TextStyle(
                                    color: ColorPalettes.lightBG,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "25.3K",
                            style: TextStyle(
                                fontSize: 26,
                                color: ColorPalettes.lightBG,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Follower",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPalettes.lightBG,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "232",
                            style: TextStyle(
                                fontSize: 26,
                                color: ColorPalettes.lightBG,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPalettes.lightBG,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: !_isDarkTheme
                      ? ColorPalettes.darkBG
                      : ColorPalettes.lightBG,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "My Portofolio",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            right: 0,
            child: PopupMenuButton<Menu>(
              icon: Icon(Icons.more_vert),
              onSelected: (Menu menu) {
                // Causes the app to rebuild with the new _selectedChoice.
                Navigation.intent(context, menu.route);
              },
              itemBuilder: (BuildContext context) {
                return menus.map((Menu menu) {
                  return PopupMenuItem<Menu>(
                    value: menu,
                    child: Text(menu.title),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}