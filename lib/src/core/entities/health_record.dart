import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_record.freezed.dart';
part 'health_record.g.dart';

@freezed
class HealthRecord with _$HealthRecord {
  const factory HealthRecord.glucose({
    required int id,
    required double glucose,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = GlucoseRecord;

  const factory HealthRecord.weight({
    required int id,
    required double weight,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = WeightRecord;

  const factory HealthRecord.bloodPressure({
    required int id,
    required double systolic,
    required double diastolic,
    required double heartRate,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = BloodPressureRecord;

  const factory HealthRecord.insulin({
    required int id,
    required double units,
    required String insulinName,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = InsulinRecord;

  const factory HealthRecord.medication({
    required int id,
    required String medicationName,
    required DateTime medicationTime,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = MedicationRecord;

  const factory HealthRecord.carbs({
    required int id,
    required double carbohydrates,
    required String food,
    required double fat,
    required double protein,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = CarbsRecord;

  const factory HealthRecord.temperature({
    required int id,
    required double temperature,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = TemperatureRecord;

  const factory HealthRecord.a1c({
    required int id,
    required double a1c,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = A1CRecord;

  const factory HealthRecord.exercise({
    required int id,
    required String exerciseType,
    required Duration duration,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = ExerciseRecord;

  const factory HealthRecord.oxygen({
    required int id,
    required double oxygen,
    required double heartRate,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = OxygenRecord;

  const factory HealthRecord.note({
    required int id,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = NoteRecord;

  const factory HealthRecord.ketones({
    required int id,
    required double ketones,
    @Default([]) List<String> tags,
    DateTime? date,
    String? note,
  }) = KetonesRecord;

  factory HealthRecord.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordFromJson(json);
}
