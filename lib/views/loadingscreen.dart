import 'package:flutter/material.dart';
import 'dart:async';
import 'package:first_project/viewmodels/gemini_service.dart';
import 'package:first_project/views/generated_itinerary_screen.dart';
import 'package:first_project/models/itinerary.dart';
import 'package:first_project/viewmodels/location_service.dart';
import 'package:first_project/viewmodels/image_service.dart';
import 'package:first_project/models/destination.dart';
import 'package:first_project/models/weather.dart';
import 'package:first_project/viewmodels/weather_service.dart';
import 'package:first_project/viewmodels/saved_trip_service.dart';

class LoadingScreen extends StatefulWidget{
  final String destination;
  final String budget;
  final int days;
  final int travellers;
  final List<String> interests;
  final String travelStyle;

  const LoadingScreen({
    super.key,
    required this.destination,
    required this.budget,
    required this.days,
    required this.travellers,
    required this.interests,
    required this.travelStyle,
    });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int currentStep = 0;
  Timer? timer;
  Timer? factTimer;
  Itinerary? generatedItinerary;
  bool geminiFinished = false;
  bool loadingFinished = false;
  String? destinationImage;
  Destination? destinationInfo;
  Weather? weatherInfo;

  final List<String> loadingSteps = [
    "Scanning Pakistan's Hidden Gems...",
    "Checking Local Weather & Seasons...",
    "Curating Day-by-Day Activities...",
    "Calculating Budget Breakdown...",
    "Adding Insider Travel Tips...",
    "Finalising your Dream Itinerary..."
  ];

  final List<String> didYouKnow = [
    "Pakistan has K2, the world's 2nd highest mountain ✨",
    "Hunza is famous for its breathtaking mountain scenery 🏔️",
    "Pakistan has diverse landscapes from beaches to glaciers 🌄",
    "Skardu is surrounded by some of Pakistan's highest peaks 🏔️",
  ];

  int factIndex = 0;

  Future<void> _generateItinerary() async {
    try {

      final location = await LocationService.getDestination(widget.destination);

      print('DESTINATION: ${widget.destination}');
print('LOCATION RESULT: $location');
print('PROVINCE: ${location?.province}');

        if(location != null) {
        final weather = await WeatherService.getWeather(longitude: location.longitude, latitude: location.latitude);

        weatherInfo = weather;
        print('WEATHER: $weatherInfo');
      }

      if(!mounted) return;

      setState(() {
        destinationInfo = location;
      });

 

    
      final result = await GeminiService.generateItinerary(
        destination: widget.destination, 
        budget: widget.budget, 
        days: widget.days, 
        travellers: widget.travellers, 
        interests: widget.interests, 
        travelStyle: widget.travelStyle,
        );

        print('GEMINI GENERATION SUCCESSFUL');
print('ABOUT TO INCREMENT TRIPS CREATED');

        await SavedTripService.incrementTripsCreated();
print('TRIPS CREATED INCREMENT FINISHED');


        destinationImage = await ImageService.getDestinationImage(widget.destination);

        
        if(!mounted) return;
        
        setState(() {
          generatedItinerary = result;
          geminiFinished = true;
        });

        _checkIfReadyToNavigate();
    }  catch (e) {
  debugPrint('Gemini Error: $e');

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Unable to generate itinerary: $e',
      ),
    ),
  );
}
  }

  Future<void> _checkIfReadyToNavigate() async {
    if(geminiFinished && loadingFinished && generatedItinerary != null) {
      final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => GeneratedItineraryScreen(
      destination: widget.destination, 
      budget: widget.budget, 
      days: widget.days, 
      travellers: widget.travellers, 
      interests: widget.interests, 
      travelStyle: widget.travelStyle, 
      itinerary: generatedItinerary!,
      imageUrl: destinationImage,
      province: destinationInfo?.province ?? 'Pakistan',
      weather: weatherInfo,
      ),
    ),
  );

  if(result == true && mounted) {
    Navigator.pop(context, true);
  }
    }
  }

  @override
  void initState() {
    super.initState();
    //LocationService.testLocation();
    _generateItinerary();

    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if(!mounted) {
          timer.cancel();
          return;
        }


        if(currentStep < loadingSteps.length-1) {
          setState(() {
            currentStep++;
          });
        }
        else {
          timer.cancel();
          setState(() {
           loadingFinished = true;
          });

          _checkIfReadyToNavigate(); 
        }
      },
    );

    factTimer = Timer.periodic(
      const Duration(seconds: 5),
      (factTimer) {
        if(!mounted) {
          factTimer.cancel();
          return;
        }
        setState(() {
          factIndex = (factIndex+1) % didYouKnow.length;
        });
      }, 
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    factTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071226),
      body: SafeArea(child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 60),

            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1455C3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E6AE1).withOpacity(0.45),
                    blurRadius: 30,
                    spreadRadius: 8,
                  ),
                ],
              ),

              child: const Center(
                child: Icon(
                  Icons.flight,
                  color: Colors.white,
                  size: 58,
                ),
              ),
            ),

            const SizedBox(height: 65),

            Text(
              'Creating Your Dream Trip',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'To ${widget.destination}',
              style: const TextStyle(
                color: Color(0xFF3D9CFF),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 45),

            Column(
              children: List.generate(
                loadingSteps.length, 
                (index) {
                  final bool completed = index < currentStep;
                  final bool active = index == currentStep;
                  final bool upcoming = index > currentStep;

                  return Padding(padding: const EdgeInsetsGeometry.only(bottom: 17),
                  child: Row(
                    children: [
                      AnimatedContainer(duration: const Duration(milliseconds: 300),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: completed? const Color(0xFF3D9CFF) : active? const Color(0xFF164C9C) : const Color(0xFF101D34),  
                         ),

                         child: completed? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                         )
                         : active? const Center(
                          child: SizedBox(
                            height: 9,
                            width: 9,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF3D9CFF),
                            ),
                          ),
                         )
                         : null,
                         ),
                         Expanded(child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: upcoming? 0.25 : 1.0,
                          child: Text(
                            loadingSteps[index],
                            style: TextStyle(
                              color: completed || active ? Colors.white : const Color(0xFF536078),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ),
                          ),
                    ],
                  ),
                  );
                }
                ),
            ),

            const Spacer(),

            AnimatedSwitcher(duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(factIndex),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFF151F32),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF29364D),
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DID YOU KNOW',
                    style: TextStyle(
                      color: Color(0xFF3D9CFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    didYouKnow[factIndex],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            ),

            const SizedBox(height: 25),


          ],
        ),
        ),
        ),
    );
  }

 
  }