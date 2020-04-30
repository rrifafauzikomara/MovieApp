import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingScreen extends StatefulWidget {
  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(LoadUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          return ListView.builder(
            itemCount: state.result.results == null ? 0 : state.result.results.length,
            itemBuilder: (BuildContext context, int index) {
              Movies movies = state.result.results[index];
              return CardNowPlaying(
                image: movies.poster_path,
                title: movies.title,
                vote: movies.vote_average.toString(),
                releaseDate: movies.release_date,
                overview: movies.overview,
                genre: movies.genre_ids.take(3).map(buildGenreChip).toList(),
                onTap: () => null,
              );
            },
          );
        } else if (state is MoviesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MoviesNotLoaded) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }
}
