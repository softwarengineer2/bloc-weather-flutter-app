import 'logic/bloc/theme/theme_bloc.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  try {
    final Weather result1 = await weatherRepository.getWeather("İstanbul");
    print(result1);
  } catch (e) {
    print(e);
  }
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => WeatherBloc(weatherRepository),
      ),
      BlocProvider(
        create: (context) => ThemeBloc(),
      ),
    ], child: MainApp(weatherRepository: weatherRepository));
  }
}

class MainApp extends StatefulWidget {
  final WeatherRepository weatherRepository;

  MainApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  _MainAppState createState() => _MainAppState(weatherRepository);
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final WeatherRepository weatherRepository;

  _MainAppState(this.weatherRepository);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeBloc>().add(UpdateTheme());
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.select((ThemeBloc themeBloc) => themeBloc.state.themeMode),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
