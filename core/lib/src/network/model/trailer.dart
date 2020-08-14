import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trailer.g.dart';

@JsonSerializable()
class ResultTrailer extends Equatable {
  @JsonKey(name: 'results')
  final List<Trailer> trailer;

  const ResultTrailer([this.trailer = const []]);

  @override
  List<Object> get props => [trailer];

  factory ResultTrailer.fromJson(Map<String, dynamic> json) =>
      _$ResultTrailerFromJson(json);

  Map<String, dynamic> toJson() => _$ResultTrailerToJson(this);
}

@JsonSerializable()
class Trailer extends Equatable {
  @JsonKey(name: 'id')
  final String trailerId;

  @JsonKey(name: 'key')
  final String youtubeId;

  @JsonKey(name: 'name')
  final String title;

  Trailer(this.trailerId, this.youtubeId, this.title);

  @override
  List<Object> get props => [trailerId, youtubeId, title];

  factory Trailer.fromJson(Map<String, dynamic> json) =>
      _$TrailerFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerToJson(this);
}
