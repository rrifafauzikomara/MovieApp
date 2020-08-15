import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/dashboard/dashboard_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:shared/shared.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> _getVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  _startSplashScreen() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }

  void _navigationPage() {
    Navigation.splashScreen(context, DashBoardScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: Sizes.width(context) / 3,
                width: Sizes.width(context) / 3,
                child: Image.asset(
                  ImagesAssets.movieIcon,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<String>(
                future: _getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  var verInfo = "";
                  if (snapshot.hasData) {
                    verInfo = "v ${snapshot.data}";
                  }
                  return Container(
                    margin: EdgeInsets.only(bottom: Sizes.dp30(context)),
                    child: Text(
                      verInfo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
