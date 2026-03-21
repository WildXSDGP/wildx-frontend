import 'api_service.dart';

class AccommodationService {
  // all accommodations
  static Future<List<dynamic>> getAccommodations() async {
    final response = await ApiService.get('/accommodations');
    if (response['success'] == true) {
      return response['data']['accommodations'];
    }
    return [];
  }

  // accommodation get ID
  static Future<Map<String, dynamic>?> getAccommodationById(String id) async {
    final response = await ApiService.get('/accommodations/$id');
    if (response['success'] == true) {
      return response['data']['accommodation'];
    }
    return null;
  }

  // Search
  static Future<List<dynamic>> searchAccommodations({
    String? location,
    String? type,
    double? minPrice,
    double? maxPrice,
  }) async {
    String query = '?';
    if (location != null) query += 'location=$location&';
    if (type != null) query += 'type=$type&';
    if (minPrice != null) query += 'minPrice=$minPrice&';
    if (maxPrice != null) query += 'maxPrice=$maxPrice&';

    final response = await ApiService.get('/accommodations$query');
    if (response['success'] == true) {
      return response['data']['accommodations'];
    }
    return [];
  }
}
