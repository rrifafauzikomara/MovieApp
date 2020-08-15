import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DiscoverScreen extends StatefulWidget {
  static const routeName = '/discover_movie';

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {

  @override
  void initState() {
    super.initState();
    context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: ColorPalettes.white,
        ),
      ),
      body: BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
        builder: (context, state) {
          if (state is MovieNowPlayingHasData) {
            return PageView.builder(
              physics: ClampingScrollPhysics(),
              reverse: true,
              itemCount: state.result.results.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var movie = state.result.results[index];
                var position = index +1;
                return Container(
                  width: Sizes.width(context),
                  height: Sizes.height(context),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: movie.backdropPath.imageOriginal,
                        width: Sizes.width(context),
                        height: Sizes.height(context),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => ErrorImage(),
                      ),
                      Container(
                        color: ColorPalettes.grey.withOpacity(.6),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                ColorPalettes.black.withOpacity(.9),
                                ColorPalettes.black.withOpacity(.3),
                                ColorPalettes.black.withOpacity(.95)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.1, 0.5, 0.9]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CardDiscover(
                          image: movie.posterPath,
                          title: movie.title,
                          rating: movie.voteAverage,
                          genre: movie.genreIds
                              .take(3)
                              .map(buildGenreChip)
                              .toList(),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: Sizes.width(context) / 7,
                            right: Sizes.dp30(context),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                '$position',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "/${state.result.results.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is MovieNowPlayingLoading) {
            return LoadingIndicator();
          } else if (state is MovieNowPlayingError) {
            return CustomErrorWidget(message: state.errorMessage);
          } else if (state is MovieNowPlayingNoData) {
            return CustomErrorWidget(message: state.message);
          } else if (state is MovieNowPlayingNoInternetConnection) {
            return NoInternetWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context.bloc<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
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
