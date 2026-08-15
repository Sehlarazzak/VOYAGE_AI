class Weather {
  final double temperature;
  final int weatherCode;
  final int humidity;
  final double windSpeed;
  final double uvIndex;
  final String condition;
  final String bestTime;
  final String sunset;
  final String sunrise;
  final List<double> hourlyTemperatures;
  final List<int> hourlyWeatherCodes;
  final List<double> hourlyUvIndexes;

  Weather({
    required this.temperature,
    required this.weatherCode,
    required this.humidity,
    required this.windSpeed,
    required this.uvIndex,
    required this.condition,
    required this.bestTime,
    required this.sunrise,
    required this.sunset,
    required this.hourlyTemperatures,
    required this.hourlyWeatherCodes,
    required this.hourlyUvIndexes,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;

    final int code = current['weather_code'] as int;

    final hourlyTemperatures = (hourly['temperature_2m'] as List)
        .map((value) => (value as num).toDouble())
        .toList();

    final hourlyWeatherCodes =
    (hourly['weather_code'] as List)
        .map((value) => (value as num).toInt())
        .toList();

final hourlyUvIndexes =
    (hourly['uv_index'] as List)
        .map((value) => (value as num).toDouble())
        .toList();
    

    final String sunrise = (daily['sunrise'] as List).first as String;
    final String sunset = (daily['sunset'] as List).first as String;

    final uvList = daily['uv_index_max'] as List<dynamic>?;

final double uvIndex =
    uvList != null && uvList.isNotEmpty && uvList.first is num
        ? (uvList.first as num).toDouble()
        : 0.0;



    return Weather(
      temperature: (current['temperature_2m'] as num).toDouble(), 
      weatherCode: code,
      humidity: (current['relative_humidity_2m'] as num).toInt(), 
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      uvIndex: uvIndex,
      sunrise: sunrise,
      sunset: sunset,
      condition: _weatherCodeToText(code),
      bestTime: _calculateBestTime(hourlyTemperatures, hourlyWeatherCodes, hourlyUvIndexes,),
      hourlyTemperatures: hourlyTemperatures,
      hourlyWeatherCodes: hourlyWeatherCodes,
      hourlyUvIndexes: hourlyUvIndexes,

      );
  }


  static String _weatherCodeToText(int code) {
    switch(code) {
      case 0:
      return 'Clear & Sunny';

      case 1:
      case 2:
      return 'Partly Cloudy';

      case 3:
      return 'Cloudy';

      case 45:
      case 48:
      return 'Foggy';

      case 51:
      case 53:
      case 55:
      return 'Little Drizzle';

      case 61:
      case 63:
      case 65:
      return 'Rainy';

      case 71:
      case 73:
      case 75:
      return 'Snowy';

      case 80:
      case 81:
      case 82:
      return 'Rain Showers';

      case 95:
      case 96:
      case 99:
      return 'Thunderstorm';

      default:
      return 'Mixed Conditions';
    }
}

static String uvIndexToText(double uvIndex) {
  if (uvIndex <= 2) {
    return 'Low';
  } else if (uvIndex <= 5) {
    return 'Moderate';
  } else if (uvIndex <= 7) {
    return 'High';
  } else if (uvIndex <= 10) {
    return 'Very High';
  } else {
    return 'Extreme';
  }
}

static String _calculateBestTime(
  List<double> temperatures,
  List<int> weatherCodes,
  List<double> uvIndexes,
) {
  if (temperatures.isEmpty ||
      weatherCodes.isEmpty ||
      uvIndexes.isEmpty) {
    return 'Morning';
  }

  double bestScore = double.infinity;
  int bestHour = 9;

  final int count = [
    temperatures.length,
    weatherCodes.length,
    uvIndexes.length,
  ].reduce((a, b) => a < b ? a : b);

  for (int i = 0; i < count; i++) {
    final int hour = i % 24;

    // Only consider daytime hours.
    if (hour < 6 || hour > 18) {
      continue;
    }

    double score = 0;

    // Prefer comfortable temperatures.
    final temperatureDifference =
        (temperatures[i] - 22).abs();

    score += temperatureDifference;

    // Prefer lower UV.
    score += uvIndexes[i] * 1.5;

    // Penalize bad weather.
    final code = weatherCodes[i];

    if (code >= 51 && code <= 67) {
      score += 5;
    }

    if (code >= 71 && code <= 82) {
      score += 7;
    }

    if (code >= 95) {
      score += 10;
    }

    if (score < bestScore) {
      bestScore = score;
      bestHour = hour;
    }
  }

  if (bestHour < 10) {
    return 'Morning';
  }

  if (bestHour < 14) {
    return 'Late Morning';
  }

  if (bestHour < 17) {
    return 'Afternoon';
  }

  return 'Evening';
}
}