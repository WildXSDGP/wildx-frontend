import 'api_service.dart';

class BookingService {
  // create booking
  static Future<Map<String, dynamic>> createBooking({
    required String accommodationId,
    required String checkInDate,
    required String checkOutDate,
    required int guests,
  }) async {
    final response = await ApiService.post('/bookings', {
      'accommodationId': accommodationId,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'guests': guests,
    });
    return response;
  }

  // ALL bookings get
  static Future<List<dynamic>> getMyBookings() async {
    final response = await ApiService.get('/bookings/my-bookings');
    if (response['success'] == true) {
      return response['data'];
    }
    return [];
  }

  // Booking cancel
  static Future<Map<String, dynamic>> cancelBooking(String bookingId) async {
    final response = await ApiService.delete('/bookings/$bookingId');
    return response;
  }

  // Booking get with  ID
  static Future<Map<String, dynamic>?> getBookingById(String bookingId) async {
    final response = await ApiService.get('/bookings/$bookingId');
    if (response['success'] == true) {
      return response['data'];
    }
    return null;
  }
}
