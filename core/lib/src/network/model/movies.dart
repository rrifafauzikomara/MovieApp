import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movies.g.dart';

@JsonSerializable()
class Result extends Equatable {
  @JsonKey(name: 'results')
  final List<Movies> results;

  const Result([this.results = const []]);

  @override
  List<Object> get props => [results];

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Movies extends Equatable {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'popularity')
  final double popularity;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  @JsonKey(name: 'original_name')
  final String tvName;

  @JsonKey(name: 'first_air_date')
  final String tvRelease;

  Movies(
      this.id,
      this.title,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.voteAverage,
      this.popularity,
      this.posterPath,
      this.backdropPath,
      this.tvName,
      this.tvRelease);

  @override
  List<Object> get props => [
        id,
        title,
        overview,
        releaseDate,
        genreIds,
        voteAverage,
        popularity,
        posterPath,
        backdropPath,
        tvName,
        tvRelease
      ];

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}
