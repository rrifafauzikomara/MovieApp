import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';
import 'package:shared/shared.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(LoadNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesHasData) {
          return ListView.builder(
            key: Key(KEY_LIST_VIEW_NOW_PLAYING),
            itemCount:
                state.result.results == null ? 0 : state.result.results.length,
            itemBuilder: (BuildContext context, int index) {
              Movies movies = state.result.results[index];
              return CardMovies(
                key: Key("tap_movies_" + movies.id.toString()),
                image: movies.posterPath,
                title: movies.title,
                vote: movies.voteAverage.toString(),
                releaseDate: movies.releaseDate,
                overview: movies.overview,
                genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
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
        } else if (state is MoviesLoading) {
          return ShimmerMovies();
        } else if (state is MoviesError) {
          return ErrorHandlerWidget(errorMessage: state.errorMessage);
        } else if (state is MoviesNoInternetConnection) {
          return NoInternetConnectionWidget(
            message: state.message,
            onPressed: () {
              BlocProvider.of<MoviesBloc>(context).add(LoadNowPlaying());
            },
          );
        } else if (state is MoviesNoData) {
          return NoDataWidget(message: state.message);
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }
}
