import 'dart:convert';
import 'package:flutter_app/src/core/database/database_helper.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late DatabaseHelper databaseHelper;

  setUp(() async {
    databaseHelper = DatabaseHelper.instance;
    // Clear the database before each test
    final db = await databaseHelper.database;
    await db.delete('health_records');
    await db.delete('tags');
  });

  test('generate and import 1 year of glucose data', () async {
    // 1. Generate Data
    final records = await generateGlucoseData(365);

    // 2. Create CSV
    final csvData = const ListToCsvConverter().convert(records.map((r) {
      final glucoseRecord = r as GlucoseRecord;
      return [
        glucoseRecord.date?.toIso8601String(),
        glucoseRecord.glucose,
        glucoseRecord.tags.join(';'), // Use a different separator
        glucoseRecord.note,
      ];
    }).toList());

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final File csvFile = File('$tempPath/glucose_data.csv');
    await csvFile.writeAsString(csvData);

    // 3. Import Data
    final importedRecords = await importGlucoseDataFromCsv(csvFile.path);
    for (var record in importedRecords) {
      await databaseHelper.insertRecord(record);
    }

    // 4. Validation
    final allRecords = await databaseHelper.getAllRecords();
    final glucoseRecords = allRecords.where((r) => r is GlucoseRecord).toList();

    expect(glucoseRecords.length, 365);

    // Validate a sample record
    final originalFirstRecord = records.first as GlucoseRecord;
    final importedFirstRecord = glucoseRecords.firstWhere((r) {
        final g = r as GlucoseRecord;
        return g.date?.year == originalFirstRecord.date?.year &&
               g.date?.month == originalFirstRecord.date?.month &&
               g.date?.day == originalFirstRecord.date?.day &&
               g.date?.hour == originalFirstRecord.date?.hour &&
               g.date?.minute == originalFirstRecord.date?.minute &&
               g.date?.second == originalFirstRecord.date?.second;
    }) as GlucoseRecord;


    expect(importedFirstRecord.glucose, originalFirstRecord.glucose);
    expect(importedFirstRecord.note, originalFirstRecord.note);
    expect(importedFirstRecord.tags, originalFirstRecord.tags);
  });
}

Future<List<HealthRecord>> generateGlucoseData(int days) async {
  final List<HealthRecord> records = [];
  final random = Random();
  DateTime currentDate = DateTime.now();

  for (int i = 0; i < days; i++) {
    double glucose = 70.0 + random.nextDouble() * 110.0; // Normal range
    if (random.nextDouble() < 0.1) { // 10% chance of high/low
      glucose = random.nextBool() ? 40.0 + random.nextDouble() * 30.0 : 180.0 + random.nextDouble() * 100;
    }
    records.add(
      HealthRecord.glucose(
        id: 0, // placeholder
        glucose: double.parse(glucose.toStringAsFixed(1)),
        date: currentDate,
        tags: ['test_data', 'generated', random.nextBool() ? 'fasting' : 'post_meal'],
        note: 'Generated record for day ${i + 1}',
      ),
    );
    currentDate = currentDate.subtract(const Duration(days: 1));
  }

  return records;
}

Future<List<HealthRecord>> importGlucoseDataFromCsv(String filePath) async {
  final file = File(filePath);
  if (!await file.exists()) {
    throw Exception('CSV file not found at $filePath');
  }
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  final List<HealthRecord> records = [];
  for (final row in fields) {
    if (row.length >= 4) {
      records.add(HealthRecord.glucose(
        id: 0, // placeholder
        date: DateTime.parse(row[0] as String),
        glucose: (row[1] as num).toDouble(),
        tags: (row[2] as String).split(';'),
        note: row[3] as String,
      ));
    }
  }
  return records;
} 