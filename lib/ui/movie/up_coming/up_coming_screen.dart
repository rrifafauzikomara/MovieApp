import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class UpComingScreen extends StatefulWidget {
  static const routeName = '/up_coming';

  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    context.bloc<MovieUpComingBloc>().add(LoadMovieUpComing());
  }

  Future<void> _refresh() {
    context.bloc<MovieUpComingBloc>().add(LoadMovieUpComing());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Up Coming Movie'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<MovieUpComingBloc, MovieUpComingState>(
          builder: (context, state) {
            if (state is MovieUpComingHasData) {
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
                        ScreenArguments(movies, true, false),
                      );
                    },
                  );
                },
              );
            } else if (state is MovieUpComingLoading) {
              return ShimmerList();
            } else if (state is MovieUpComingError) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is MovieUpComingNoData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is MovieUpComingNoInternetConnection) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
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
    );
  }
}
