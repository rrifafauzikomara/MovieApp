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
            height: Sizes.width(context),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Sizes.dp20(context),
                  right: Sizes.dp20(context),
                  top: Sizes.width(context) / 4.5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: Sizes.width(context) / 4.5,
                        width: Sizes.width(context) / 4.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(ImagesAssets.profile),
                          ),
                        ),
                      ),
                      SizedBox(width: Sizes.dp20(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "R Rifa Fauzi Komara",
                              style: TextStyle(
                                  fontSize: Sizes.dp28(context),
                                  color: ColorPalettes.lightBG,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: Sizes.dp5(context)),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  ImagesAssets.instagram,
                                  height: Sizes.dp13(context),
                                  width: Sizes.dp13(context),
                                ),
                                SizedBox(width: Sizes.dp10(context)),
                                Text(
                                  "rifafauzi6",
                                  style: TextStyle(
                                    color: ColorPalettes.lightBG,
                                    fontSize: Sizes.dp14(context),
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
                    height: Sizes.dp30(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "25.3K",
                            style: TextStyle(
                              fontSize: Sizes.dp26(context),
                              color: ColorPalettes.lightBG,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Follower",
                            style: TextStyle(
                              fontSize: Sizes.dp16(context),
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
                              fontSize: Sizes.dp26(context),
                              color: ColorPalettes.lightBG,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: Sizes.dp16(context),
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
            padding: EdgeInsets.only(top: Sizes.width(context) / 1.4),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                color: !_isDarkTheme
                    ? ColorPalettes.darkBG
                    : ColorPalettes.lightBG,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Sizes.dp30(context)),
                  topLeft: Radius.circular(Sizes.dp30(context)),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dp30(context), bottom: Sizes.dp20(context)),
                      child: Text(
                        "My Portfolio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.dp22(context),
                        ),
                      ),
                    ),
                    CardPortfolio(
                      imageAsset: ImagesAssets.linkedIn,
                      title: 'LinkedIn',
                      url: UrlConstant.urlLinkedIn,
                    ),
                    CardPortfolio(
                      imageAsset: ImagesAssets.github,
                      title: 'GitHub',
                      url: UrlConstant.urlLinkedIn,
                    ),
                    CardPortfolio(
                      imageAsset: ImagesAssets.resume,
                      title: 'Resume',
                      url: UrlConstant.urlResume,
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