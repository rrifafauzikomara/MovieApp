import 'package:moviecatalogue/ui/setting/setting_page.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/home/home_screen.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';
import 'app_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.title,
      debugShowCheckedModeBanner: Config.isDebug,
      theme: CustomTheme.of(context),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(title: Config.title),
        DetailMovies.routeName: (context) => DetailMovies(),
        SettingPage.routeName: (context) => SettingPage(),
      },
    );
  }
}