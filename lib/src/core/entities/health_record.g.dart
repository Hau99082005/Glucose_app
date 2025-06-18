// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlucoseRecordImpl _$$GlucoseRecordImplFromJson(Map<String, dynamic> json) =>
    _$GlucoseRecordImpl(
      id: (json['id'] as num).toInt(),
      glucose: (json['glucose'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$GlucoseRecordImplToJson(_$GlucoseRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'glucose': instance.glucose,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$WeightRecordImpl _$$WeightRecordImplFromJson(Map<String, dynamic> json) =>
    _$WeightRecordImpl(
      id: (json['id'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WeightRecordImplToJson(_$WeightRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$BloodPressureRecordImpl _$$BloodPressureRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$BloodPressureRecordImpl(
      id: (json['id'] as num).toInt(),
      systolic: (json['systolic'] as num).toDouble(),
      diastolic: (json['diastolic'] as num).toDouble(),
      heartRate: (json['heartRate'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BloodPressureRecordImplToJson(
        _$BloodPressureRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
      'heartRate': instance.heartRate,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$InsulinRecordImpl _$$InsulinRecordImplFromJson(Map<String, dynamic> json) =>
    _$InsulinRecordImpl(
      id: (json['id'] as num).toInt(),
      units: (json['units'] as num).toDouble(),
      insulinName: json['insulinName'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsulinRecordImplToJson(_$InsulinRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'units': instance.units,
      'insulinName': instance.insulinName,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$MedicationRecordImpl _$$MedicationRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationRecordImpl(
      id: (json['id'] as num).toInt(),
      medicationName: json['medicationName'] as String,
      medicationTime: DateTime.parse(json['medicationTime'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MedicationRecordImplToJson(
        _$MedicationRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicationName': instance.medicationName,
      'medicationTime': instance.medicationTime.toIso8601String(),
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$CarbsRecordImpl _$$CarbsRecordImplFromJson(Map<String, dynamic> json) =>
    _$CarbsRecordImpl(
      id: (json['id'] as num).toInt(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      food: json['food'] as String,
      fat: (json['fat'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CarbsRecordImplToJson(_$CarbsRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'carbohydrates': instance.carbohydrates,
      'food': instance.food,
      'fat': instance.fat,
      'protein': instance.protein,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$TemperatureRecordImpl _$$TemperatureRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$TemperatureRecordImpl(
      id: (json['id'] as num).toInt(),
      temperature: (json['temperature'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TemperatureRecordImplToJson(
        _$TemperatureRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temperature': instance.temperature,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$A1CRecordImpl _$$A1CRecordImplFromJson(Map<String, dynamic> json) =>
    _$A1CRecordImpl(
      id: (json['id'] as num).toInt(),
      a1c: (json['a1c'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$A1CRecordImplToJson(_$A1CRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'a1c': instance.a1c,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$ExerciseRecordImpl _$$ExerciseRecordImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseRecordImpl(
      id: (json['id'] as num).toInt(),
      exerciseType: json['exerciseType'] as String,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ExerciseRecordImplToJson(
        _$ExerciseRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseType': instance.exerciseType,
      'duration': instance.duration.inMicroseconds,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$OxygenRecordImpl _$$OxygenRecordImplFromJson(Map<String, dynamic> json) =>
    _$OxygenRecordImpl(
      id: (json['id'] as num).toInt(),
      oxygen: (json['oxygen'] as num).toDouble(),
      heartRate: (json['heartRate'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OxygenRecordImplToJson(_$OxygenRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oxygen': instance.oxygen,
      'heartRate': instance.heartRate,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$NoteRecordImpl _$$NoteRecordImplFromJson(Map<String, dynamic> json) =>
    _$NoteRecordImpl(
      id: (json['id'] as num).toInt(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NoteRecordImplToJson(_$NoteRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };

_$KetonesRecordImpl _$$KetonesRecordImplFromJson(Map<String, dynamic> json) =>
    _$KetonesRecordImpl(
      id: (json['id'] as num).toInt(),
      ketones: (json['ketones'] as num).toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$KetonesRecordImplToJson(_$KetonesRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ketones': instance.ketones,
      'tags': instance.tags,
      'date': instance.date?.toIso8601String(),
      'note': instance.note,
      'runtimeType': instance.$type,
    };
