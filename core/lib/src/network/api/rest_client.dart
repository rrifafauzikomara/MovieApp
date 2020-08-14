import 'package:core/core.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("movie/now_playing")
  Future<Result> getMovieNowPlaying(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("movie/upcoming")
  Future<Result> getMovieUpComing(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("movie/popular")
  Future<Result> getMoviePopular(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("tv/airing_today")
  Future<Result> getTvAiringToday(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("tv/popular")
  Future<Result> getTvPopular(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("tv/on_the_air")
  Future<Result> getTvOnTheAir(
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("movie/{movie_id}/credits")
  Future<ResultCrew> getMovieCrews(@Path("movie_id") int movieId,
      @Query("api_key") String apiKey, @Query("language") String language);

  @GET("movie/{movie_id}/videos")
  Future<ResultTrailer> getMovieTrailer(@Path("movie_id") int movieId,
      @Query("api_key") String apiKey, @Query("language") String language);
}
