import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:moviecatalogue/bloc/movies/bloc.dart';
import 'package:moviecatalogue/common/sizes.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Completer<void> _refreshCompleter;
  int _currentPage = 1;

  Future<void> _refreshMovies() {
    BlocProvider.of<MoviesBloc>(context).add(LoadNowPlaying());
    return _refreshCompleter.future;
  }

  void _loadMovies() {
    BlocProvider.of<MoviesBloc>(context).add(LoadNowPlaying());
  }

  void _loadMoreMovies(int page) {
    BlocProvider.of<MoviesBloc>(context).add(LoadMoreMovies(page));
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
    _refreshCompleter = Completer<void>();
    BlocProvider.of<MoviesBloc>(context).listen((state) {
      if (state is MoviesLoaded || state is MoviesNotLoaded) {
        if (state is MoviesLoaded && state.page > 1) {
          setState(() {
            _currentPage++;
          });
        } else {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoaded) {
            return LazyLoadScrollView(
              child: ListView.builder(
                itemCount: state.result.results == null ? 0 : state.result.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Movies movies = state.result.results[index];
                  return Center(child: Text(movies.title));
                },
              ),
              onEndOfPage: () => _loadMoreMovies(_currentPage + 1),
            );
          } else if (state is MoviesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MoviesNotLoaded) {
            return Padding(
              padding: EdgeInsets.all(Sizes.dp16(context)),
              child: Center(child: Text(state.errorMessage)),
            );
          } else {
            return Center(child: Text(""));
          }
        },
      ),
      onRefresh: _refreshMovies,
    );
  }
}
