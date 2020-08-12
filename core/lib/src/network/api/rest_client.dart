import 'package:core/core.dart';
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
}