// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Movies.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'results': instance.results,
    };

Movies _$MoviesFromJson(Map<String, dynamic> json) {
  return Movies(
    json['id'] as int,
    json['title'] as String,
    json['overview'] as String,
    json['release_date'] as String,
    (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    (json['vote_average'] as num)?.toDouble(),
    (json['popularity'] as num)?.toDouble(),
    json['poster_path'] as String,
    json['backdrop_path'] as String,
  );
}

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.release_date,
      'genre_ids': instance.genre_ids,
      'vote_average': instance.vote_average,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.themoviedb.org/3/movie/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getNowPlaying(apiKey, language) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(language, 'language');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'language': language
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'now_playing',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Result.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getUpComing(apiKey, language) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(language, 'language');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'language': language
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'upcoming',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Result.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getPopular(apiKey, language) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(language, 'language');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'language': language
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('popular',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Result.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getTopRated(apiKey, language) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(language, 'language');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'api_key': apiKey,
      'language': language
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'top_rated',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Result.fromJson(_result.data);
    return Future.value(value);
  }
}
