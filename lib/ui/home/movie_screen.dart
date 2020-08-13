import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:moviecatalogue/ui/movie/now_playing/now_playing_screen.dart';
import 'package:moviecatalogue/ui/movie/popular/movie_popular_screen.dart';
import 'package:moviecatalogue/ui/movie/up_coming/up_coming_screen.dart';
import 'package:shared/shared.dart';
import 'package:moviecatalogue/ui/menu/menu.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
    context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
    context.bloc<MoviePopularBloc>().add(LoadMoviePopular());
    context.bloc<MovieUpComingBloc>().add(LoadMovieUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Movies'),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<Menu>(
            icon: Icon(Icons.more_vert),
            onSelected: (Menu menu) {
              // Causes the app to rebuild with the new _selectedChoice.
              Navigation.intent(context, menu.route);
            },
            itemBuilder: (BuildContext context) {
              return menus.map((Menu menu) {
                return PopupMenuItem<Menu>(
                  value: menu,
                  child: Text(menu.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(), //kill bounce iOS
      child: Container(
        margin: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          children: <Widget>[
            _buildBanner(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            _buildUpComing(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            _buildPopular(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
      builder: (context, state) {
        if (state is MovieNowPlayingHasData) {
          return BannerHome(
            isFromMovie: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            data: state.result,
            currentIndex: _current,
            routeNameDetail: DetailScreen.routeName,
            routeNameAll: NowPlayingScreen.routeName,
          );
        } else if (state is MovieNowPlayingLoading) {
          return ShimmerBanner();
        } else if (state is MovieNowPlayingError) {
          return ErrorHandlerWidget(errorMessage: state.errorMessage);
        } else if (state is MovieNowPlayingNoData) {
          return NoDataWidget(message: AppConstant.noData);
        } else if (state is MovieNowPlayingNoInternetConnection) {
          return NoInternetConnectionWidget(
            message: AppConstant.noInternetConnection,
            onPressed: () {
              context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
            },
          );
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }

  Widget _buildUpComing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Up Coming',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Navigation.intent(context, UpComingScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<MovieUpComingBloc, MovieUpComingState>(
            builder: (context, state) {
              if (state is MovieUpComingHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  key: Key(KEY_LIST_VIEW_UP_COMING),
                  itemCount: state.result.results.length > 5
                      ? 5
                      : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.title,
                      rating: movies.voteAverage,
                      onTap: () {
                        Navigation.intentWithData(
                          context,
                          DetailScreen.routeName,
                          ScreenArguments(movies),
                        );
                      },
                    );
                  },
                );
              } else if (state is MovieUpComingLoading) {
                return ShimmerCard();
              } else if (state is MovieUpComingError) {
                return ErrorHandlerWidget(errorMessage: state.errorMessage);
              } else if (state is MovieUpComingNoData) {
                return NoDataWidget(message: AppConstant.noData);
              } else if (state is MovieUpComingNoInternetConnection) {
                return NoInternetConnectionWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<MovieUpComingBloc>().add(LoadMovieUpComing());
                  },
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopular(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Navigation.intent(context, MoviePopularScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
            builder: (context, state) {
              if (state is MoviePopularHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  key: Key(KEY_LIST_VIEW_UP_COMING),
                  itemCount: state.result.results.length > 5
                      ? 5
                      : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.title,
                      rating: movies.voteAverage,
                      onTap: () {
                        Navigation.intentWithData(
                          context,
                          DetailScreen.routeName,
                          ScreenArguments(movies),
                        );
                      },
                    );
                  },
                );
              } else if (state is MoviePopularLoading) {
                return ShimmerCard();
              } else if (state is MoviePopularError) {
                return ErrorHandlerWidget(errorMessage: state.errorMessage);
              } else if (state is MoviePopularNoData) {
                return NoDataWidget(message: AppConstant.noData);
              } else if (state is MoviePopularNoInternetConnection) {
                return NoInternetConnectionWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<MoviePopularBloc>().add(LoadMoviePopular());
                  },
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }
}
