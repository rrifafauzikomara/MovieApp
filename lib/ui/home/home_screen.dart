import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/about/about_screen.dart';
import 'package:moviecatalogue/ui/movie/movie_screen.dart';
import 'package:moviecatalogue/ui/tv_show/tv_show_screen.dart';
import 'package:shared/shared.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              BlocProvider<NowPlayingBloc>(
                create: (BuildContext context) => NowPlayingBloc(repository: MovieRepository()),
              ),
              BlocProvider<PopularBloc>(
                create: (BuildContext context) => PopularBloc(repository: MovieRepository()),
              ),
              BlocProvider<UpComingBloc>(
                create: (BuildContext context) => UpComingBloc(repository: MovieRepository()),
              ),
            ],
            child: MovieScreen(),
          ),
          TvShowScreen(),
          AboutScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: ColorPalettes.setActive),
              ),
        ),
        child: BottomNavigationBar(
          key: Key(KEY_BOTTOM_NAVIGATION),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_creation,
              ),
              title: Container(height: 0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.live_tv,
              ),
              title: Container(height: 0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                key: Key(KEY_BOTTOM_NAVIGATION_ABOUT),
              ),
              title: Container(height: 0),
            ),
          ],
          onTap: _navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
