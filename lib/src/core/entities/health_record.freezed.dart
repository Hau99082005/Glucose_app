// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthRecord _$HealthRecordFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'glucose':
      return GlucoseRecord.fromJson(json);
    case 'weight':
      return WeightRecord.fromJson(json);
    case 'bloodPressure':
      return BloodPressureRecord.fromJson(json);
    case 'insulin':
      return InsulinRecord.fromJson(json);
    case 'medication':
      return MedicationRecord.fromJson(json);
    case 'carbs':
      return CarbsRecord.fromJson(json);
    case 'temperature':
      return TemperatureRecord.fromJson(json);
    case 'a1c':
      return A1CRecord.fromJson(json);
    case 'exercise':
      return ExerciseRecord.fromJson(json);
    case 'oxygen':
      return OxygenRecord.fromJson(json);
    case 'note':
      return NoteRecord.fromJson(json);
    case 'ketones':
      return KetonesRecord.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'HealthRecord',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$HealthRecord {
  int get id => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this HealthRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthRecordCopyWith<HealthRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthRecordCopyWith<$Res> {
  factory $HealthRecordCopyWith(
          HealthRecord value, $Res Function(HealthRecord) then) =
      _$HealthRecordCopyWithImpl<$Res, HealthRecord>;
  @useResult
  $Res call({int id, List<String> tags, DateTime? date, String? note});
}

/// @nodoc
class _$HealthRecordCopyWithImpl<$Res, $Val extends HealthRecord>
    implements $HealthRecordCopyWith<$Res> {
  _$HealthRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GlucoseRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$GlucoseRecordImplCopyWith(
          _$GlucoseRecordImpl value, $Res Function(_$GlucoseRecordImpl) then) =
      __$$GlucoseRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double glucose,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$GlucoseRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$GlucoseRecordImpl>
    implements _$$GlucoseRecordImplCopyWith<$Res> {
  __$$GlucoseRecordImplCopyWithImpl(
      _$GlucoseRecordImpl _value, $Res Function(_$GlucoseRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? glucose = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$GlucoseRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      glucose: null == glucose
          ? _value.glucose
          : glucose // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GlucoseRecordImpl implements GlucoseRecord {
  const _$GlucoseRecordImpl(
      {required this.id,
      required this.glucose,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'glucose';

  factory _$GlucoseRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$GlucoseRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double glucose;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.glucose(id: $id, glucose: $glucose, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlucoseRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.glucose, glucose) || other.glucose == glucose) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, glucose,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GlucoseRecordImplCopyWith<_$GlucoseRecordImpl> get copyWith =>
      __$$GlucoseRecordImplCopyWithImpl<_$GlucoseRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return glucose(id, this.glucose, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return glucose?.call(id, this.glucose, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (glucose != null) {
      return glucose(id, this.glucose, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return glucose(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return glucose?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (glucose != null) {
      return glucose(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GlucoseRecordImplToJson(
      this,
    );
  }
}

abstract class GlucoseRecord implements HealthRecord {
  const factory GlucoseRecord(
      {required final int id,
      required final double glucose,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$GlucoseRecordImpl;

  factory GlucoseRecord.fromJson(Map<String, dynamic> json) =
      _$GlucoseRecordImpl.fromJson;

  @override
  int get id;
  double get glucose;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GlucoseRecordImplCopyWith<_$GlucoseRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WeightRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$WeightRecordImplCopyWith(
          _$WeightRecordImpl value, $Res Function(_$WeightRecordImpl) then) =
      __$$WeightRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, double weight, List<String> tags, DateTime? date, String? note});
}

/// @nodoc
class __$$WeightRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$WeightRecordImpl>
    implements _$$WeightRecordImplCopyWith<$Res> {
  __$$WeightRecordImplCopyWithImpl(
      _$WeightRecordImpl _value, $Res Function(_$WeightRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$WeightRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeightRecordImpl implements WeightRecord {
  const _$WeightRecordImpl(
      {required this.id,
      required this.weight,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'weight';

  factory _$WeightRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double weight;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.weight(id: $id, weight: $weight, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, weight,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightRecordImplCopyWith<_$WeightRecordImpl> get copyWith =>
      __$$WeightRecordImplCopyWithImpl<_$WeightRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return weight(id, this.weight, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return weight?.call(id, this.weight, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (weight != null) {
      return weight(id, this.weight, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return weight(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return weight?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (weight != null) {
      return weight(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightRecordImplToJson(
      this,
    );
  }
}

abstract class WeightRecord implements HealthRecord {
  const factory WeightRecord(
      {required final int id,
      required final double weight,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$WeightRecordImpl;

  factory WeightRecord.fromJson(Map<String, dynamic> json) =
      _$WeightRecordImpl.fromJson;

  @override
  int get id;
  double get weight;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeightRecordImplCopyWith<_$WeightRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BloodPressureRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$BloodPressureRecordImplCopyWith(_$BloodPressureRecordImpl value,
          $Res Function(_$BloodPressureRecordImpl) then) =
      __$$BloodPressureRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double systolic,
      double diastolic,
      double heartRate,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$BloodPressureRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$BloodPressureRecordImpl>
    implements _$$BloodPressureRecordImplCopyWith<$Res> {
  __$$BloodPressureRecordImplCopyWithImpl(_$BloodPressureRecordImpl _value,
      $Res Function(_$BloodPressureRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? systolic = null,
    Object? diastolic = null,
    Object? heartRate = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$BloodPressureRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      systolic: null == systolic
          ? _value.systolic
          : systolic // ignore: cast_nullable_to_non_nullable
              as double,
      diastolic: null == diastolic
          ? _value.diastolic
          : diastolic // ignore: cast_nullable_to_non_nullable
              as double,
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BloodPressureRecordImpl implements BloodPressureRecord {
  const _$BloodPressureRecordImpl(
      {required this.id,
      required this.systolic,
      required this.diastolic,
      required this.heartRate,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'bloodPressure';

  factory _$BloodPressureRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$BloodPressureRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double systolic;
  @override
  final double diastolic;
  @override
  final double heartRate;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.bloodPressure(id: $id, systolic: $systolic, diastolic: $diastolic, heartRate: $heartRate, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodPressureRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.systolic, systolic) ||
                other.systolic == systolic) &&
            (identical(other.diastolic, diastolic) ||
                other.diastolic == diastolic) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, systolic, diastolic,
      heartRate, const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodPressureRecordImplCopyWith<_$BloodPressureRecordImpl> get copyWith =>
      __$$BloodPressureRecordImplCopyWithImpl<_$BloodPressureRecordImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return bloodPressure(
        id, systolic, diastolic, heartRate, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return bloodPressure?.call(
        id, systolic, diastolic, heartRate, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (bloodPressure != null) {
      return bloodPressure(
          id, systolic, diastolic, heartRate, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return bloodPressure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return bloodPressure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (bloodPressure != null) {
      return bloodPressure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BloodPressureRecordImplToJson(
      this,
    );
  }
}

abstract class BloodPressureRecord implements HealthRecord {
  const factory BloodPressureRecord(
      {required final int id,
      required final double systolic,
      required final double diastolic,
      required final double heartRate,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$BloodPressureRecordImpl;

  factory BloodPressureRecord.fromJson(Map<String, dynamic> json) =
      _$BloodPressureRecordImpl.fromJson;

  @override
  int get id;
  double get systolic;
  double get diastolic;
  double get heartRate;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BloodPressureRecordImplCopyWith<_$BloodPressureRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsulinRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$InsulinRecordImplCopyWith(
          _$InsulinRecordImpl value, $Res Function(_$InsulinRecordImpl) then) =
      __$$InsulinRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double units,
      String insulinName,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$InsulinRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$InsulinRecordImpl>
    implements _$$InsulinRecordImplCopyWith<$Res> {
  __$$InsulinRecordImplCopyWithImpl(
      _$InsulinRecordImpl _value, $Res Function(_$InsulinRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? units = null,
    Object? insulinName = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$InsulinRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as double,
      insulinName: null == insulinName
          ? _value.insulinName
          : insulinName // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsulinRecordImpl implements InsulinRecord {
  const _$InsulinRecordImpl(
      {required this.id,
      required this.units,
      required this.insulinName,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'insulin';

  factory _$InsulinRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsulinRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double units;
  @override
  final String insulinName;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.insulin(id: $id, units: $units, insulinName: $insulinName, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsulinRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.insulinName, insulinName) ||
                other.insulinName == insulinName) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, units, insulinName,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsulinRecordImplCopyWith<_$InsulinRecordImpl> get copyWith =>
      __$$InsulinRecordImplCopyWithImpl<_$InsulinRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return insulin(id, units, insulinName, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return insulin?.call(id, units, insulinName, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (insulin != null) {
      return insulin(id, units, insulinName, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return insulin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return insulin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (insulin != null) {
      return insulin(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsulinRecordImplToJson(
      this,
    );
  }
}

abstract class InsulinRecord implements HealthRecord {
  const factory InsulinRecord(
      {required final int id,
      required final double units,
      required final String insulinName,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$InsulinRecordImpl;

  factory InsulinRecord.fromJson(Map<String, dynamic> json) =
      _$InsulinRecordImpl.fromJson;

  @override
  int get id;
  double get units;
  String get insulinName;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsulinRecordImplCopyWith<_$InsulinRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MedicationRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$MedicationRecordImplCopyWith(_$MedicationRecordImpl value,
          $Res Function(_$MedicationRecordImpl) then) =
      __$$MedicationRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String medicationName,
      DateTime medicationTime,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$MedicationRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$MedicationRecordImpl>
    implements _$$MedicationRecordImplCopyWith<$Res> {
  __$$MedicationRecordImplCopyWithImpl(_$MedicationRecordImpl _value,
      $Res Function(_$MedicationRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? medicationName = null,
    Object? medicationTime = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$MedicationRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      medicationName: null == medicationName
          ? _value.medicationName
          : medicationName // ignore: cast_nullable_to_non_nullable
              as String,
      medicationTime: null == medicationTime
          ? _value.medicationTime
          : medicationTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationRecordImpl implements MedicationRecord {
  const _$MedicationRecordImpl(
      {required this.id,
      required this.medicationName,
      required this.medicationTime,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'medication';

  factory _$MedicationRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationRecordImplFromJson(json);

  @override
  final int id;
  @override
  final String medicationName;
  @override
  final DateTime medicationTime;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.medication(id: $id, medicationName: $medicationName, medicationTime: $medicationTime, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.medicationName, medicationName) ||
                other.medicationName == medicationName) &&
            (identical(other.medicationTime, medicationTime) ||
                other.medicationTime == medicationTime) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, medicationName,
      medicationTime, const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationRecordImplCopyWith<_$MedicationRecordImpl> get copyWith =>
      __$$MedicationRecordImplCopyWithImpl<_$MedicationRecordImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return medication(
        id, medicationName, medicationTime, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return medication?.call(
        id, medicationName, medicationTime, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (medication != null) {
      return medication(
          id, medicationName, medicationTime, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return medication(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return medication?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (medication != null) {
      return medication(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationRecordImplToJson(
      this,
    );
  }
}

abstract class MedicationRecord implements HealthRecord {
  const factory MedicationRecord(
      {required final int id,
      required final String medicationName,
      required final DateTime medicationTime,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$MedicationRecordImpl;

  factory MedicationRecord.fromJson(Map<String, dynamic> json) =
      _$MedicationRecordImpl.fromJson;

  @override
  int get id;
  String get medicationName;
  DateTime get medicationTime;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationRecordImplCopyWith<_$MedicationRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CarbsRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$CarbsRecordImplCopyWith(
          _$CarbsRecordImpl value, $Res Function(_$CarbsRecordImpl) then) =
      __$$CarbsRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double carbohydrates,
      String food,
      double fat,
      double protein,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$CarbsRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$CarbsRecordImpl>
    implements _$$CarbsRecordImplCopyWith<$Res> {
  __$$CarbsRecordImplCopyWithImpl(
      _$CarbsRecordImpl _value, $Res Function(_$CarbsRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? carbohydrates = null,
    Object? food = null,
    Object? fat = null,
    Object? protein = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$CarbsRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as String,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarbsRecordImpl implements CarbsRecord {
  const _$CarbsRecordImpl(
      {required this.id,
      required this.carbohydrates,
      required this.food,
      required this.fat,
      required this.protein,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'carbs';

  factory _$CarbsRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarbsRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double carbohydrates;
  @override
  final String food;
  @override
  final double fat;
  @override
  final double protein;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.carbs(id: $id, carbohydrates: $carbohydrates, food: $food, fat: $fat, protein: $protein, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarbsRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, carbohydrates, food, fat,
      protein, const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarbsRecordImplCopyWith<_$CarbsRecordImpl> get copyWith =>
      __$$CarbsRecordImplCopyWithImpl<_$CarbsRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return carbs(id, carbohydrates, food, fat, protein, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return carbs?.call(
        id, carbohydrates, food, fat, protein, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (carbs != null) {
      return carbs(
          id, carbohydrates, food, fat, protein, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return carbs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return carbs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (carbs != null) {
      return carbs(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CarbsRecordImplToJson(
      this,
    );
  }
}

abstract class CarbsRecord implements HealthRecord {
  const factory CarbsRecord(
      {required final int id,
      required final double carbohydrates,
      required final String food,
      required final double fat,
      required final double protein,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$CarbsRecordImpl;

  factory CarbsRecord.fromJson(Map<String, dynamic> json) =
      _$CarbsRecordImpl.fromJson;

  @override
  int get id;
  double get carbohydrates;
  String get food;
  double get fat;
  double get protein;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarbsRecordImplCopyWith<_$CarbsRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TemperatureRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$TemperatureRecordImplCopyWith(_$TemperatureRecordImpl value,
          $Res Function(_$TemperatureRecordImpl) then) =
      __$$TemperatureRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double temperature,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$TemperatureRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$TemperatureRecordImpl>
    implements _$$TemperatureRecordImplCopyWith<$Res> {
  __$$TemperatureRecordImplCopyWithImpl(_$TemperatureRecordImpl _value,
      $Res Function(_$TemperatureRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? temperature = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$TemperatureRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TemperatureRecordImpl implements TemperatureRecord {
  const _$TemperatureRecordImpl(
      {required this.id,
      required this.temperature,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'temperature';

  factory _$TemperatureRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemperatureRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double temperature;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.temperature(id: $id, temperature: $temperature, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemperatureRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, temperature,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemperatureRecordImplCopyWith<_$TemperatureRecordImpl> get copyWith =>
      __$$TemperatureRecordImplCopyWithImpl<_$TemperatureRecordImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return temperature(id, this.temperature, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return temperature?.call(id, this.temperature, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (temperature != null) {
      return temperature(id, this.temperature, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return temperature(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return temperature?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (temperature != null) {
      return temperature(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TemperatureRecordImplToJson(
      this,
    );
  }
}

abstract class TemperatureRecord implements HealthRecord {
  const factory TemperatureRecord(
      {required final int id,
      required final double temperature,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$TemperatureRecordImpl;

  factory TemperatureRecord.fromJson(Map<String, dynamic> json) =
      _$TemperatureRecordImpl.fromJson;

  @override
  int get id;
  double get temperature;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemperatureRecordImplCopyWith<_$TemperatureRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$A1CRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$A1CRecordImplCopyWith(
          _$A1CRecordImpl value, $Res Function(_$A1CRecordImpl) then) =
      __$$A1CRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, double a1c, List<String> tags, DateTime? date, String? note});
}

/// @nodoc
class __$$A1CRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$A1CRecordImpl>
    implements _$$A1CRecordImplCopyWith<$Res> {
  __$$A1CRecordImplCopyWithImpl(
      _$A1CRecordImpl _value, $Res Function(_$A1CRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? a1c = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$A1CRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      a1c: null == a1c
          ? _value.a1c
          : a1c // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$A1CRecordImpl implements A1CRecord {
  const _$A1CRecordImpl(
      {required this.id,
      required this.a1c,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'a1c';

  factory _$A1CRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$A1CRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double a1c;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.a1c(id: $id, a1c: $a1c, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$A1CRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.a1c, a1c) || other.a1c == a1c) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, a1c,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$A1CRecordImplCopyWith<_$A1CRecordImpl> get copyWith =>
      __$$A1CRecordImplCopyWithImpl<_$A1CRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return a1c(id, this.a1c, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return a1c?.call(id, this.a1c, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (a1c != null) {
      return a1c(id, this.a1c, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return a1c(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return a1c?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (a1c != null) {
      return a1c(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$A1CRecordImplToJson(
      this,
    );
  }
}

abstract class A1CRecord implements HealthRecord {
  const factory A1CRecord(
      {required final int id,
      required final double a1c,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$A1CRecordImpl;

  factory A1CRecord.fromJson(Map<String, dynamic> json) =
      _$A1CRecordImpl.fromJson;

  @override
  int get id;
  double get a1c;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$A1CRecordImplCopyWith<_$A1CRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExerciseRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$ExerciseRecordImplCopyWith(_$ExerciseRecordImpl value,
          $Res Function(_$ExerciseRecordImpl) then) =
      __$$ExerciseRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String exerciseType,
      Duration duration,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$ExerciseRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$ExerciseRecordImpl>
    implements _$$ExerciseRecordImplCopyWith<$Res> {
  __$$ExerciseRecordImplCopyWithImpl(
      _$ExerciseRecordImpl _value, $Res Function(_$ExerciseRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseType = null,
    Object? duration = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$ExerciseRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseType: null == exerciseType
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseRecordImpl implements ExerciseRecord {
  const _$ExerciseRecordImpl(
      {required this.id,
      required this.exerciseType,
      required this.duration,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'exercise';

  factory _$ExerciseRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseRecordImplFromJson(json);

  @override
  final int id;
  @override
  final String exerciseType;
  @override
  final Duration duration;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.exercise(id: $id, exerciseType: $exerciseType, duration: $duration, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseType, exerciseType) ||
                other.exerciseType == exerciseType) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, exerciseType, duration,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseRecordImplCopyWith<_$ExerciseRecordImpl> get copyWith =>
      __$$ExerciseRecordImplCopyWithImpl<_$ExerciseRecordImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return exercise(id, exerciseType, duration, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return exercise?.call(id, exerciseType, duration, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (exercise != null) {
      return exercise(id, exerciseType, duration, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return exercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return exercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (exercise != null) {
      return exercise(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseRecordImplToJson(
      this,
    );
  }
}

abstract class ExerciseRecord implements HealthRecord {
  const factory ExerciseRecord(
      {required final int id,
      required final String exerciseType,
      required final Duration duration,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$ExerciseRecordImpl;

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) =
      _$ExerciseRecordImpl.fromJson;

  @override
  int get id;
  String get exerciseType;
  Duration get duration;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseRecordImplCopyWith<_$ExerciseRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OxygenRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$OxygenRecordImplCopyWith(
          _$OxygenRecordImpl value, $Res Function(_$OxygenRecordImpl) then) =
      __$$OxygenRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double oxygen,
      double heartRate,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$OxygenRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$OxygenRecordImpl>
    implements _$$OxygenRecordImplCopyWith<$Res> {
  __$$OxygenRecordImplCopyWithImpl(
      _$OxygenRecordImpl _value, $Res Function(_$OxygenRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? oxygen = null,
    Object? heartRate = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$OxygenRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      oxygen: null == oxygen
          ? _value.oxygen
          : oxygen // ignore: cast_nullable_to_non_nullable
              as double,
      heartRate: null == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OxygenRecordImpl implements OxygenRecord {
  const _$OxygenRecordImpl(
      {required this.id,
      required this.oxygen,
      required this.heartRate,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'oxygen';

  factory _$OxygenRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$OxygenRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double oxygen;
  @override
  final double heartRate;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.oxygen(id: $id, oxygen: $oxygen, heartRate: $heartRate, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OxygenRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.oxygen, oxygen) || other.oxygen == oxygen) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, oxygen, heartRate,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OxygenRecordImplCopyWith<_$OxygenRecordImpl> get copyWith =>
      __$$OxygenRecordImplCopyWithImpl<_$OxygenRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return oxygen(id, this.oxygen, heartRate, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return oxygen?.call(id, this.oxygen, heartRate, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (oxygen != null) {
      return oxygen(id, this.oxygen, heartRate, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return oxygen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return oxygen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (oxygen != null) {
      return oxygen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OxygenRecordImplToJson(
      this,
    );
  }
}

abstract class OxygenRecord implements HealthRecord {
  const factory OxygenRecord(
      {required final int id,
      required final double oxygen,
      required final double heartRate,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$OxygenRecordImpl;

  factory OxygenRecord.fromJson(Map<String, dynamic> json) =
      _$OxygenRecordImpl.fromJson;

  @override
  int get id;
  double get oxygen;
  double get heartRate;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OxygenRecordImplCopyWith<_$OxygenRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoteRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$NoteRecordImplCopyWith(
          _$NoteRecordImpl value, $Res Function(_$NoteRecordImpl) then) =
      __$$NoteRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, List<String> tags, DateTime? date, String? note});
}

/// @nodoc
class __$$NoteRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$NoteRecordImpl>
    implements _$$NoteRecordImplCopyWith<$Res> {
  __$$NoteRecordImplCopyWithImpl(
      _$NoteRecordImpl _value, $Res Function(_$NoteRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$NoteRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteRecordImpl implements NoteRecord {
  const _$NoteRecordImpl(
      {required this.id,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'note';

  factory _$NoteRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteRecordImplFromJson(json);

  @override
  final int id;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.note(id: $id, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteRecordImplCopyWith<_$NoteRecordImpl> get copyWith =>
      __$$NoteRecordImplCopyWithImpl<_$NoteRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return note(id, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return note?.call(id, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (note != null) {
      return note(id, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return note(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return note?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (note != null) {
      return note(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteRecordImplToJson(
      this,
    );
  }
}

abstract class NoteRecord implements HealthRecord {
  const factory NoteRecord(
      {required final int id,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$NoteRecordImpl;

  factory NoteRecord.fromJson(Map<String, dynamic> json) =
      _$NoteRecordImpl.fromJson;

  @override
  int get id;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteRecordImplCopyWith<_$NoteRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$KetonesRecordImplCopyWith<$Res>
    implements $HealthRecordCopyWith<$Res> {
  factory _$$KetonesRecordImplCopyWith(
          _$KetonesRecordImpl value, $Res Function(_$KetonesRecordImpl) then) =
      __$$KetonesRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double ketones,
      List<String> tags,
      DateTime? date,
      String? note});
}

/// @nodoc
class __$$KetonesRecordImplCopyWithImpl<$Res>
    extends _$HealthRecordCopyWithImpl<$Res, _$KetonesRecordImpl>
    implements _$$KetonesRecordImplCopyWith<$Res> {
  __$$KetonesRecordImplCopyWithImpl(
      _$KetonesRecordImpl _value, $Res Function(_$KetonesRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ketones = null,
    Object? tags = null,
    Object? date = freezed,
    Object? note = freezed,
  }) {
    return _then(_$KetonesRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ketones: null == ketones
          ? _value.ketones
          : ketones // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KetonesRecordImpl implements KetonesRecord {
  const _$KetonesRecordImpl(
      {required this.id,
      required this.ketones,
      final List<String> tags = const [],
      this.date,
      this.note,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'ketones';

  factory _$KetonesRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$KetonesRecordImplFromJson(json);

  @override
  final int id;
  @override
  final double ketones;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? date;
  @override
  final String? note;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'HealthRecord.ketones(id: $id, ketones: $ketones, tags: $tags, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KetonesRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ketones, ketones) || other.ketones == ketones) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, ketones,
      const DeepCollectionEquality().hash(_tags), date, note);

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KetonesRecordImplCopyWith<_$KetonesRecordImpl> get copyWith =>
      __$$KetonesRecordImplCopyWithImpl<_$KetonesRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, double glucose, List<String> tags,
            DateTime? date, String? note)
        glucose,
    required TResult Function(int id, double weight, List<String> tags,
            DateTime? date, String? note)
        weight,
    required TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)
        bloodPressure,
    required TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)
        insulin,
    required TResult Function(
            int id,
            String medicationName,
            DateTime medicationTime,
            List<String> tags,
            DateTime? date,
            String? note)
        medication,
    required TResult Function(
            int id,
            double carbohydrates,
            String food,
            double fat,
            double protein,
            List<String> tags,
            DateTime? date,
            String? note)
        carbs,
    required TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)
        temperature,
    required TResult Function(
            int id, double a1c, List<String> tags, DateTime? date, String? note)
        a1c,
    required TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)
        exercise,
    required TResult Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)
        oxygen,
    required TResult Function(
            int id, List<String> tags, DateTime? date, String? note)
        note,
    required TResult Function(int id, double ketones, List<String> tags,
            DateTime? date, String? note)
        ketones,
  }) {
    return ketones(id, this.ketones, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult? Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult? Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult? Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult? Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult? Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult? Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult? Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult? Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult? Function(int id, double oxygen, double heartRate,
            List<String> tags, DateTime? date, String? note)?
        oxygen,
    TResult? Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult? Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
  }) {
    return ketones?.call(id, this.ketones, tags, date, this.note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, double glucose, List<String> tags, DateTime? date,
            String? note)?
        glucose,
    TResult Function(int id, double weight, List<String> tags, DateTime? date,
            String? note)?
        weight,
    TResult Function(int id, double systolic, double diastolic,
            double heartRate, List<String> tags, DateTime? date, String? note)?
        bloodPressure,
    TResult Function(int id, double units, String insulinName,
            List<String> tags, DateTime? date, String? note)?
        insulin,
    TResult Function(int id, String medicationName, DateTime medicationTime,
            List<String> tags, DateTime? date, String? note)?
        medication,
    TResult Function(int id, double carbohydrates, String food, double fat,
            double protein, List<String> tags, DateTime? date, String? note)?
        carbs,
    TResult Function(int id, double temperature, List<String> tags,
            DateTime? date, String? note)?
        temperature,
    TResult Function(int id, double a1c, List<String> tags, DateTime? date,
            String? note)?
        a1c,
    TResult Function(int id, String exerciseType, Duration duration,
            List<String> tags, DateTime? date, String? note)?
        exercise,
    TResult Function(int id, double oxygen, double heartRate, List<String> tags,
            DateTime? date, String? note)?
        oxygen,
    TResult Function(int id, List<String> tags, DateTime? date, String? note)?
        note,
    TResult Function(int id, double ketones, List<String> tags, DateTime? date,
            String? note)?
        ketones,
    required TResult orElse(),
  }) {
    if (ketones != null) {
      return ketones(id, this.ketones, tags, date, this.note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GlucoseRecord value) glucose,
    required TResult Function(WeightRecord value) weight,
    required TResult Function(BloodPressureRecord value) bloodPressure,
    required TResult Function(InsulinRecord value) insulin,
    required TResult Function(MedicationRecord value) medication,
    required TResult Function(CarbsRecord value) carbs,
    required TResult Function(TemperatureRecord value) temperature,
    required TResult Function(A1CRecord value) a1c,
    required TResult Function(ExerciseRecord value) exercise,
    required TResult Function(OxygenRecord value) oxygen,
    required TResult Function(NoteRecord value) note,
    required TResult Function(KetonesRecord value) ketones,
  }) {
    return ketones(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GlucoseRecord value)? glucose,
    TResult? Function(WeightRecord value)? weight,
    TResult? Function(BloodPressureRecord value)? bloodPressure,
    TResult? Function(InsulinRecord value)? insulin,
    TResult? Function(MedicationRecord value)? medication,
    TResult? Function(CarbsRecord value)? carbs,
    TResult? Function(TemperatureRecord value)? temperature,
    TResult? Function(A1CRecord value)? a1c,
    TResult? Function(ExerciseRecord value)? exercise,
    TResult? Function(OxygenRecord value)? oxygen,
    TResult? Function(NoteRecord value)? note,
    TResult? Function(KetonesRecord value)? ketones,
  }) {
    return ketones?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GlucoseRecord value)? glucose,
    TResult Function(WeightRecord value)? weight,
    TResult Function(BloodPressureRecord value)? bloodPressure,
    TResult Function(InsulinRecord value)? insulin,
    TResult Function(MedicationRecord value)? medication,
    TResult Function(CarbsRecord value)? carbs,
    TResult Function(TemperatureRecord value)? temperature,
    TResult Function(A1CRecord value)? a1c,
    TResult Function(ExerciseRecord value)? exercise,
    TResult Function(OxygenRecord value)? oxygen,
    TResult Function(NoteRecord value)? note,
    TResult Function(KetonesRecord value)? ketones,
    required TResult orElse(),
  }) {
    if (ketones != null) {
      return ketones(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$KetonesRecordImplToJson(
      this,
    );
  }
}

abstract class KetonesRecord implements HealthRecord {
  const factory KetonesRecord(
      {required final int id,
      required final double ketones,
      final List<String> tags,
      final DateTime? date,
      final String? note}) = _$KetonesRecordImpl;

  factory KetonesRecord.fromJson(Map<String, dynamic> json) =
      _$KetonesRecordImpl.fromJson;

  @override
  int get id;
  double get ketones;
  @override
  List<String> get tags;
  @override
  DateTime? get date;
  @override
  String? get note;

  /// Create a copy of HealthRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KetonesRecordImplCopyWith<_$KetonesRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
