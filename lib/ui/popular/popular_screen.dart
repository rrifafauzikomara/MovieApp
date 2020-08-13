import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';

class PopularScreen extends StatefulWidget {
  static const routeName = '/popular';

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
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
              key: Key(KEY_LIST_VIEW_POPULAR),
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
          } else if (state is MoviePopularLoading) {
            return ShimmerList();
          } else if (state is MoviePopularError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is MoviePopularNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is MoviePopularNoInternetConnection) {
            return NoInternetConnectionWidget(
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
