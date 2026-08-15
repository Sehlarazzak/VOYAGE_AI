import 'package:first_project/models/itinerary.dart';
import 'package:first_project/viewmodels/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:first_project/widgets/day_itinerarycard.dart';
import 'package:first_project/widgets/budget_breakdown.dart';
import 'package:first_project/widgets/insidertips_card.dart';
import 'package:first_project/widgets/itinerary_header.dart';
import 'package:first_project/widgets/traveltips_card.dart';
import 'package:first_project/widgets/weather_card.dart';
import 'package:first_project/widgets/bottom_buttons.dart';
import 'package:first_project/models/itinerary.dart';
import 'package:first_project/viewmodels/weather_service.dart';
import 'package:first_project/models/weather.dart';
import 'package:first_project/viewmodels/saved_trip_service.dart';
import 'package:first_project/viewmodels/location_service.dart';

class GeneratedItineraryScreen extends StatefulWidget{
  final String destination;
  final String budget;
  final int days;
  final int travellers;
  final List interests;
  final String travelStyle;
  final Itinerary itinerary;
  final String? imageUrl;
  final String province;
  final Weather? weather;

  const GeneratedItineraryScreen({
    super.key,
    required this.destination,
    required this.budget,
    required this.days,
    required this.travellers,
    required this.interests,
    required this.travelStyle,
    required this.itinerary,
    this.imageUrl,
    required this.province,
    this.weather,
  });

  @override
  State<GeneratedItineraryScreen> createState() => _GeneratedItineraryScreenState();
}

class _GeneratedItineraryScreenState extends State<GeneratedItineraryScreen> {
  @override

  late Itinerary currentItinerary;
  bool isRegenerating = false;

  Weather? weather;
  TextEditingController changeController = TextEditingController();

  Future<void> _regenerateItinerary({
    required String? selectedDay,
    required String changeRequest,
  }) async {
    try {

      print('========== REGENERATION STARTED ==========');
    print('Selected day: $selectedDay');
    print('Change request: $changeRequest');



      setState(() {
        isRegenerating = true;
      });

      final String regenerationType = selectedDay == null ?
      'whole_trip' : 'specific_day';

      final int? dayNumber = selectedDay == null ?
      null : int.tryParse(selectedDay.replaceAll('Day ', ''),
      );

      print('Regeneration type: $regenerationType');
    print('Day number: $dayNumber');
    print('Calling Gemini...');

      final regeneratedItinerary = await GeminiService.regenerateItinerary(
        destination: widget.destination, 
        budget: widget.budget, 
        travellers: widget.travellers, 
        interests: widget.interests, 
        travelStyle: widget.travelStyle, 
        currentItinerary: currentItinerary, 
        regenerationType: regenerationType, 
        userRequest: changeRequest,
        selectedDay: dayNumber,
        );

         print('========== GEMINI REGENERATION SUCCESSFUL ==========');

        if(!mounted) return;

        setState(() {
          currentItinerary = regeneratedItinerary;
          isRegenerating = false;
        });

        print('NEW ITINERARY SET ON SCREEN');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Itinerary Regenerated Successfully!'),
          ),
        );

    } catch(e) {
      print('========== REGENERATION ERROR ==========');
    print(e);
      if(!mounted) return;
      
      setState(() {
        isRegenerating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to regenrate Itinerary: $e'),
        ),
      );
    }
  }

  void _showRegenerateDialog() {
    String regenerationType = 'whole';
    String? selectedDay;

    showDialog(context: context, 
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Regenerate Itinerary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What would you like to change?',
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(height: 18),

                RadioListTile<String> (
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Entire Plan'),
                  value: 'whole',
                  groupValue: regenerationType,
                  onChanged: (value) {
                    setDialogState(() {
                      regenerationType = value!;
                      selectedDay = null;
                    });
                  },
                  ),

                  RadioListTile<String> (
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Specific Day'),
                    value: 'day',
                    groupValue: regenerationType,
                    onChanged: (value) {
                      setDialogState(() {
                        regenerationType = value!;
                      });
                    },
                  ),

                  if(regenerationType == 'day') ...[
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Day',
                        border: OutlineInputBorder(),
                      ),

                      value: selectedDay,

                      items: List.generate(widget.days, 
                      (index) {
                        final day = 'Day ${index + 1}';

                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      },
                      ),

                      onChanged: (value) {
                        setDialogState(() {
                          selectedDay = value;
                        });
                      },
                    ),
                  ],

                  const SizedBox(height: 20),

                  const Text('Describe what you want to change',
                  style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: changeController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'e.g. Add more adventure activities...',
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        ),
      ),
              ],
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if(regenerationType == 'day' && selectedDay == null) {
                      return;
                    }

                    if(changeController.text.trim().isEmpty) {
                      return;
                    }

                    final request = changeController.text.trim();

                    Navigator.pop(context);

                    print('CONTINUE BUTTON PRESSED');

                    await _regenerateItinerary(
                      selectedDay: selectedDay,
                      changeRequest: request,
                    );
              }, 
                  child: const Text('Continue'),
                  ),
            ],
          );

        },
        );
    },
    );
  }

  Future<void> _loadWeather() async {
    try{
      print('LOADING WEATHER FOR: ${widget.destination}');

      final location = await LocationService.getDestination(widget.destination);

      if(location == null) {
        print('LOCATION NOT FOUND FOR WEATHER');
        return;
      }

      print('WEATHER LOCATION: ${location.name}');
    print('LATITUDE: ${location.latitude}');
    print('LONGITUDE: ${location.longitude}');

    final result = await WeatherService.getWeather(longitude: location.longitude, 
    latitude: location.latitude,
    );

    if(!mounted) return;
    setState(() {
      weather = result;
    });

    print('WEATHER LOADED: $weather');
    } catch(e) {
      print('WEATHER ERROR: $e');
    }
  }

  double _extractCost(String value) {
    return double.tryParse(
      value.replaceAll(RegExp(r'[^0-9.]'), ''),
    ) ??
    0;
  }

  double _calculateTotal(List days, String Function(dynamic) getCost,) {
    double total = 0;
    for(final day in days) {
      total += _extractCost(getCost(day));
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
    currentItinerary = widget.itinerary;
  }

  Widget build(BuildContext context) {
    final transportTotal = _calculateTotal(currentItinerary.days, (day) => day.transportCost,);
    
    final foodTotal = _calculateTotal(currentItinerary.days, (day) => day.foodCost,);

    final activitiesTotal = _calculateTotal(currentItinerary.days, (day) => day.activitiesCost,);

    final accommodationTotal = _calculateTotal(currentItinerary.days, (day) => day.accommodationCost,);

    final shoppingTotal = _calculateTotal(currentItinerary.days, (day) => day.shoppingCost,);

    final grandTotal = transportTotal + activitiesTotal + foodTotal +accommodationTotal + shoppingTotal;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FD),

      body: SafeArea(child: 
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
            ItineraryHeader(
              destination: widget.destination, 
              travellers: widget.travellers, 
              days: widget.days, 
              budget: widget.budget,
              imageUrl: widget.imageUrl,
              province: widget.province,
              travelStyle: widget.travelStyle,
              ),


                Padding(padding: const EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0,),

                child: WeatherCard(
                  temperature: weather != null ? '${weather!.temperature.round()}°C' : '--', 
                condition: weather?.condition ?? 'Weather unavailable', 
                humidity: weather != null? '${weather!.humidity}%' : '--', 
                wind: weather != null? '${weather!.windSpeed.round()} km/h' : '--', 
                uvIndex: weather != null? Weather.uvIndexToText(weather!.uvIndex) : '--', 
                bestTime: weather?.bestTime ?? '--',
                ),
                ),

                const SizedBox(height: 28),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
  children: [
    Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Icon(
        Icons.calendar_month_outlined,
        color: Color(0xFF1763D6),
        size: 22,
      ),
    ),

    const SizedBox(width: 12),

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR ITINERARY',
          style: TextStyle(
            color: Color(0xFF071226),
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${widget.days} days in ${widget.destination}',
          style: const TextStyle(
            color: Color(0xFF7C899D),
            fontSize: 13,
          ),
        ),
      ],
    ),

    const Spacer(),

    Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'AI CRAFTED',
        style: TextStyle(
          color: Color(0xFF1763D6),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),
                ),

                const SizedBox(height: 15),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: currentItinerary.days.map((day) {
                    return DayItinerarycard(title: day.title, 
                    dayNumber: day.dayNumber, 
                    morning: day.morningActivity, 
                    morningTime: day.morningTime, 
                    morningFood: day.morningFood, 
                    afternoon: day.afternoonActivity, 
                    afternoonTime: day.afternoonTime, 
                    afternoonFood: day.afternoonFood, 
                    evening: day.eveningActivity, 
                    eveningTime: day.eveningTime, 
                    eveningFood: day.eveningFood, 
                    estimatedCost: day.totalCost
                    );
                  }).toList(),
                ),
                ),
                const SizedBox(height: 15),

                const Padding(
  padding: EdgeInsets.fromLTRB(20, 15, 20, 12),
  child: Text(
    'AI TRAVEL TIPS',
    style: TextStyle(
      color: Color(0xFF071226),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),
                

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AITravelTips(tips: currentItinerary.transportTips,
                    ),
                ),

                const SizedBox(height: 25),

                const Padding(
  padding: EdgeInsets.fromLTRB(20, 5, 20, 12),
  child: Text(
    'BUDGET BREAKDOWN',
    style: TextStyle(
      color: Color(0xFF071226),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BudgetBreakdown(transportCost: 'RS. $transportTotal', foodCost: 'Rs. $foodTotal', activitiesCost: 'Rs. $activitiesTotal', accommodationCost: 'Rs. $accommodationTotal', shoppingCost: 'Rs. $shoppingTotal', totalCost: 'Rs. $grandTotal'),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
      ),

          bottomNavigationBar : BottomButtons(
            onSave: () async {
              try {
              await SavedTripService.saveTrip(
                destination: widget.destination,
                province: widget.province,
                budget: widget.budget,
                days: widget.days,
                travellers: widget.travellers,
                interests: widget.interests,
                travelStyle: widget.travelStyle,
                imageUrl: widget.imageUrl,
                itinerary: currentItinerary,
              );

              if(!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trip Saved Successfully!'),
                ),
              );
            } catch (e) {
              if(!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to save trip: $e'),
                ),
              );
            }
            },

          onRegenerate: () {
            _showRegenerateDialog();
          },
          ),
      );

  }
}