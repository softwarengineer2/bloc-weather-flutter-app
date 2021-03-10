part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {}

class FetchWeather extends WeatherEvent {
  final String cityName;

  FetchWeather({@required this.cityName});

  @override
  List<Object> get props => [this.cityName];
}
