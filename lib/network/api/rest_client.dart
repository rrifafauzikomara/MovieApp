import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("now_playing")
  Future<Result> getNowPlaying(
    @Query("api_key") String apiKey,
    @Query("language") String language
  );

  @GET("upcoming")
  Future<Result> getUpComing(
    @Query("api_key") String apiKey,
    @Query("language") String language
  );

  @GET("popular")
  Future<Result> getPopular(
    @Query("api_key") String apiKey,
    @Query("language") String language
  );

  @GET("top_rated")
  Future<Result> getTopRated(
    @Query("api_key") String apiKey,
    @Query("language") String language
  );
}

@JsonSerializable()
class Result extends Equatable {
  final List<Movies> results;
  const Result([this.results = const []]);

  @override
  List<Object> get props => [results];

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Movies extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String release_date;
  final List<int> genre_ids;
  final double vote_average;
  final double popularity;
  final String poster_path;
  final String backdrop_path;

  Movies(this.id, this.title, this.overview, this.release_date, this.genre_ids,
      this.vote_average, this.popularity, this.poster_path, this.backdrop_path);

  @override
  List<Object> get props => [
        id,
        title,
        overview,
        release_date,
        genre_ids,
        vote_average,
        popularity,
        poster_path,
        backdrop_path
      ];

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}

class Genres {
  static Map<int,String> genres = {
    10759: "Action & Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    10762: "Kids",
    9648: "Mystery",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi & Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War & Politics",
    37: "Western",
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
  };
}