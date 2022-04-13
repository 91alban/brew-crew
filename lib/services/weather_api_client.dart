import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=649b4f757bbbf29c3230623c7b1079cc&units=metric');

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    Weather weather = Weather.fromJson(body);
    print('apiCall ${weather.cityname}');
    return weather;
  }
}
