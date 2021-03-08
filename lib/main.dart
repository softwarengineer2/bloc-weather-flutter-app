import 'logic/bloc/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'data/data_providers/weather_api_client.dart';
import 'data/models/weather.dart';
import 'data/repositories/weather_repository.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  try {
    final Weather result1 = await weatherRepository.getWeather("İstanbul");
    print(result1);
  } catch (_) {
    print('error');
  }
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
