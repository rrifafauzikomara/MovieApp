import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/detail/detail_screen.dart';
import 'package:shared/shared.dart';

class OnTheAirScreen extends StatefulWidget {
  static const routeName = '/on_the_air';

  @override
  _OnTheAirScreenState createState() => _OnTheAirScreenState();
}

class _OnTheAirScreenState extends State<OnTheAirScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<TvOnTheAirBloc>().add(LoadTvOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air'),
        centerTitle: true,
      ),
      body: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
        builder: (context, state) {
          if (state is TvOnTheAirHasData) {
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
                      ScreenArguments(movies, false),
                    );
                  },
                );
              },
            );
          } else if (state is TvOnTheAirLoading) {
            return ShimmerList();
          } else if (state is TvOnTheAirError) {
            return CustomErrorWidget(message: state.errorMessage);
          } else if (state is TvOnTheAirNoData) {
            return CustomErrorWidget(message: AppConstant.noData);
          } else if (state is TvOnTheAirNoInternetConnection) {
            return NoInternetWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<TvOnTheAirBloc>().add(LoadTvOnTheAir());
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
