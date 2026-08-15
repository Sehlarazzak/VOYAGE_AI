import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/itinerary.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedTripService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> saveTrip({
    required String destination,
    required String province,
    required String budget,
    required int days,
    required int travellers,
    required List interests,
    required String travelStyle,
    required String? imageUrl,
    required Itinerary itinerary,
}) async {

  final user = FirebaseAuth.instance.currentUser;

  if(user == null) {
    throw Exception('User is not logged in');
  }

  
  await _firestore
  .collection('users')
  .doc(user.uid)
  .collection('savedTrips')
  .add({
    'destination' : destination,
    'province' : province,
    'budget' : budget,
    'days': days,
    'travellers' : travellers,
    'interests' : interests,
    'travelStyle': travelStyle,
    'imageUrl': imageUrl,
    'itinerary': {
      'days': itinerary.days.map((day) {
        return{
          'dayNumber': day.dayNumber,
          'title' : day.title,

          'morning': {
            'time': day.morningTime,
            'activity': day.morningActivity,
            'food' : day.morningFood,
          },

          'afternoon' : {
            'time' : day.afternoonTime,
            'activity' : day.afternoonActivity,
            'food' : day.afternoonFood,
          },

          'evening' : {
            'time' : day.eveningTime,
            'activity' : day.eveningActivity,
            'food' : day.eveningFood,
          },

          'estimatedCost' : {
            'transport' : day.transportCost,
            'food' : day.foodCost,
            'activities' : day.activitiesCost,
            'accommodation' : day.accommodationCost,
            'shopping' : day.shoppingCost,
            'total': day.totalCost,
          },
        };
      }).toList(),

      'travelTips' : itinerary.travelTips,
      'transportTips' : itinerary.transportTips,
      'safetyTips' : itinerary.safetyTips,
      'insiderTips' : itinerary.insiderTips,
    },

    'createdAt' : FieldValue.serverTimestamp(),
      });
}

static Future<List<Map<String, dynamic>>> getSavedTrips() async {
  final user = FirebaseAuth.instance.currentUser;

  if(user == null) {
    throw Exception('User is not logged in');
  }


  final snapshot = await _firestore
  .collection('users')
  .doc(user.uid)
  .collection('savedTrips')
  .orderBy('createdAt', descending: true)
  .get();

  return snapshot.docs.map((doc) {
    return {
      'id' : doc.id,
      ...doc.data(),
    };
  }).toList();
}

static Future<Map<String, dynamic>?> getSavedTrip(String tripId) async {
  final user = FirebaseAuth.instance.currentUser;

  if(user == null) {
    throw Exception('User is not logged in');
  }

  final doc = await _firestore
  .collection('users')
  .doc(user.uid)
  .collection('savedTrips')
  .doc(tripId)
  .get();

  if(!doc.exists) {
    return null;
  }

  return {
    'id' : doc.id,
    ...doc.data()!,
  };
}
static Future<void> incrementTripsCreated() async {
  final user = await FirebaseAuth.instance.currentUser;

  print('CURRENT USER: ${user?.uid}');

  if(user == null) {
    throw Exception('User is not logged in');
  }

  print('INCREMENTING TRIPS CREATED...');

 try{
  await _firestore
  .collection('users')
  .doc(user.uid)
  .set({
    'tripsCreated': FieldValue.increment(1),
  },
  SetOptions(merge: true),
  );

  print('TRIPS CREATED SUCCESSFULLY INCREMENTED');
} catch(e) {
  print('TRIPS CREATED ERROR: $e');
  rethrow;

}

}
}
