import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';

class TopRatedScreen extends StatefulWidget {
  @override
  _TopRatedScreenState createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(LoadTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesHasData) {
          return ListView.builder(
            key: Key(KEY_LIST_VIEW_TOP),
            itemCount: state.result.results == null ? 0 : state.result.results.length,
            itemBuilder: (BuildContext context, int index) {
              Movies movies = state.result.results[index];
              return CardMovies(
                key: Key("tap_movies_" + movies.id.toString()),
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
        } else if (state is MoviesError) {
          return ErrorHandlerWidget(errorMessage: state.errorMessage);
        } else if (state is MoviesNoInternetConnection) {
          return NoInternetConnectionWidget(
            message: 'No Internet Connection',
            onPressed: () {
              BlocProvider.of<MoviesBloc>(context).add(LoadTopRated());
            },
          );
        } else if (state is MoviesNoData) {
          return NoDataWidget(message: 'No Data');
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }
}
