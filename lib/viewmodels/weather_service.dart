import 'package:dio/dio.dart';
import 'package:first_project/models/weather.dart';

class WeatherService {
  static final Dio _dio = Dio();

  static Future<Weather?> getWeather ({
    required double longitude,
    required double latitude,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude' : latitude,
          'longitude': longitude,
          'current' : 'temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m',
          'daily' :  'uv_index_max,sunrise,sunset',
          'hourly' : 'temperature_2m,weather_code,uv_index',
          'timezone' : 'auto',

        },
      );

      return Weather.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch(e) {
      print('Weather Error: $e');
      return null;
    }
  }
}