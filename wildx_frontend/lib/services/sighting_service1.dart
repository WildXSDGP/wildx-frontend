import '../models/sighting_report1.dart';
import '../models/animal_type1.dart';
import '../models/location_info1.dart';

class SightingService {
  final List<SightingReport> _reports = [];

  List<SightingReport> get allReports => List.unmodifiable(_reports);

  Future<SightingReport> submitReport({
    required AnimalType animalType,
    String? photoPath,
    required LocationInfo location,
    String? notes,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final report = SightingReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      animalType: animalType,
      photoPath: photoPath,
      location: location,
      notes: notes?.trim().isEmpty == true ? null : notes,
      reportedAt: DateTime.now(),
      status: ReportStatus.submitted,
    );

    _reports.add(report);
    return report;
  }

  void clearAll() => _reports.clear();
}

// Global singleton for simplicity; use Provider/Riverpod in larger apps.
final sightingService = SightingService();