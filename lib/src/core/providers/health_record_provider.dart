import 'package:flutter/foundation.dart';
import '../entities/health_record.dart';
import '../database/database_helper.dart';

class HealthRecordProvider extends ChangeNotifier {
  final DatabaseHelper _repository = DatabaseHelper.instance;
  List<HealthRecord> _records = [];

  List<HealthRecord> get records => _records;

  HealthRecordProvider() {
    initializeDefaultTags();
    loadAllRecords();
  }

  Future<void> loadAllRecords() async {
    _records = await _repository.getAllRecords();
    notifyListeners();
  }

  bool _isDuplicateRecord(HealthRecord newRecord) {
    return _records.any((existingRecord) {
      // Compare by type first
      if (newRecord.runtimeType != existingRecord.runtimeType) {
        return false;
      }

      // Compare by date (within 1 minute to account for slight timing differences)
      final newDate = newRecord.date ?? DateTime.now();
      final existingDate = existingRecord.date ?? DateTime.now();
      final timeDiff = newDate.difference(existingDate).inMinutes.abs();
      if (timeDiff > 1) {
        return false;
      }

      // Compare by value based on record type
      return newRecord.when(
        glucose: (id, glucose, tags, date, note) {
          return existingRecord.maybeWhen(
            glucose: (_, existingGlucose, __, ___, ____) =>
                (glucose - existingGlucose).abs() <
                0.1, // Allow 0.1 mg/dL difference
            orElse: () => false,
          );
        },
        weight: (id, weight, tags, date, note) {
          return existingRecord.maybeWhen(
            weight: (_, existingWeight, __, ___, ____) =>
                (weight - existingWeight).abs() <
                0.1, // Allow 0.1 kg difference
            orElse: () => false,
          );
        },
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) {
          return existingRecord.maybeWhen(
            bloodPressure: (_, existingSystolic, existingDiastolic,
                    existingHeartRate, __, ___, ____) =>
                (systolic - existingSystolic).abs() <
                    1 && // Allow 1 mmHg difference
                (diastolic - existingDiastolic).abs() < 1,
            orElse: () => false,
          );
        },
        insulin: (id, units, insulinName, tags, date, note) {
          return existingRecord.maybeWhen(
            insulin: (_, existingUnits, existingInsulinName, __, ___, ____) =>
                units == existingUnits && insulinName == existingInsulinName,
            orElse: () => false,
          );
        },
        medication: (id, medicationName, medicationTime, tags, date, note) {
          return existingRecord.maybeWhen(
            medication: (_, existingMedicationName, existingMedicationTime, __,
                    ___, ____) =>
                medicationName == existingMedicationName &&
                medicationTime == existingMedicationTime,
            orElse: () => false,
          );
        },
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) {
          return existingRecord.maybeWhen(
            carbs: (_, existingCarbs, existingFood, existingFat,
                    existingProtein, __, ___, ____) =>
                carbohydrates == existingCarbs &&
                food == existingFood &&
                (fat - existingFat).abs() < 0.1 &&
                (protein - existingProtein).abs() < 0.1,
            orElse: () => false,
          );
        },
        temperature: (id, temperature, tags, date, note) {
          return existingRecord.maybeWhen(
            temperature: (_, existingTemp, __, ___, ____) =>
                (temperature - existingTemp).abs() <
                0.1, // Allow 0.1°C difference
            orElse: () => false,
          );
        },
        a1c: (id, a1c, tags, date, note) {
          return existingRecord.maybeWhen(
            a1c: (_, existingA1c, __, ___, ____) =>
                (a1c - existingA1c).abs() < 0.1, // Allow 0.1% difference
            orElse: () => false,
          );
        },
        exercise: (id, exerciseType, duration, tags, date, note) {
          return existingRecord.maybeWhen(
            exercise: (_, existingType, existingDuration, __, ___, ____) =>
                exerciseType == existingType &&
                duration.inMinutes == existingDuration.inMinutes,
            orElse: () => false,
          );
        },
        oxygen: (id, oxygen, heartRate, tags, date, note) {
          return existingRecord.maybeWhen(
            oxygen: (_, existingOxygen, existingHeartRate, __, ___, ____) =>
                (oxygen - existingOxygen).abs() <
                    0.1 && // Allow 0.1% difference
                heartRate == existingHeartRate,
            orElse: () => false,
          );
        },
        note: (id, tags, date, note) {
          return existingRecord.maybeWhen(
            note: (_, existingTags, ___, existingNote) => note == existingNote,
            orElse: () => false,
          );
        },
        ketones: (id, ketones, tags, date, note) {
          return existingRecord.maybeWhen(
            ketones: (_, existingKetones, __, ___, ____) =>
                (ketones - existingKetones).abs() <
                0.1, // Allow 0.1 mmol/L difference
            orElse: () => false,
          );
        },
      );
    });
  }

  Future<void> addRecord(HealthRecord record) async {
    if (!_isDuplicateRecord(record)) {
      await _repository.insertRecord(record);
      await loadAllRecords();
    }
  }

  Future<void> updateRecord(HealthRecord record) async {
    await _repository.updateRecord(record);
    await loadAllRecords();
  }

  Future<void> close() async {
    await _repository.close();
  }

  Future<void> initializeDefaultTags() async {
    final db = DatabaseHelper.instance;
    final areInitialized = await db.areDefaultTagsInitialized();

    if (!areInitialized) {
      final defaultTags = [
        'Fasting/Wake Up',
        'Before Breakfast',
        'After Breakfast',
        'After Lunch',
        'Before Dinner',
        'After Dinner',
        'Before Bed',
        'Before Exercise',
        'After Exercise',
        'Before Snack',
        'After Snack',
        'Abnormal',
        'Other',
        'One Hour After Meal',
        'Two Hours After Meal',
        'Fasting',
        'Breakfast',
        'Lunch',
        'Dinner',
        'Snack',
      ];

      for (final tag in defaultTags) {
        await db.addTag(tag);
      }
      await db.markDefaultTagsAsInitialized();
    }
  }

  Future<List<String>> getAllTags() async {
    final db = DatabaseHelper.instance;
    // Get standalone tags
    final standaloneTags = await db.getAllStandaloneTags();

    // Get unique tags from records
    final recordTags = records.expand((record) => record.tags).toSet().toList();

    // Combine and sort all tags
    final allTags = {...standaloneTags, ...recordTags}.toList()..sort();
    return allTags;
  }

  Future<void> deleteTag(String tag) async {
    final db = DatabaseHelper.instance;
    await db.deleteTag(tag);
    await loadAllRecords(); // Reload records to update the UI
  }

  Future<void> addTag(String tag) async {
    final db = DatabaseHelper.instance;
    await db.addTag(tag);
    await loadAllRecords(); // Reload records to update the UI
  }

  int getRecordsCountForTag(String tag) {
    return _records.where((record) => record.tags.contains(tag)).length;
  }
}
