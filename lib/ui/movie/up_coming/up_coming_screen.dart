import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';

class UpComingScreen extends StatefulWidget {
  static const routeName = '/up_coming';

  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<MovieUpComingBloc>().add(LoadMovieUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Up Coming Movie'),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieUpComingBloc, MovieUpComingState>(
        builder: (context, state) {
          if (state is MovieUpComingHasData) {
            return ListView.builder(
              key: Key(KEY_LIST_VIEW_UP_COMING),
              itemCount: state.result.results == null
                  ? 0
                  : state.result.results.length,
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
                      DetailScreen.routeName,
                      ScreenArguments(movies),
                    );
                  },
                );
              },
            );
          } else if (state is MovieUpComingLoading) {
            return ShimmerList();
          } else if (state is MovieUpComingError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is MovieUpComingNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is MovieUpComingNoInternetConnection) {
            return NoInternetConnectionWidget(
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
    );
  }
}
