import 'package:core/core.dart';
import 'package:moviecatalogue/ui/menu/menu.dart';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/ui/detail/detail_movies.dart';

class UpComingScreen extends StatefulWidget {
  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(LoadUpComing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Up Coming Movie'),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<Menu>(
            icon: Icon(Icons.more_vert),
            onSelected: (Menu menu) {
              // Causes the app to rebuild with the new _selectedChoice.
              Navigation.intent(context, menu.route);
            },
            itemBuilder: (BuildContext context) {
              return menus.map((Menu menu) {
                return PopupMenuItem<Menu>(
                  value: menu,
                  child: Text(menu.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesHasData) {
            return ListView.builder(
              key: Key(KEY_LIST_VIEW_UP_COMING),
              itemCount: state.result.results == null ? 0 : state.result.results.length,
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
          } else if (state is MoviesLoading) {
            return ShimmerMovies();
          } else if (state is MoviesError) {
            return ErrorHandlerWidget(errorMessage: state.errorMessage);
          } else if (state is MoviesNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: state.message,
              onPressed: () {
                BlocProvider.of<MoviesBloc>(context).add(LoadUpComing());
              },
            );
          } else if (state is MoviesNoData) {
            return NoDataWidget(message: state.message);
          } else {
            return Center(child: Text(""));
          }
        },
      ),
    );
  }
}
