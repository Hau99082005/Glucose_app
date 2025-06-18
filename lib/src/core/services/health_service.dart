import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HealthService {
  static final HealthService _instance = HealthService._internal();
  factory HealthService() => _instance;
  HealthService._internal() {
    _health = Health();
  }

  late final Health _health;

  // Health data types
  static const bloodGlucoseType = HealthDataType.BLOOD_GLUCOSE;
  static const bloodPressureTypeSystolic =
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC;
  static const bloodPressureTypeDiastolic =
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC;
  static const weightType = HealthDataType.WEIGHT;
  static const heartRateType = HealthDataType.HEART_RATE;

  // Check if health is available on the device
  Future<bool> isHealthAvailable() async {
    try {
      await _health.configure();
      return true;
    } catch (e) {
      debugPrint('Error checking health availability: $e');
      return false;
    }
  }

  // Open health settings
  Future<void> openHealthSettings() async {
    try {
      await launchUrl(Uri.parse('x-apple-health://'));
    } catch (e) {
      debugPrint('Error opening health settings: $e');
    }
  }

  // Check if health data type is available
  Future<bool> isDataTypeAvailable(HealthDataType dataType) async {
    try {
      return _health.isDataTypeAvailable(dataType);
    } catch (e) {
      debugPrint('Error checking data type availability: $e');
      return false;
    }
  }

  // Request authorization for data types
  Future<bool> requestAuthorization(List<HealthDataType> types) async {
    try {
      final permissions =
          types.map((type) => HealthDataAccess.READ_WRITE).toList();
      return await _health.requestAuthorization(types,
          permissions: permissions);
    } catch (e) {
      debugPrint('Error requesting authorization: $e');
      return false;
    }
  }

  // Read health data
  Future<List<HealthDataPoint>> readHealthData(
    HealthDataType dataType,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: [dataType],
        startTime: startDate,
        endTime: endDate,
      );
      return healthData;
    } catch (e) {
      debugPrint('Error reading health data: $e');
      return [];
    }
  }

  Future<bool> writeHealthData(
    HealthDataType dataType,
    double value,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      return await _health.writeHealthData(
        value: value,
        type: dataType,
        startTime: startTime,
        endTime: endTime,
        unit: _getDefaultUnit(dataType),
      );
    } catch (e) {
      debugPrint('Error writing health data: $e');
      return false;
    }
  }

  // Write blood pressure data
  Future<bool> writeBloodPressure(
    double systolic,
    double diastolic, {
    DateTime? date,
  }) async {
    try {
      final now = date ?? DateTime.now();

      final systolicSuccess = await _health.writeHealthData(
        value: systolic,
        type: HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        startTime: now,
        endTime: now,
        unit: HealthDataUnit.MILLIMETER_OF_MERCURY,
      );

      final diastolicSuccess = await _health.writeHealthData(
        value: diastolic,
        type: HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        startTime: now,
        endTime: now,
        unit: HealthDataUnit.MILLIMETER_OF_MERCURY,
      );

      return systolicSuccess && diastolicSuccess;
    } catch (e) {
      debugPrint('Error writing blood pressure: $e');
      return false;
    }
  }

  HealthDataUnit _getDefaultUnit(HealthDataType type) {
    switch (type) {
      case HealthDataType.BLOOD_GLUCOSE:
        return HealthDataUnit.MILLIGRAM_PER_DECILITER;
      case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
      case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
        return HealthDataUnit.MILLIMETER_OF_MERCURY;
      case HealthDataType.WEIGHT:
        return HealthDataUnit.KILOGRAM;
      default:
        throw ArgumentError('No default unit defined for type: $type');
    }
  }

  // Check if permissions are granted
  Future<bool> hasPermissions(
      List<HealthDataType> types, List<HealthDataAccess> permissions) async {
    try {
      final hasPermissions =
          await _health.hasPermissions(types, permissions: permissions);
      return hasPermissions ?? false;
    } catch (e) {
      debugPrint('Error checking permissions: $e');
      return false;
    }
  }

  Future<void> syncHealthData(BuildContext context) async {
    try {
      final now = DateTime.now();
      final startDate = now.subtract(const Duration(days: 90)); // Last 90 days

      // Read blood glucose data
      final glucoseData = await _health.getHealthDataFromTypes(
        types: [bloodGlucoseType],
        startTime: startDate,
        endTime: now,
      );

      // Read blood pressure data
      final systolicData = await _health.getHealthDataFromTypes(
        types: [bloodPressureTypeSystolic],
        startTime: startDate,
        endTime: now,
      );
      final diastolicData = await _health.getHealthDataFromTypes(
        types: [bloodPressureTypeDiastolic],
        startTime: startDate,
        endTime: now,
      );
      final heartRateData = await _health.getHealthDataFromTypes(
        types: [heartRateType],
        startTime: startDate,
        endTime: now,
      );

      // Read weight data
      final weightData = await _health.getHealthDataFromTypes(
        types: [weightType],
        startTime: startDate,
        endTime: now,
      );

      // Process and create health records
      final provider =
          Provider.of<HealthRecordProvider>(context, listen: false);
      int importedCount = 0;

      // Process glucose data
      for (HealthDataPoint data in glucoseData) {
        if (data.value is NumericHealthValue) {
          try {
            final record = HealthRecord.glucose(
              id: DateTime.now().millisecondsSinceEpoch + importedCount,
              glucose:
                  (data.value as NumericHealthValue).numericValue as double,
              date: data.dateFrom,
              note: 'Imported from HealthKit',
            );
            await provider.addRecord(record);
            importedCount++;
          } catch (e) {
            debugPrint('Error adding glucose record: $e');
          }
        }
      }

      // Process blood pressure data
      for (var i = 0; i < systolicData.length; i++) {
        if (i < diastolicData.length &&
            systolicData[i].value is NumericHealthValue &&
            diastolicData[i].value is NumericHealthValue) {
          try {
            // Find matching heart rate if available
            double? heartRate;
            if (i < heartRateData.length &&
                heartRateData[i].value is NumericHealthValue) {
              heartRate = (heartRateData[i].value as NumericHealthValue)
                  .numericValue as double;
            }

            final record = HealthRecord.bloodPressure(
              id: DateTime.now().millisecondsSinceEpoch + importedCount,
              systolic: (systolicData[i].value as NumericHealthValue)
                  .numericValue as double,
              diastolic: (diastolicData[i].value as NumericHealthValue)
                  .numericValue as double,
              heartRate: heartRate ?? 0,
              date: systolicData[i].dateFrom,
              note: 'Imported from HealthKit',
            );
            await provider.addRecord(record);
            importedCount++;
          } catch (e) {
            debugPrint('Error adding blood pressure record: $e');
          }
        }
      }

      // Process weight data
      for (var data in weightData) {
        if (data.value is NumericHealthValue) {
          try {
            final record = HealthRecord.weight(
              id: DateTime.now().millisecondsSinceEpoch + importedCount,
              weight: (data.value as NumericHealthValue).numericValue as double,
              date: data.dateFrom,
              note: 'Imported from HealthKit',
            );
            await provider.addRecord(record);
            importedCount++;
          } catch (e) {
            debugPrint('Error adding weight record: $e');
          }
        }
      }

      // Reload records in the provider
      await provider.loadAllRecords();

      // Show success message
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Success'),
            content:
                Text('Successfully imported $importedCount health records.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate back to history page
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint('Error syncing health data: $e');
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text('Failed to import health data: ${e.toString()}'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }
}
