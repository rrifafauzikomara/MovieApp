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
          create: (context) => inject<DiscoverMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<MovieUpComingBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<TvAiringTodayBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<TvPopularBloc>(),
        ),
        BlocProvider<TrailerBloc>(
          create: (context) => inject<TrailerBloc>(),
        ),
        BlocProvider<CrewBloc>(
          create: (context) => inject<CrewBloc>(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => inject<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    context.select((ThemeBloc themeBloc) => themeBloc.add(GetTheme()));
    return MaterialApp(
      title: Config.title,
      debugShowCheckedModeBanner: Config.isDebug,
      theme: state.isDarkTheme ? Themes.darkTheme : Themes.lightTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        DashBoardScreen.routeName: (context) =>
            DashBoardScreen(title: Config.title),
        DiscoverScreen.routeName: (context) => DiscoverScreen(),
        NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
        MoviePopularScreen.routeName: (context) => MoviePopularScreen(),
        UpComingScreen.routeName: (context) => UpComingScreen(),
        AiringTodayScreen.routeName: (context) => AiringTodayScreen(),
        OnTheAirScreen.routeName: (context) => OnTheAirScreen(),
        TvPopularScreen.routeName: (context) => TvPopularScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
              arguments: ModalRoute.of(context).settings.arguments,
            ),
        SettingScreen.routeName: (context) => SettingScreen(),
        AboutScreen.routeName: (context) => AboutScreen(),
        BookingScreen.routeName: (context) => BookingScreen(),
      },
    );
  }
}
