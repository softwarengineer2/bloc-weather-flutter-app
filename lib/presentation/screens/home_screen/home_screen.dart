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
        /*flexibleSpace: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            //Navigator.pop(context, cityName.text);
            BlocProvider.of<WeatherBloc>(context)
                .add(FetchWeather(cityName: "İstanbul"));
          },
        ),*/
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
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextFormField(
                        autofocus: true,
                        textAlign: TextAlign.center,
                        controller: _searchController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('here 1');
                      },
                      child: IconButton(
                        icon: Icon(Icons.search),
                        highlightColor: Colors.pink,
                        onPressed: () {
                          print('clicked');
                          if (_searchController.text != "") {
                            BlocProvider.of<WeatherBloc>(context).add(
                                FetchWeather(cityName: _searchController.text));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Center(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (_, WeatherState state) {
                      if (state is WeatherInitial) {
                        return Center(child: Text('Please Select a Location'));
                      }
                      if (state is WeatherLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is WeatherLoaded) {
                        final weather = state.weather;
                        return ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                child: Text("Location"),
                              ),
                            ),
                            Center(
                              child: Text("Last Update"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: Text("Location"),
                              ),
                            ),
                          ],
                        );
                      }
                      //if (state is WeatherError) {
                      return Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.red),
                      );
                      //}
                    },
                  ),
                ),
                /*FloatingActionButton(
                  onPressed: () => {print('clicked')},
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
