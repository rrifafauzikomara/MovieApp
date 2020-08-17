import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class NowPlayingScreen extends StatefulWidget {
  static const routeName = '/now_playing';

  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
  }

  Future<void> _refresh() {
    context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
          builder: (context, state) {
            if (state is MovieNowPlayingHasData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return ListView.builder(
                itemCount: state.result.results == null
                    ? 0
                    : state.result.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Movies movies = state.result.results[index];
                  return CardMovies(
                    image: movies.posterPath,
                    title: movies.title,
                    vote: movies.voteAverage.toString(),
                    releaseDate: movies.releaseDate,
                    overview: movies.overview,
                    genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                    onTap: () {
                      Navigation.intentWithData(
                        context,
                        DetailScreen.routeName,
                        ScreenArguments(movies, true),
                      );
                    },
                  );
                },
              );
            } else if (state is MovieNowPlayingLoading) {
              return ShimmerList();
            } else if (state is MovieNowPlayingError) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is MovieNowPlayingNoData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is MovieNowPlayingNoInternetConnection) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () {
                  context
                      .bloc<MovieNowPlayingBloc>()
                      .add(LoadMovieNowPlaying());
                },
              );
            } else {
              return Center(child: Text(""));
            }
          },
        ),
      ),
    );
  }
}
