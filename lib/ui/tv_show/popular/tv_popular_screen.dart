import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class TvPopularScreen extends StatefulWidget {
  static const routeName = '/tv_popular';

  @override
  _TvPopularScreenState createState() => _TvPopularScreenState();
}

class _TvPopularScreenState extends State<TvPopularScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    context.bloc<TvPopularBloc>().add(LoadTvPopular());
  }

  Future<void> _refresh() {
    context.bloc<TvPopularBloc>().add(LoadTvPopular());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularHasData) {
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
                    title: movies.tvName,
                    vote: movies.voteAverage.toString(),
                    releaseDate: movies.tvRelease,
                    overview: movies.overview,
                    genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
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
              return ShimmerList();
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
    );
  }
}
