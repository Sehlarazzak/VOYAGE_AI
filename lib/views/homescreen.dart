import 'package:first_project/widgets/custom_tripcard.dart';
import 'package:flutter/material.dart';
import 'package:first_project/widgets/custom_destinationbuttons.dart';
import 'package:first_project/views/plantripscreen.dart';
import 'package:first_project/viewmodels/saved_trip_service.dart';
import 'package:first_project/models/itinerary.dart';
import 'package:first_project/views/generated_itinerary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> savedTrips = [];
  bool isLoadingTrips = true;
  int tripsCreated = 0;
  int savedTripsCount = 0;
  int provincesCount = 0;

  @override
  void initState() {
    super.initState();
    loadSavedTrips();
    loadTripStats();
    loadTripsCreated();
  }

  @override
void didChangeDependencies() {
  super.didChangeDependencies();

  loadTripsCreated();
  loadTripStats();
}

  Future<void> loadTripsCreated() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;

      if(user == null) return;

      final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

      final data = snapshot.data();


    print('HOME USER: ${user.uid}');
    print('HOME FIRESTORE DATA: $data');
    print('TRIPS CREATED FROM FIRESTORE: ${data?['tripsCreated']}');

      if(!mounted) return;

      setState(() {
        tripsCreated = data?['tripsCreated'] ?? 0;
      });
    } catch(e) {
      print('ERROR LOADING TRIPS CREATED: $e');
    }
  }

  Future<void> loadTripStats() async {
    try {
      final trips = await SavedTripService.getSavedTrips();

      final uniqueProvinces = <String> {};

      for(final trip in trips) {
        final province = trip['province'];

        if(province != null && province.toString().trim().isNotEmpty) {
          uniqueProvinces.add(
            province.toString().trim(),
          );
        }
      }

      if(!mounted) return;

      setState(() {
        savedTripsCount = trips.length;
        provincesCount = uniqueProvinces.length;
      });
    } catch(e) {
      print('ERROR LOADING TRIP STATS: $e');
    }
  }

  Future<void> openSvedTrip(
    BuildContext context,
    Map<String, dynamic> trip,
  ) async {
    try {
      final itineraryData = Map<String, dynamic>.from(trip['itinerary']);

      final itinerary = Itinerary.fromJson(itineraryData);

      if(!context.mounted) return;

      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => GeneratedItineraryScreen(
        destination: trip['destination'] ?? '', 
        budget: trip['budget'] ?? 0, 
        days: trip['days'] ?? 0, 
        travellers: trip['travellers'] ?? 0, 
        interests: List.from(trip['interests'] ?? []), 
        travelStyle: trip['travelStyle'] ?? 0, 
        itinerary: itinerary,
        province: trip['province'] ?? ''),
        ),
        );
    } catch (e) {
      print('ERROR OPENING SAVED TRIP: $e');
      if(!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to open Sved Trip: $e'),
        ),
      );
    }
  }

  Future<void> loadSavedTrips() async {
    try {
      final trips = await SavedTripService.getSavedTrips();

      if(!mounted) return;

      setState(() {
        savedTrips = trips;
        isLoadingTrips = false;
      });
    } catch(e) {
      print('ERROR LOADING SAVED TRIPS: $e');

      if(!mounted) return;

      setState(() {
        isLoadingTrips = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 340,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 380,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E6AE1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Welcome Back',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                    ),
                                    ),
                                    SizedBox(height: 4),
                
                                    Text('Traveller',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                            ),
                                  ],
                                ),
                                      
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white24,
                                  child: Icon(Icons.person_outline,
                                  color: Colors.white,),
                                ),  
                              ],
                            ),
                
                            const SizedBox(height: 50),
                                      
                            
                                      
                            Row(
                            children: [
                              Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                Text(
                  tripsCreated.toString(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "TRIPS CREATED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                
                    const SizedBox(width: 12),
                
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                Text(
                  savedTripsCount.toString(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "SAVED TRIPS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                
                    const SizedBox(width: 12),
                
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                Text(
                  provincesCount.toString(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "PROVINCES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                
                  ],
                ),
                  ],),
                      ),
                    ),
                
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: -50,
                      child: GestureDetector(
                        onTap: () async {
                           await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Plantripscreen(),),);
                      await loadTripsCreated();
                      await loadTripStats();
                      await loadSavedTrips();
                        },
                
                        child: Container(
                          height: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                
                          child: Row(
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 15),
                
                              const Expanded(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Where do you want to go?',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F1C35),
                                    ),
                                    ),
                
                                    SizedBox(height: 6),
                
                                    Text(
                                      'Search destinations in Pakistan',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280)
                                      ),
                                    ),
                                ],
                              ),
                              ),
                
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E6AE1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                  ],
                ),
              ),
                   

              const SizedBox(height: 80),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('POPULAR IN PAKISTAN',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                                  
                    SizedBox(height: 20),
                                  
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                                  
                          CustomDestinationbuttons(title: 'Hunza', onTap: () {}),
                                  
                          CustomDestinationbuttons(title: 'Lahore', onTap: () {}),
                                  
                          CustomDestinationbuttons(title: 'Skardu', onTap: () {}),
                                  
                          CustomDestinationbuttons(title: 'Murree', onTap: () {}),
                                  
                          CustomDestinationbuttons(title: 'Swat Valley', onTap: () {}),
                                  
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                                  
                    const SizedBox(height: 25),
                                  
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Plantripscreen(),),);
                      await loadTripsCreated();
                      await loadTripStats();
                      await loadSavedTrips();
                      },
                                  
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                                  
                        decoration: BoxDecoration(
                          color: Color(0xFFF59E0B),
                          borderRadius: BorderRadius.circular(22),
                        ),
                                  
                        child: const Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 28,
                            ),
                                  
                            SizedBox(width: 15),
                                  
                            Expanded(
                              child: Text(
                                'Plan New Trip With AI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                                  
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                                  
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recent Trips Planned',
                          style: TextStyle(
                            color: Color(0xFF0F1C35),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ), 

                    if(isLoadingTrips)
                    const Padding(padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                    )

                    else if(savedTrips.isEmpty)
                    const Padding(padding: EdgeInsets.all(20),
                    child: Text('No Saved Trips yet.',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
        fontSize: 16,
                    ),
                    ),
                    )

                    else
                    ...savedTrips.map((trip) {
                      return CustomTripcard(
                        imagePath: trip['imageUrl'] ?? 'assets/images/lahore.jpg', 
                        destination: trip['destination'] ?? 'Unknown',
                        onTap : () {
                          openSvedTrip(context, trip);
                        }, 
                        difficulty: trip['travelStyle'] ?? 'Comfort', 
                        people: '${trip['travellers'] ?? 0}', 
                        duration: '${trip['days'] ?? 0}d', 
                        plannedDate: 'Saved Trip', 
                        );

                    }),


                     
              ], ), ), ), );
  }
}