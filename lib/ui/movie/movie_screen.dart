import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';
import 'package:moviecatalogue/ui/popular/popular_screen.dart';
import 'package:moviecatalogue/ui/up_coming/up_coming_screen.dart';
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
    context.bloc<NowPlayingBloc>().add(LoadNowPlaying());
    context.bloc<PopularBloc>().add(LoadPopular());
    context.bloc<UpComingBloc>().add(LoadUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        margin: EdgeInsets.all(10),
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
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingHasData) {
          return BannerHome(
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            data: state.result,
            currentIndex: _current,
            routeName: DetailMovies.routeName,
          );
        } else if (state is NowPlayingLoading) {
          return Container(
            height: Sizes.width(context) / 2,
            child: LoadingIndicator(),
          );
        } else if (state is NowPlayingError) {
          return ErrorHandlerWidget(errorMessage: state.errorMessage);
        } else if (state is NowPlayingNoData) {
          return NoDataWidget(message: AppConstant.noData);
        } else if (state is NowPlayingNoInternetConnection) {
          return NoInternetConnectionWidget(
            message: AppConstant.noInternetConnection,
            onPressed: () {
              context.bloc<NowPlayingBloc>().add(LoadNowPlaying());
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
          child: BlocBuilder<UpComingBloc, UpComingState>(
            builder: (context, state) {
              if (state is UpComingHasData) {
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
                          DetailMovies.routeName,
                          ScreenArguments(movies),
                        );
                      },
                    );
                  },
                );
              } else if (state is UpComingLoading) {
                return LoadingIndicator();
              } else if (state is UpComingError) {
                return ErrorHandlerWidget(errorMessage: state.errorMessage);
              } else if (state is UpComingNoData) {
                return NoDataWidget(message: AppConstant.noData);
              } else if (state is UpComingNoInternetConnection) {
                return NoInternetConnectionWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<UpComingBloc>().add(LoadUpComing());
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
                  Navigation.intent(context, PopularScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<PopularBloc, PopularState>(
            builder: (context, state) {
              if (state is PopularHasData) {
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
                          DetailMovies.routeName,
                          ScreenArguments(movies),
                        );
                      },
                    );
                  },
                );
              } else if (state is PopularLoading) {
                return LoadingIndicator();
              } else if (state is PopularError) {
                return ErrorHandlerWidget(errorMessage: state.errorMessage);
              } else if (state is PopularNoData) {
                return NoDataWidget(message: AppConstant.noData);
              } else if (state is PopularNoInternetConnection) {
                return NoInternetConnectionWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<PopularBloc>().add(LoadPopular());
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
