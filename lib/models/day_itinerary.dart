class DayItinerary {
  final int dayNumber;
  final String title;
  final String morningTime;
  final String morningFood;
  final String morningActivity;
  final String afternoonFood;
  final String afternoonTime;
  final String afternoonActivity;
  final String eveningTime;
  final String eveningFood;
  final String eveningActivity;
  final String transportCost;
  final String foodCost;
  final String activitiesCost;
  final String accommodationCost;
  final String shoppingCost;
  final String totalCost;

  DayItinerary({
    required this.dayNumber,
    required this.title,
    required this.morningTime,
    required this.morningActivity,
    required this.morningFood,
    required this.eveningActivity,
    required this.eveningFood,
    required this.eveningTime,
    required this.afternoonActivity,
    required this.afternoonFood,
    required this.afternoonTime,
    required this.activitiesCost,
    required this.transportCost,
    required this.foodCost,
    required this.accommodationCost,
    required this.shoppingCost,
    required this.totalCost,
  });

  factory DayItinerary.fromJson(Map<String, dynamic> json) {
    final morning = json['morning'] as Map<String, dynamic>;
    final afternoon = json['afternoon'] as Map<String, dynamic>;
    final evening = json['evening'] as Map<String, dynamic>;
    final estimatedCost = json['estimatedCost'] as Map<String, dynamic>;

    return DayItinerary(
      dayNumber: json['dayNumber'] as int, 
      title: json['title'] as String, 
      morningTime: morning['time'] as String, 
      morningActivity: morning['activity'] as String, 
      morningFood: morning['food'] as String, 
      eveningActivity: evening['activity'] as String, 
      eveningFood: evening['food'] as String, 
      eveningTime: evening['time'] as String, 
      afternoonActivity: afternoon['activity'] as String, 
      afternoonFood: afternoon['food'] as String, 
      afternoonTime: afternoon['time'] as String, 
      activitiesCost: estimatedCost['activities'] as String, 
      transportCost: estimatedCost['transport'] as String, 
      foodCost: estimatedCost['food'] as String, 
      accommodationCost: estimatedCost['accommodation'] as String, 
      shoppingCost: estimatedCost['shopping'] as String, 
      totalCost: estimatedCost['total'] as String,
      );
  }

  Map<String, dynamic> toJson() {
  return {
    'dayNumber': dayNumber,
    'title': title,

    'morning': {
      'time': morningTime,
      'activity': morningActivity,
      'food': morningFood,
    },

    'afternoon': {
      'time': afternoonTime,
      'activity': afternoonActivity,
      'food': afternoonFood,
    },

    'evening': {
      'time': eveningTime,
      'activity': eveningActivity,
      'food': eveningFood,
    },

    'estimatedCost': {
      'transport': transportCost,
      'food': foodCost,
      'activities': activitiesCost,
      'accommodation': accommodationCost,
      'shopping': shoppingCost,
      'total': totalCost,
    },
  };
}


}