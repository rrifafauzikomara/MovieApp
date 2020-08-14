import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/movie/now_playing/now_playing_screen.dart';
import 'package:moviecatalogue/ui/movie/popular/movie_popular_screen.dart';
import 'package:moviecatalogue/ui/setting/setting_screen.dart';
import 'package:moviecatalogue/ui/movie/up_coming/up_coming_screen.dart';
import 'package:moviecatalogue/ui/splash/splash_screen.dart';
import 'package:moviecatalogue/ui/tv_show/airing_today/airing_today_screen.dart';
import 'package:moviecatalogue/ui/tv_show/on_the_air/on_the_air_screen.dart';
import 'package:moviecatalogue/ui/tv_show/popular/tv_popular_screen.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/dashboard/dashboard_screen.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'app_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.title,
      debugShowCheckedModeBanner: Config.isDebug,
      theme: CustomTheme.of(context),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        DashBoardScreen.routeName: (context) =>
            DashBoardScreen(title: Config.title),
        DetailScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return CrewBloc(repository: MovieRepository());
              },
              child: DetailScreen(),
            ),
        SettingScreen.routeName: (context) => SettingScreen(),
        NowPlayingScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return MovieNowPlayingBloc(repository: MovieRepository());
              },
              child: NowPlayingScreen(),
            ),
        MoviePopularScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return MoviePopularBloc(repository: MovieRepository());
              },
              child: MoviePopularScreen(),
            ),
        UpComingScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return MovieUpComingBloc(repository: MovieRepository());
              },
              child: UpComingScreen(),
            ),
        AiringTodayScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return TvAiringTodayBloc(repository: MovieRepository());
              },
              child: AiringTodayScreen(),
            ),
        OnTheAirScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return TvOnTheAirBloc(repository: MovieRepository());
              },
              child: OnTheAirScreen(),
            ),
        TvPopularScreen.routeName: (context) => BlocProvider(
              create: (context) {
                return TvPopularBloc(repository: MovieRepository());
              },
              child: TvPopularScreen(),
            ),
      },
    );
  }
}
