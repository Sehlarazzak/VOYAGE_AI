import 'package:dio/dio.dart';
import 'package:first_project/models/destination.dart';

class LocationService {
  static final Dio _dio = Dio();

static Future<Destination?> getDestination(
  String destinationName,
) async {
  try {
    final searchName = destinationName.trim();

    final response = await _dio.get(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: {
        'q': '$searchName, Pakistan',
        'format': 'jsonv2',
        'addressdetails': '1',
        'limit': '1',
        'accept-language': 'en',
        'countrycodes': 'pk',
      },
      options: Options(
        headers: {
          'User-Agent': 'PakistanTravelPlanner/1.0',
        },
      ),
    );

    print('NOMINATIM STATUS: ${response.statusCode}');
    print('NOMINATIM DATA: ${response.data}');

    if (response.statusCode != 200) {
      print('Nominatim request failed');
      return null;
    }

    final List data = response.data;

    if (data.isEmpty) {
      print('No result for: $searchName');
      return null;
    }

    final result = data[0];

    final address =
        Map<String, dynamic>.from(result['address'] ?? {});

    print('NOMINATIM ADDRESS: $address');

    String province = 'Pakistan';

    if (address['state'] != null) {
      province = '${address['state']}, Pakistan';
    } else if (address['region'] != null) {
      province = '${address['region']}, Pakistan';
    } else if (address['state_district'] != null) {
      province = '${address['state_district']}, Pakistan';
    }

    return Destination(
      name: searchName,
      province: province,
      latitude: double.parse(result['lat']),
      longitude: double.parse(result['lon']),
      imageUrl: null,
    );
  } catch (e) {
    print('LOCATION ERROR: $e');
    return null;
  }
}
}
  
   