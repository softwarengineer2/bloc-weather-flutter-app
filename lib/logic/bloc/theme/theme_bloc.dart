import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_weather_app/core/themes/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeUpdated(themeMode: ThemeMode.light)) {
    add(UpdateTheme());
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is UpdateTheme) {
      if (AppTheme.currentSystemBrightness == Brightness.light) {
        AppTheme.setStatusBarAndNavigationBarColors(ThemeMode.light);
        yield ThemeUpdated(themeMode: ThemeMode.light);
      } else {
        AppTheme.setStatusBarAndNavigationBarColors(ThemeMode.dark);
        yield ThemeUpdated(themeMode: ThemeMode.dark);
      }
    }
  }
}
