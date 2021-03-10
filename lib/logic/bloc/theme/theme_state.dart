part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;

  ThemeState({@required this.themeMode});

  @override
  List<Object> get props => [];
}

class ThemeUpdated extends ThemeState {
  final ThemeMode themeMode;

  ThemeUpdated({@required this.themeMode}) : super(themeMode: themeMode);
}
