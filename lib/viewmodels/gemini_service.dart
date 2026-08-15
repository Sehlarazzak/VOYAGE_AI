import 'package:firebase_ai/firebase_ai.dart';
import 'dart:convert';
import 'package:first_project/models/itinerary.dart';

class GeminiService {
  static Future<Itinerary> generateItinerary ({
    required String destination,
    required String budget,
    required int days,
    required int travellers,
    required List interests,
    required String travelStyle,
  }) async {
    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.6-flash',
    );

    final prompt = '''
You are an expert Pakistan travel planner.

Create a detailed ${days}-day travel itinerary for:

Destination: $destination
Budget: $budget
Number of travellers: $travellers
Interests: ${interests.join(', ')}
Travel style: $travelStyle

The itinerary must be practical and suitable for travelling in Pakistan.

Return ONLY valid JSON.
Do not include markdown.
Do not include ```json.
Do not include any explanation before or after the JSON.

Use EXACTLY this structure:

{
  "days": [
    {
      "dayNumber": 1,
      "title": "Short title for the day",

      "morning": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

      "afternoon": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

      "evening": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

      "estimatedCost": {
        "transport": "Estimated amount in PKR",
        "food": "Estimated amount in PKR",
        "activities": "Estimated amount in PKR",
        "accommodation": "Estimated amount in PKR",
        "shopping": "Estimated amount in PKR",
        "total": "Estimated total in PKR"
      }
    }
  ],

  "travelTips": [
    "Tip 1",
    "Tip 2",
    "Tip 3",
    "Tip 4"
  ],

  "transportTips": [
    "Transport tip 1",
    "Transport tip 2"
  ],

  "safetyTips": [
    "Safety tip 1",
    "Safety tip 2"
  ],

  "insiderTips": [
    "Local insider tip 1",
    "Local insider tip 2"
  ]
}

Important requirements:

- Generate exactly ${days} objects inside the "days" array.
- dayNumber must start at 1 and continue sequentially.
- Give specific activities and locations.
- Include realistic cafe, restaurant, dhaba or local food recommendations when appropriate.
- Include foods that are genuinely associated with the destination.
- Give approximate timings.
- Give estimated costs in Pakistani Rupees.
- Keep recommendations realistic.
- Do not invent exact prices, opening hours, availability, or restaurant details when uncertain.
- If you are uncertain about a specific restaurant, recommend a type of local restaurant or food street instead.
''';

final response = await model.generateContent([
  Content.text(prompt),
]);

final text = response.text;

if(text == null || text.isEmpty) {
  throw Exception('Gemini returned an empty response');
}

final data = jsonDecode(text);

return Itinerary.fromJson(
  data as Map<String, dynamic>,
);
  }

  static Future<Itinerary> regenerateItinerary ({
    required String destination,
    required String budget,
    required int travellers,
    required List interests,
    required String travelStyle,
    required Itinerary currentItinerary,
    required String regenerationType,
    int? selectedDay,
    required String userRequest,
  }) async {
    final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-3.6-flash');

    final currentItineraryJson = jsonEncode(currentItinerary.toJson());

     final prompt = '''
You are an expert Pakistan travel planner.

The user already has the following itinerary:

$currentItineraryJson

Destination: $destination
Budget: $budget
Number of travellers: $travellers
Interests: ${interests.join(', ')}
Travel style: $travelStyle

The user wants to regenerate the itinerary.

Regeneration type: $regenerationType
Selected day: ${selectedDay ?? 'None'}

User's requested changes:
$userRequest

IMPORTANT:

If the regeneration type is "whole_trip":
- Create a completely new itinerary.
- Keep the same destination, budget, travellers, interests and travel style.
- You may replace activities, restaurants, timings and recommendations.
- Return the COMPLETE itinerary.

If the regeneration type is "specific_day":
- ONLY modify Day $selectedDay.
- Keep every other day EXACTLY the same as the existing itinerary.
- Apply the user's requested changes to Day $selectedDay.
- Keep the same number of days.
- Return the COMPLETE itinerary, including unchanged days.

Return ONLY valid JSON.
Do not include markdown.
Do not include ```json.
Do not include explanations before or after the JSON.

Use EXACTLY this structure:

{
  "days": [
    {
      "dayNumber": 1,
      "title": "Short title for the day",

      "morning": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

        "afternoon": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

      "evening": {
        "time": "Approximate time",
        "activity": "Activity and location",
        "food": "Recommended cafe, restaurant, dhaba or local food to try"
      },

      "estimatedCost": {
        "transport": "Estimated amount in PKR",
        "food": "Estimated amount in PKR",
        "activities": "Estimated amount in PKR",
        "accommodation": "Estimated amount in PKR",
        "shopping": "Estimated amount in PKR",
        "total": "Estimated total in PKR"
      }
    }
  ],

  "travelTips": [
    "Tip 1",
    "Tip 2",
    "Tip 3",
    "Tip 4"
  ],

   "transportTips": [
    "Transport tip 1",
    "Transport tip 2"
  ],

  "safetyTips": [
    "Safety tip 1",
    "Safety tip 2"
  ],

  "insiderTips": [
    "Local insider tip 1",
    "Local insider tip 2"
  ]
}

Requirements:

- Generate exactly ${currentItinerary.days.length} day objects.
- dayNumber must start at 1 and continue sequentially.
- Give specific and realistic activities.
- Give approximate timings.
- Give estimated costs in Pakistani Rupees.
- Do not invent exact prices, opening hours, availability or restaurant details when uncertain.
- If uncertain about a restaurant, recommend a type of local restaurant, food street or local food instead.
- For specific_day regeneration, DO NOT change the other days.
''';

print('REGENERATION PROMPT CREATED');
print('SENDING REQUEST TO GEMINI...');

final response = await model.generateContent([
  Content.text(prompt),
]);

print('GEMINI RESPONSE RECEIVED');

final text = response.text;

print('GEMINI RESPONSE TEXT: $text');

if(text == null || text.isEmpty) {
  throw Exception('Gemini returned an empty response');
}

final data = jsonDecode(text);

return Itinerary.fromJson(
  data as Map<String, dynamic>,
);
  }
}