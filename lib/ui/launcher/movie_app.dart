import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviecatalogue/ui/home/home_screen.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';
import 'app_config.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // "true" for darkTheme, "false" for lightTheme
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      isDark ? ColorPalettes.darkPrimary : ColorPalettes.lightPrimary,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.title,
      debugShowCheckedModeBanner: Config.isDebug,
      theme: isDark ? ColorPalettes.darkTheme : ColorPalettes.lightTheme,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(title: Config.title),
        DetailMovies.routeName: (context) => DetailMovies(),
      },
    );
  }
}