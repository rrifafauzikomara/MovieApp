import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';

class PopularScreen extends StatefulWidget {
  static const routeName = '/popular';

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<PopularBloc>().add(LoadPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
          if (state is PopularHasData) {
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
                      DetailMovies.routeName,
                      ScreenArguments(movies),
                    );
                  },
                );
              },
            );
          } else if (state is PopularLoading) {
            return ShimmerList();
          } else if (state is PopularError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is PopularNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is PopularNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<PopularBloc>().add(LoadPopular());
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
