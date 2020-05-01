import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';

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
        if (state is MoviesLoaded) {
          return ListView.builder(
            itemCount:
                state.result.results == null ? 0 : state.result.results.length,
            itemBuilder: (BuildContext context, int index) {
              Movies movies = state.result.results[index];
              return CardMovies(
                image: movies.poster_path,
                title: movies.title,
                vote: movies.vote_average.toString(),
                releaseDate: movies.release_date,
                overview: movies.overview,
                genre: movies.genre_ids.take(3).map(buildGenreChip).toList(),
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
        } else if (state is MoviesNotLoaded) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }
}
