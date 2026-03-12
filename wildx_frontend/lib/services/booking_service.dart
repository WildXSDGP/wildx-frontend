import 'dart:developer' as developer;

import '../models/booking.dart';

class BookingService {
  /// Simulates submitting a booking to a remote API.
  /// Returns the same [Booking] on success (with a generated ID if needed).
  Future<Booking> submitBooking(Booking booking) async {
    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));

    developer.log(
      '── Booking Submitted ──────────────────────',
      name: 'BookingService',
    );
    developer.log('Booking ID      : ${booking.bookingId}', name: 'BookingService');
    developer.log('Accommodation ID: ${booking.accommodationId}', name: 'BookingService');
    developer.log('Check-in        : ${booking.checkInDate.toIso8601String()}', name: 'BookingService');
    developer.log('Check-out       : ${booking.checkOutDate.toIso8601String()}', name: 'BookingService');
    developer.log('Nights          : ${booking.nights}', name: 'BookingService');
    developer.log('Guests          : ${booking.guests}', name: 'BookingService');
    developer.log('Total Price     : LKR ${booking.totalPrice.toStringAsFixed(2)}', name: 'BookingService');
    developer.log('JSON payload    : ${booking.toJson()}', name: 'BookingService');
    developer.log('───────────────────────────────────────────', name: 'BookingService');

    return booking;
  }

  /// Simulates fetching bookings for the current user.
  Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(seconds: 1));
    // Placeholder – return empty list until backend is ready
    return [];
  }

  /// Simulates cancelling a booking by ID.
  Future<bool> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(seconds: 1));

    developer.log(
      'Booking cancelled: $bookingId',
      name: 'BookingService',
    );

    return true;
  }
}
