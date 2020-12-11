import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;

  ThemeState({@required this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}
