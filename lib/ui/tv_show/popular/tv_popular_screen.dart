import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class TvPopularScreen extends StatefulWidget {
  static const routeName = '/tv_popular';

  @override
  _TvPopularScreenState createState() => _TvPopularScreenState();
}

class _TvPopularScreenState extends State<TvPopularScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<TvPopularBloc>().add(LoadTvPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
        centerTitle: true,
      ),
      body: BlocBuilder<TvPopularBloc, TvPopularState>(
        builder: (context, state) {
          if (state is TvPopularHasData) {
            return ListView.builder(
              key: Key(KEY_LIST_VIEW_NOW_PLAYING),
              itemCount: state.result.results == null
                  ? 0
                  : state.result.results.length,
              itemBuilder: (BuildContext context, int index) {
                Movies movies = state.result.results[index];
                return CardMovies(
                  key: Key("tap_movies_" + movies.id.toString()),
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
                      ScreenArguments(movies),
                    );
                  },
                );
              },
            );
          } else if (state is TvPopularLoading) {
            return ShimmerList();
          } else if (state is TvPopularError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is TvPopularNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is TvPopularNoInternetConnection) {
            return NoInternetConnectionWidget(
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
    );
  }
}
