import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/booking/booking_screen.dart';
import 'package:moviecatalogue/ui/dashboard/dashboard_screen.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:moviecatalogue/ui/about/about_screen.dart';
import 'package:moviecatalogue/ui/home/discover_screen.dart';
import 'package:moviecatalogue/ui/movie/now_playing/now_playing_screen.dart';
import 'package:moviecatalogue/ui/movie/popular/movie_popular_screen.dart';
import 'package:moviecatalogue/ui/movie/up_coming/up_coming_screen.dart';
import 'package:moviecatalogue/ui/setting/setting_screen.dart';
import 'package:moviecatalogue/ui/splash/splash_screen.dart';
import 'package:moviecatalogue/ui/tv_show/airing_today/airing_today_screen.dart';
import 'package:moviecatalogue/ui/tv_show/on_the_air/on_the_air_screen.dart';
import 'package:moviecatalogue/ui/tv_show/popular/tv_popular_screen.dart';
import 'package:shared/shared.dart';

import 'app_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DiscoverMovieBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => MovieNowPlayingBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => MoviePopularBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => MovieUpComingBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => TvAiringTodayBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => TvOnTheAirBloc(repository: MovieRepository()),
        ),
        BlocProvider(
          create: (context) => TvPopularBloc(repository: MovieRepository()),
        ),
        BlocProvider<TrailerBloc>(
          create: (BuildContext context) => TrailerBloc(repository: MovieRepository()),
        ),
        BlocProvider<CrewBloc>(
          create: (BuildContext context) => CrewBloc(repository: MovieRepository()),
        ),
      ],
      child: MaterialApp(
        title: Config.title,
        debugShowCheckedModeBanner: Config.isDebug,
        theme: CustomTheme.of(context),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          DashBoardScreen.routeName: (context) => DashBoardScreen(title: Config.title),
          DiscoverScreen.routeName: (context) => DiscoverScreen(),
          NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
          MoviePopularScreen.routeName: (context) => MoviePopularScreen(),
          UpComingScreen.routeName: (context) => UpComingScreen(),
          AiringTodayScreen.routeName: (context) => AiringTodayScreen(),
          OnTheAirScreen.routeName: (context) => OnTheAirScreen(),
          TvPopularScreen.routeName: (context) => TvPopularScreen(),
          DetailScreen.routeName: (context) => DetailScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
          AboutScreen.routeName: (context) => AboutScreen(),
          BookingScreen.routeName: (context) => BookingScreen(),
        },
      ),
    );
  }
}
