import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class NowPlayingScreen extends StatefulWidget {
  static const routeName = '/now_playing';

  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<NowPlayingBloc>().add(LoadNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
        centerTitle: true,
      ),
      body: BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, state) {
          if (state is NowPlayingHasData) {
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
          } else if (state is NowPlayingLoading) {
            return ShimmerList();
          } else if (state is NowPlayingError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is NowPlayingNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is NowPlayingNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<NowPlayingBloc>().add(LoadNowPlaying());
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
