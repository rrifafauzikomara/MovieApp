import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/home/discover_screen.dart';
import 'package:moviecatalogue/ui/home/movie_screen.dart';
import 'package:moviecatalogue/ui/home/tv_show_screen.dart';
import 'package:shared/shared.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/';
  final String title;

  const DashBoardScreen({Key key, this.title}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController;
  int _page = 0;

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          MultiBlocProvider(
            providers: [
              BlocProvider<MovieNowPlayingBloc>(
                create: (BuildContext context) =>
                    MovieNowPlayingBloc(repository: MovieRepository()),
              ),
              BlocProvider<MoviePopularBloc>(
                create: (BuildContext context) =>
                    MoviePopularBloc(repository: MovieRepository()),
              ),
              BlocProvider<MovieUpComingBloc>(
                create: (BuildContext context) =>
                    MovieUpComingBloc(repository: MovieRepository()),
              ),
            ],
            child: MovieScreen(),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider<TvOnTheAirBloc>(
                create: (BuildContext context) =>
                    TvOnTheAirBloc(repository: MovieRepository()),
              ),
              BlocProvider<TvAiringTodayBloc>(
                create: (BuildContext context) =>
                    TvAiringTodayBloc(repository: MovieRepository()),
              ),
              BlocProvider<TvPopularBloc>(
                create: (BuildContext context) =>
                    TvPopularBloc(repository: MovieRepository()),
              ),
            ],
            child: TvShowScreen(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigation.intent(context, DiscoverScreen.routeName),
        child: Icon(
          Icons.location_searching,
          color: ColorPalettes.white,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: ColorPalettes.setActive)),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: Sizes.dp8(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color:
                    _page == 0 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                icon: Icon(Icons.movie_creation),
                onPressed: () => _navigationTapped(0),
              ),
              IconButton(
                color:
                    _page == 1 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                icon: Icon(Icons.live_tv),
                onPressed: () => _navigationTapped(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
