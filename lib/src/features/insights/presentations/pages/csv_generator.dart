import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CSVGenerator {
  static Future<File> generateCSV({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> selectedLogTypes,
  }) async {
    final healthRecordProvider =
        Provider.of<HealthRecordProvider>(context, listen: false);
    final records = healthRecordProvider.records.where((record) {
      final recordType = record.when(
        glucose: (id, glucose, tags, date, note) => 'Glucose',
        weight: (id, weight, tags, date, note) => 'Weight',
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
            'Blood Pressure',
        insulin: (id, units, insulinName, tags, date, note) => 'Insulin',
        medication: (id, medicationName, medicationTime, tags, date, note) =>
            'Medication',
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
            'Carbs',
        temperature: (id, temperature, tags, date, note) => 'Temperature',
        a1c: (id, a1c, tags, date, note) => 'A1C',
        exercise: (id, exerciseType, duration, tags, date, note) => 'Exercise',
        oxygen: (id, oxygen, heartRate, tags, date, note) => 'Oxygen',
        note: (id, tags, date, note) => 'Note',
        ketones: (id, ketones, tags, date, note) => 'Ketones',
      );
      return selectedLogTypes.contains(recordType);
    }).where((record) {
      final date = record.when(
        glucose: (id, glucose, tags, date, note) => date,
        weight: (id, weight, tags, date, note) => date,
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
            date,
        insulin: (id, units, insulinName, tags, date, note) => date,
        medication: (id, medicationName, medicationTime, tags, date, note) =>
            date,
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
            date,
        temperature: (id, temperature, tags, date, note) => date,
        a1c: (id, a1c, tags, date, note) => date,
        exercise: (id, exerciseType, duration, tags, date, note) => date,
        oxygen: (id, oxygen, heartRate, tags, date, note) => date,
        note: (id, tags, date, note) => date,
        ketones: (id, ketones, tags, date, note) => date,
      );
      return date != null && date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();

    // Create CSV content
    final csvContent = StringBuffer();

    // Add header
    csvContent.writeln('Type,Date,Time,Value,Value,Note,Tags');

    // Add records
    for (final record in records) {
      record.when(
        glucose: (id, glucose, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Glucose,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$glucose,0,${note ?? ''},${tags.join(',')}');
          }
        },
        weight: (id, weight, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Weight,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$weight,0,${note ?? ''},${tags.join(',')}');
          }
        },
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Blood Pressure,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$systolic,$diastolic,${note ?? ''},${tags.join(',')}');
          }
        },
        insulin: (id, units, insulinName, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Insulin,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$units,0,${note ?? ''},${tags.join(',')}');
          }
        },
        medication: (id, medicationName, medicationTime, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Medication,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},0,0,${note ?? ''},${tags.join(',')}');
          }
        },
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Carbs,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$carbohydrates,0,${note ?? ''},${tags.join(',')}');
          }
        },
        temperature: (id, temperature, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Temperature,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$temperature,0,${note ?? ''},${tags.join(',')}');
          }
        },
        a1c: (id, a1c, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'A1C,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$a1c,0,${note ?? ''},${tags.join(',')}');
          }
        },
        exercise: (id, exerciseType, duration, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Exercise,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},${duration.inMinutes},0,${note ?? ''},${tags.join(',')}');
          }
        },
        oxygen: (id, oxygen, heartRate, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Oxygen,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$oxygen,$heartRate,${note ?? ''},${tags.join(',')}');
          }
        },
        note: (id, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Note,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},0,0,${note ?? ''},${tags.join(',')}');
          }
        },
        ketones: (id, ketones, tags, date, note) {
          if (date != null) {
            csvContent.writeln(
                'Ketones,${DateFormat('dd/MM/yy').format(date)},${DateFormat('HH:mm').format(date)},$ketones,0,${note ?? ''},${tags.join(',')}');
          }
        },
      );
    }

    // Get the temporary directory
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/health_records.csv');

    // Save the CSV file
    await file.writeAsString(csvContent.toString());
    return file;
  }
}
