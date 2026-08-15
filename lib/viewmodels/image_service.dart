import 'package:dio/dio.dart';

class ImageService {
  static final Dio _dio = Dio();

  static const String accessKey = 'ACCESS_KEY';

  static Future<String?> getDestinationImage (
    String destination,
  ) async {
    try {
      final response = await _dio.get(
        'https://api.unsplash.com/search/photos',
        queryParameters: {
          'query' : '$destination Pakistan',
          'per_page' : 1,
          'orientation' : 'landscape',
        },

        options: Options(
          headers: {
            'Authorization': 'Client-ID $accessKey',
          },
        ),
      );
      if(response.statusCode != 200){
        return null;
      }

      final results = response.data['results'];

      if(results == null || results.isEmpty) {
        return null;
      }

      return results[0]['urls']['regular'];
    }
    catch(e) {
      print('Image Error: $e');
      return null;
    }
  }
}