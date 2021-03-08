import 'dart:convert';
import 'dart:io';

import 'package:bloc_flutter_weather_app/data/models/weather.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final mainUrl = Uri.parse('$baseUrl/api/location/search/?query=$city');
    final response = await this.httpClient.get(mainUrl);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('error LocationId');
    }

    final locationJson = jsonDecode(response.body) as List;

    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final mainUrl = Uri.parse('$baseUrl/api/location/$locationId');

    final response = await this.httpClient.get(mainUrl);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('error fetching weather');
    }

    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }
}
