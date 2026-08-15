import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final String humidity;
  final String wind;
  final String uvIndex;
  final String bestTime;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.uvIndex,
    required this.bestTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // --------------------------------
          // TOP ROW
          // --------------------------------

          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wb_sunny_outlined,
                  color: Color(0xFFFFB000),
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                'WEATHER AT DESTINATION',
                style: TextStyle(
                  color: Color(0xFF8A98AD),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(),

              const Text(
                'Avg. conditions',
                style: TextStyle(
                  color: Color(0xFFB4BFCE),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // --------------------------------
          // WEATHER CONTENT
          // --------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Temperature
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(
                        color: Color(0xFF071226),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      condition,
                      style: const TextStyle(
                        color: Color(0xFF516078),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // --------------------------------
              // 2 x 2 INFORMATION GRID
              // --------------------------------

              Expanded(
                flex: 6,
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: _WeatherInfo(
                            icon: Icons.thermostat_outlined,
                            title: 'Humidity',
                            value: humidity,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _WeatherInfo(
                            icon: Icons.air,
                            title: 'Wind',
                            value: wind,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _WeatherInfo(
                            icon: Icons.wb_sunny_outlined,
                            title: 'UV Index',
                            value: uvIndex,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _WeatherInfo(
                            icon: Icons.access_time,
                            title: 'Best Time',
                            value: bestTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// --------------------------------------------------
// SMALL WEATHER INFORMATION BOX
// --------------------------------------------------

class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: const Color(0xFF8A98AD),
              ),

              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8A98AD),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF071226),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}