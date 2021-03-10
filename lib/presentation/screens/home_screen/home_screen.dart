import 'package:bloc_flutter_weather_app/logic/bloc/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        flexibleSpace: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            //Navigator.pop(context, cityName.text);
            BlocProvider.of<WeatherBloc>(context)
                .add(FetchWeather(cityName: "İstanbul"));
          },
        ),
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            print('--------------------------------');
            if (state is WeatherLoaded) {
              print(state.weather);
            }
            print('--------------------------------');
          },
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: _searchController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(FetchWeather(cityName: _searchController.text));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
