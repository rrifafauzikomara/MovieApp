import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/now_playing/now_playing_screen.dart';
import 'package:moviecatalogue/ui/popular/popular_screen.dart';
import 'package:moviecatalogue/ui/setting/setting_page.dart';
import 'package:moviecatalogue/ui/up_coming/up_coming_screen.dart';
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
        NowPlayingScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return NowPlayingBloc(repository: MovieRepository());
              },
              child: NowPlayingScreen(),
            ),
        PopularScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return PopularBloc(repository: MovieRepository());
              },
              child: PopularScreen(),
            ),
        UpComingScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return UpComingBloc(repository: MovieRepository());
              },
              child: UpComingScreen(),
            ),
      },
    );
  }
}
