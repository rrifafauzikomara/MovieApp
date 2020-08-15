import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'app_config.dart';
import 'movie_app.dart';

void main() async {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  Bloc.observer = MovieBlocObserver();
  Config.appFlavor = Flavor.DEVELOPMENT;
  WidgetsFlutterBinding.ensureInitialized();
  var _isDark;
  await ThemeHelper().getTheme().then((value) => _isDark = value);
  runApp(
    CustomTheme(
      initialThemeKey: _isDark ? ThemesKeys.DARK : ThemesKeys.LIGHT,
      child: MyApp(),
    ),
  );
}
