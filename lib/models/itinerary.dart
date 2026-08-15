import 'package:first_project/models/day_itinerary.dart';

class Itinerary {
  final List<DayItinerary> days;

  final List<String> travelTips;
  final List<String> transportTips;
  final List<String> safetyTips;
  final List<String> insiderTips;

  Itinerary({
    required this.days,
    required this.transportTips,
    required this.travelTips,
    required this.safetyTips,
    required this.insiderTips,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    final daysJson = json['days'] as List;

    return Itinerary(
      days: daysJson.map(
        (day) => DayItinerary.fromJson(
          day as Map<String, dynamic>,
        ),
      )
      .toList(),
      transportTips: List<String>.from(
        json['transportTips'] ?? [],
      ), 
      travelTips: List<String>.from(
        json['travelTips'] ?? [],
      ), 
      safetyTips: List<String>.from(
        json['safetyTips'] ?? [],
      ), 
      insiderTips: List<String>.from(
        json['insiderTips'] ?? [],
      ),
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),

    'travelTips': travelTips,
    'transportTips': transportTips,
    'safetyTips': safetyTips,
    'insiderTips': insiderTips,
    };
  }
}