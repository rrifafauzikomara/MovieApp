import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/about/about_screen.dart';
import 'package:moviecatalogue/ui/now_playing/now_playing_screen.dart';
import 'package:moviecatalogue/ui/popular/popular_screen.dart';
import 'package:moviecatalogue/ui/top_rated/top_rated_screen.dart';
import 'package:moviecatalogue/ui/up_coming/up_coming_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          BlocProvider(
            create: (context) {
              return MoviesBloc(MovieRepository());
            },
            child: NowPlayingScreen(),
          ),
          BlocProvider(
            create: (context) {
              return MoviesBloc(MovieRepository());
            },
            child: UpComingScreen(),
          ),
          BlocProvider(
            create: (context) {
              return MoviesBloc(MovieRepository());
            },
            child: PopularScreen(),
          ),
          BlocProvider(
            create: (context) {
              return MoviesBloc(MovieRepository());
            },
            child: TopRatedScreen(),
          ),
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
                Icons.play_circle_filled,
                key: Key(KEY_BOTTOM_NAVIGATION_NOW_PLAYING),
              ),
              title: Container(height: 0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_movies,
                key: Key(KEY_BOTTOM_NAVIGATION_UP_COMING),
              ),
              title: Container(height: 0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_creation,
                key: Key(KEY_BOTTOM_NAVIGATION_POPULAR),
              ),
              title: Container(height: 0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_filter,
                key: Key(KEY_BOTTOM_NAVIGATION_TOP),
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

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
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

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
