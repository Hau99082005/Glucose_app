import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PDFGenerator {
  static Future<File> generatePDF({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> selectedLogTypes,
    required bool includePersonalInfo,
    required bool includeAverages,
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

    final pdf = pw.Document();

    // Add a page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (includePersonalInfo) ...[
                pw.Text('Personal Information',
                    style: const pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 10),
              ],
              if (includeAverages) ...[
                pw.Text('Averages', style: const pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 10),
              ],
              pw.Text('Health Records',
                  style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Date'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Type'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Value'),
                      ),
                    ],
                  ),
                  ...records.map((record) {
                    return record.when(
                      glucose: (id, glucose, tags, date, note) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Glucose'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$glucose mg/dL'),
                          ),
                        ],
                      ),
                      weight: (id, weight, tags, date, note) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Weight'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$weight kg'),
                          ),
                        ],
                      ),
                      bloodPressure: (id, systolic, diastolic, heartRate, tags,
                              date, note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Blood Pressure'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$systolic/$diastolic mmHg'),
                          ),
                        ],
                      ),
                      insulin: (id, units, insulinName, tags, date, note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Insulin'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$units units'),
                          ),
                        ],
                      ),
                      medication: (id, medicationName, medicationTime, tags,
                              date, note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Medication'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(medicationName),
                          ),
                        ],
                      ),
                      carbs: (id, carbohydrates, food, fat, protein, tags, date,
                              note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Carbs'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$carbohydrates g'),
                          ),
                        ],
                      ),
                      temperature: (id, temperature, tags, date, note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Temperature'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$temperature °C'),
                          ),
                        ],
                      ),
                      a1c: (id, a1c, tags, date, note) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('A1C'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$a1c%'),
                          ),
                        ],
                      ),
                      exercise:
                          (id, exerciseType, duration, tags, date, note) =>
                              pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Exercise'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$exerciseType - $duration min'),
                          ),
                        ],
                      ),
                      oxygen: (id, oxygen, heartRate, tags, date, note) =>
                          pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Oxygen'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$oxygen%'),
                          ),
                        ],
                      ),
                      note: (id, tags, date, note) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Note'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(note ?? ''),
                          ),
                        ],
                      ),
                      ketones: (id, ketones, tags, date, note) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(date != null
                                ? DateFormat('MM/dd/yyyy').format(date)
                                : ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('Ketones'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text('$ketones mmol/L'),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF
    final output =
        await File('health_report.pdf').writeAsBytes(await pdf.save());
    return output;
  }

  static Future<File> generatePDFWithDetails({
    required BuildContext context,
    required DateTime fromDate,
    required DateTime untilDate,
    required Set<String> selectedLogTypes,
    required bool includeAverages,
    required bool includeNameDOB,
    required String name,
    required DateTime dob,
    required int sortType,
  }) async {
    final doc = pw.Document();
    final healthRecords = context.read<HealthRecordProvider>().records;

    // Filter records by date range and selected types
    final filteredRecords = healthRecords.where((record) {
      final date = record.maybeWhen<DateTime?>(
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
        orElse: () => null,
      );

      if (date == null) return false;
      if (date.isBefore(fromDate) || date.isAfter(untilDate)) {
        return false;
      }

      final recordType = record.maybeWhen<String?>(
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
        orElse: () => null,
      );

      return recordType != null && selectedLogTypes.contains(recordType);
    }).toList();

    // Sort records
    if (sortType == 0) {
      filteredRecords.sort((a, b) {
        final dateA = a.maybeWhen<DateTime?>(
          glucose: (id, glucose, tags, date, note) => date,
          weight: (id, weight, tags, date, note) => date,
          bloodPressure:
              (id, systolic, diastolic, heartRate, tags, date, note) => date,
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
          orElse: () => null,
        );
        final dateB = b.maybeWhen<DateTime?>(
          glucose: (id, glucose, tags, date, note) => date,
          weight: (id, weight, tags, date, note) => date,
          bloodPressure:
              (id, systolic, diastolic, heartRate, tags, date, note) => date,
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
          orElse: () => null,
        );
        return (dateB ?? DateTime.now()).compareTo(dateA ?? DateTime.now());
      });
    } else {
      filteredRecords.sort((a, b) {
        final typeA = a.maybeWhen<String>(
          glucose: (id, glucose, tags, date, note) => 'Glucose',
          weight: (id, weight, tags, date, note) => 'Weight',
          bloodPressure:
              (id, systolic, diastolic, heartRate, tags, date, note) =>
                  'Blood Pressure',
          insulin: (id, units, insulinName, tags, date, note) => 'Insulin',
          medication: (id, medicationName, medicationTime, tags, date, note) =>
              'Medication',
          carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
              'Carbs',
          temperature: (id, temperature, tags, date, note) => 'Temperature',
          a1c: (id, a1c, tags, date, note) => 'A1C',
          exercise: (id, exerciseType, duration, tags, date, note) =>
              'Exercise',
          oxygen: (id, oxygen, heartRate, tags, date, note) => 'Oxygen',
          note: (id, tags, date, note) => 'Note',
          ketones: (id, ketones, tags, date, note) => 'Ketones',
          orElse: () => '',
        );
        final typeB = b.maybeWhen<String>(
          glucose: (id, glucose, tags, date, note) => 'Glucose',
          weight: (id, weight, tags, date, note) => 'Weight',
          bloodPressure:
              (id, systolic, diastolic, heartRate, tags, date, note) =>
                  'Blood Pressure',
          insulin: (id, units, insulinName, tags, date, note) => 'Insulin',
          medication: (id, medicationName, medicationTime, tags, date, note) =>
              'Medication',
          carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
              'Carbs',
          temperature: (id, temperature, tags, date, note) => 'Temperature',
          a1c: (id, a1c, tags, date, note) => 'A1C',
          exercise: (id, exerciseType, duration, tags, date, note) =>
              'Exercise',
          oxygen: (id, oxygen, heartRate, tags, date, note) => 'Oxygen',
          note: (id, tags, date, note) => 'Note',
          ketones: (id, ketones, tags, date, note) => 'Ketones',
          orElse: () => '',
        );
        return typeA.compareTo(typeB);
      });
    }

    // Calculate averages if needed
    Map<String, double> averages = {};
    if (includeAverages) {
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));
      final ninetyDaysAgo = now.subtract(const Duration(days: 90));

      averages = {
        '7Day': _calculateGlucoseAverage(healthRecords, sevenDaysAgo),
        '30Day': _calculateGlucoseAverage(healthRecords, thirtyDaysAgo),
        '90Day': _calculateGlucoseAverage(healthRecords, ninetyDaysAgo),
      };
    }

    // Build PDF
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header with Name and DOB
            if (includeNameDOB)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    '$name, ${DateFormat('MMM d, yyyy').format(dob)}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            pw.SizedBox(height: 20),

            // Averages Box
            if (includeAverages)
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Averages',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                        '7 Day Average: ${averages['7Day']?.toStringAsFixed(1)} mg/dL'),
                    pw.Text(
                        '30 Day Average: ${averages['30Day']?.toStringAsFixed(1)} mg/dL'),
                    pw.Text(
                        '90 Day Average: ${averages['90Day']?.toStringAsFixed(1)} mg/dL'),
                  ],
                ),
              ),
            pw.SizedBox(height: 20),

            // Table
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(color: PdfColors.black),
              headers: ['Date', 'Time', 'Type', 'Data', 'Note', 'Tags'],
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerLeft,
                4: pw.Alignment.centerLeft,
                5: pw.Alignment.centerLeft,
              },
              data: filteredRecords.map((record) {
                return record.maybeWhen(
                  glucose: (id, glucose, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Glucose',
                    '$glucose mg/dL',
                    note ?? '',
                    tags.join(', '),
                  ],
                  weight: (id, weight, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Weight',
                    '$weight kg',
                    note ?? '',
                    tags.join(', '),
                  ],
                  bloodPressure:
                      (id, systolic, diastolic, heartRate, tags, date, note) =>
                          [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Blood Pressure',
                    '$systolic/$diastolic mmHg',
                    note ?? '',
                    tags.join(', '),
                  ],
                  insulin: (id, units, insulinName, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Insulin',
                    '$units units - $insulinName',
                    note ?? '',
                    tags.join(', '),
                  ],
                  medication:
                      (id, medicationName, medicationTime, tags, date, note) =>
                          [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Medication',
                    '$medicationName - ${DateFormat('h:mm a').format(medicationTime)}',
                    note ?? '',
                    tags.join(', '),
                  ],
                  carbs: (id, carbohydrates, food, fat, protein, tags, date,
                          note) =>
                      [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Carbs',
                    '$carbohydrates g - $food',
                    note ?? '',
                    tags.join(', '),
                  ],
                  temperature: (id, temperature, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Temperature',
                    '$temperature°C',
                    note ?? '',
                    tags.join(', '),
                  ],
                  a1c: (id, a1c, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'A1C',
                    '$a1c%',
                    note ?? '',
                    tags.join(', '),
                  ],
                  exercise: (id, exerciseType, duration, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Exercise',
                    '$exerciseType - ${duration.inMinutes} min',
                    note ?? '',
                    tags.join(', '),
                  ],
                  oxygen: (id, oxygen, heartRate, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Oxygen',
                    '$oxygen% - HR: $heartRate',
                    note ?? '',
                    tags.join(', '),
                  ],
                  note: (id, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Note',
                    note ?? '',
                    note ?? '',
                    tags.join(', '),
                  ],
                  ketones: (id, ketones, tags, date, note) => [
                    date != null ? DateFormat('MMM d, yyyy').format(date) : '',
                    date != null ? DateFormat('h:mm a').format(date) : '',
                    'Ketones',
                    '$ketones mmol/L',
                    note ?? '',
                    tags.join(', '),
                  ],
                  orElse: () => ['', '', '', '', '', ''],
                );
              }).toList(),
            ),
          ];
        },
      ),
    );

    // Get the temporary directory
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/health_report.pdf');

    // Save the PDF to a file
    await file.writeAsBytes(await doc.save());
    return file;
  }

  static double _calculateGlucoseAverage(
      List<HealthRecord> records, DateTime startDate) {
    final glucoseRecords = records.where((record) => record.maybeWhen<bool>(
          glucose: (id, glucose, tags, date, note) =>
              date != null && date.isAfter(startDate),
          orElse: () => false,
        ));

    if (glucoseRecords.isEmpty) return 0.0;

    final sum = glucoseRecords.fold<double>(
      0.0,
      (sum, record) =>
          sum +
          record.maybeWhen<double>(
            glucose: (id, glucose, tags, date, note) => glucose,
            orElse: () => 0.0,
          ),
    );

    return sum / glucoseRecords.length;
  }
}
