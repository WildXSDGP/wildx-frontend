import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/national_park_model.dart';

class NationalParkService {
  static const String baseUrl = 'http://10.0.2.2:8080'; // Android Emulator
  // static const String baseUrl = 'http://localhost:8080'; // iOS Simulator
  // static const String baseUrl = 'http://192.168.1.x:8080'; // Real Device

  Future<List<NationalPark>> searchParkByAnumal(String animal) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/parks/search?animal=${Uri.encodeComponent(animal)}',
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<NationalPark> parks = data
            .map((park) => NationalPark.fromJson(park))
            .toList();
        return parks;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load Parks');
      }
    } catch (e) {
      throw Exception('ErrorL $e');
    }
  }
}
