import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_weather_app/data/models/weather.dart';
import 'package:bloc_flutter_weather_app/data/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(
    this.weatherRepository,
  ) : super(WeatherInitial());

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather =
            await weatherRepository.getWeather(event.cityName);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        print(e);
        yield WeatherError();
      }
    }
  }
}
