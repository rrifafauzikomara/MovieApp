import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import 'app_config.dart';
import 'movie_app.dart';

void main() async {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = MovieBlocDelegate();

  Config.appFlavor = Flavor.RELEASE;

  runApp(MyApp());
}