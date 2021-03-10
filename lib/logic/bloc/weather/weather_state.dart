part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  WeatherLoaded({@required this.weather}) : super();
  final Weather weather;
}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {}
