import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class MoviePopularScreen extends StatefulWidget {
  static const routeName = '/movie_popular';

  @override
  _MoviePopularScreenState createState() => _MoviePopularScreenState();
}

class _MoviePopularScreenState extends State<MoviePopularScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<MoviePopularBloc>().add(LoadMoviePopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: BlocBuilder<MoviePopularBloc, MoviePopularState>(
        builder: (context, state) {
          if (state is MoviePopularHasData) {
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
          } else if (state is MoviePopularLoading) {
            return ShimmerList();
          } else if (state is MoviePopularError) {
            return CustomErrorWidget(message: state.errorMessage);
          } else if (state is MoviePopularNoData) {
            return CustomErrorWidget(message: state.message);
          } else if (state is MoviePopularNoInternetConnection) {
            return NoInternetWidget(
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
    );
  }
}
