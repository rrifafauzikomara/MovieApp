import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:moviecatalogue/ui/menu/menu.dart';
import 'package:moviecatalogue/ui/tv_show/airing_today/airing_today_screen.dart';
import 'package:moviecatalogue/ui/tv_show/on_the_air/on_the_air_screen.dart';
import 'package:moviecatalogue/ui/tv_show/popular/tv_popular_screen.dart';
import 'package:shared/shared.dart';

class TvShowScreen extends StatefulWidget {
  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  Completer<void> _refreshCompleter;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    context.bloc<TvOnTheAirBloc>().add(LoadTvOnTheAir());
    context.bloc<TvAiringTodayBloc>().add(LoadTvAiringToday());
    context.bloc<TvPopularBloc>().add(LoadTvPopular());
  }

  Future<void> _refresh() {
    context.bloc<TvOnTheAirBloc>().add(LoadTvOnTheAir());
    context.bloc<TvAiringTodayBloc>().add(LoadTvAiringToday());
    context.bloc<TvPopularBloc>().add(LoadTvPopular());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tv Show'),
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
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: _buildBody(context),
      ),
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
            _buildAiringToday(context),
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
    return BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
      builder: (context, state) {
        if (state is TvOnTheAirHasData) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return BannerHome(
            isFromMovie: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            data: state.result,
            currentIndex: _current,
            routeNameDetail: DetailScreen.routeName,
            routeNameAll: OnTheAirScreen.routeName,
          );
        } else if (state is TvOnTheAirLoading) {
          return ShimmerBanner();
        } else if (state is TvOnTheAirError) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return CustomErrorWidget(message: state.errorMessage);
        } else if (state is TvOnTheAirNoData) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return CustomErrorWidget(message: state.message);
        } else if (state is TvOnTheAirNoInternetConnection) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return NoInternetWidget(
            message: AppConstant.noInternetConnection,
            onPressed: () {
              context.bloc<TvOnTheAirBloc>().add(LoadTvOnTheAir());
            },
          );
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }

  Widget _buildAiringToday(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Airing Today',
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
                  Navigation.intent(context, AiringTodayScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
            builder: (context, state) {
              if (state is TvAiringTodayHasData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.result.results.length > 5
                      ? 5
                      : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.tvName,
                      rating: movies.voteAverage,
                      onTap: () {
                        Navigation.intentWithData(
                          context,
                          DetailScreen.routeName,
                          ScreenArguments(movies, false),
                        );
                      },
                    );
                  },
                );
              } else if (state is TvAiringTodayLoading) {
                return ShimmerCard();
              } else if (state is TvAiringTodayError) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is TvAiringTodayNoData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.message);
              } else if (state is TvAiringTodayNoInternetConnection) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<TvAiringTodayBloc>().add(LoadTvAiringToday());
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
                  Navigation.intent(context, TvPopularScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<TvPopularBloc, TvPopularState>(
            builder: (context, state) {
              if (state is TvPopularHasData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.result.results.length > 5
                      ? 5
                      : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.tvName,
                      rating: movies.voteAverage,
                      onTap: () {
                        Navigation.intentWithData(
                          context,
                          DetailScreen.routeName,
                          ScreenArguments(movies, false),
                        );
                      },
                    );
                  },
                );
              } else if (state is TvPopularLoading) {
                return ShimmerCard();
              } else if (state is TvPopularError) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is TvPopularNoData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.message);
              } else if (state is TvPopularNoInternetConnection) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () {
                    context.bloc<TvPopularBloc>().add(LoadTvPopular());
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
