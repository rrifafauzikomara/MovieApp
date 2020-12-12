import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviecatalogue/ui/booking/booking_screen.dart';
import 'package:shared/shared.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail_movies';

  final ScreenArguments arguments;

  const DetailScreen({Key key, @required this.arguments});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  _loadTrailer(BuildContext context, int movieId, bool isFromMovie) {
    context.read<TrailerBloc>().add(LoadTrailer(movieId, isFromMovie));
  }

  _loadCrew(BuildContext context, int movieId, bool isFromMovie) {
    context.read<CrewBloc>().add(LoadCrew(movieId, isFromMovie));
  }

  @override
  void initState() {
    super.initState();
    _loadTrailer(
        context, widget.arguments.movies.id, widget.arguments.isFromMovie);
    _loadCrew(
        context, widget.arguments.movies.id, widget.arguments.isFromMovie);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  isFromBanner: widget.arguments.isFromBanner,
                  idMovie: widget.arguments.movies.id,
                  title: widget.arguments.movies.title ??
                      widget.arguments.movies.tvName,
                  imageBanner:
                      widget.arguments.movies.backdropPath.imageOriginal,
                  imagePoster: widget.arguments.movies.posterPath.imageOriginal,
                  rating: widget.arguments.movies.voteAverage,
                  genre: widget.arguments.movies.genreIds
                      .take(3)
                      .map(buildGenreChip)
                      .toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(Sizes.dp20(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Story line',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dp16(context),
                        ),
                      ),
                      SizedBox(height: Sizes.dp8(context)),
                      Text(
                        widget.arguments.movies.overview,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: _buildYoutube(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: _buildCrew(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dp20(context),
                    bottom: Sizes.dp20(context),
                  ),
                  child: CustomButton(
                    text: "Booking Ticket",
                    onPressed: () {
                      Navigation.intentWithData(
                          context,
                          BookingScreen.routeName,
                          ScreenArguments(
                              widget.arguments.movies, true, false));
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: Sizes.width(context) / 9,
              right: Sizes.dp5(context),
              child: IconButton(
                iconSize: Sizes.dp30(context),
                color: theme.accentColor,
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  PopUp.showSnackBarSuccess("Add to Favorite", context);
                },
              ),
            ),
            Positioned(
              top: Sizes.width(context) / 9,
              left: Sizes.dp5(context),
              child: IconButton(
                icon: Platform.isAndroid
                    ? Icon(Icons.arrow_back)
                    : Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYoutube() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailer',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.7,
          child: BlocBuilder<TrailerBloc, TrailerState>(
            builder: (context, state) {
              if (state is TrailerHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.trailer.trailer.length,
                  itemBuilder: (BuildContext context, int index) {
                    Trailer trailer = state.trailer.trailer[index];
                    return CardTrailer(
                      title: trailer.title,
                      youtube: trailer.youtubeId,
                      length: state.trailer.trailer.length,
                      onExitFullScreen: () {
                        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                        SystemChrome.setPreferredOrientations(
                            DeviceOrientation.values);
                      },
                    );
                  },
                );
              } else if (state is TrailerLoading) {
                return ShimmerTrailer();
              } else if (state is TrailerError) {
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is TrailerNoData) {
                return CustomErrorWidget(message: state.message);
              } else if (state is TrailerNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => _loadTrailer(context,
                      widget.arguments.movies.id, widget.arguments.isFromMovie),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCrew() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Crew',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 3,
          child: BlocBuilder<CrewBloc, CrewState>(
            builder: (context, state) {
              if (state is CrewHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.crew.crew.length,
                  itemBuilder: (BuildContext context, int index) {
                    Crew crew = state.crew.crew[index];
                    return CardCrew(
                      image: crew.profile,
                      name: crew.characterName,
                    );
                  },
                );
              } else if (state is CrewLoading) {
                return ShimmerCrew();
              } else if (state is CrewError) {
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is CrewNoData) {
                return CustomErrorWidget(message: state.message);
              } else if (state is CrewNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => _loadCrew(context,
                      widget.arguments.movies.id, widget.arguments.isFromMovie),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }
}
