import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class AiringTodayScreen extends StatefulWidget {
  static const routeName = '/airing_today';

  @override
  _AiringTodayScreenState createState() => _AiringTodayScreenState();
}

class _AiringTodayScreenState extends State<AiringTodayScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<TvAiringTodayBloc>().add(LoadTvAiringToday());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
        centerTitle: true,
      ),
      body: BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
        builder: (context, state) {
          if (state is TvAiringTodayHasData) {
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
          } else if (state is TvAiringTodayLoading) {
            return ShimmerList();
          } else if (state is TvAiringTodayError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is TvAiringTodayNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is TvAiringTodayNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<TvAiringTodayBloc>().add(LoadTvAiringToday());
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
