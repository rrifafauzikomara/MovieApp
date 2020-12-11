import 'package:core/core.dart';
import 'package:core/src/bloc/theme/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inject = GetIt.instance;

Future<void> init(String baseUrl) async {
  // BLoC
  inject.registerFactory(() => CrewBloc(repository: inject()));
  inject.registerFactory(() => TrailerBloc(repository: inject()));

  inject.registerFactory(() => DiscoverMovieBloc(repository: inject()));
  inject.registerFactory(() => MovieNowPlayingBloc(repository: inject()));
  inject.registerFactory(() => MoviePopularBloc(repository: inject()));
  inject.registerFactory(() => MovieUpComingBloc(repository: inject()));

  inject.registerFactory(() => TvAiringTodayBloc(repository: inject()));
  inject.registerFactory(() => TvPopularBloc(repository: inject()));
  inject.registerFactory(() => TvOnTheAirBloc(repository: inject()));

  inject.registerFactory(() => ThemeBloc(prefHelper: inject()));

  // Repository
  inject.registerLazySingleton<Repository>(() =>
      MovieRepository(apiRepository: inject(), localRepository: inject()));
  inject.registerLazySingleton(() => LocalRepository(prefHelper: inject()));
  inject.registerLazySingleton(() => ApiRepository(apiService: inject()));

  // Local
  final preferences = await SharedPreferences.getInstance();
  inject.registerLazySingleton(() => preferences);
  inject.registerLazySingleton(() => SharedPrefHelper(preferences: inject()));

  // Network
  inject.registerLazySingleton(() => ApiService(dio: inject()));
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(() => DioClient(apiBaseUrl: baseUrl));
}
