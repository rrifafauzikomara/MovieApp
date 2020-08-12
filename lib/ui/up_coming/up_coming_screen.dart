import 'package:core/core.dart';
import 'package:moviecatalogue/ui/menu/menu.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';

class UpComingScreen extends StatefulWidget {
  static const routeName = '/up_coming';

  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<UpComingBloc>().add(LoadUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Up Coming Movie'),
        centerTitle: true,
      ),
      body: BlocBuilder<UpComingBloc, UpComingState>(
        builder: (context, state) {
          if (state is UpComingHasData) {
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
                      DetailMovies.routeName,
                      ScreenArguments(movies),
                    );
                  },
                );
              },
            );
          } else if (state is UpComingLoading) {
            return ShimmerList();
          } else if (state is UpComingError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is UpComingNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is UpComingNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<UpComingBloc>().add(LoadUpComing());
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
