enum MedicationType {
  pill,
  insulin,
  injection,
}

enum PillUnit {
  pill,
  mg,
}

enum InsulinType {
  basal,
  bolus,
  mixed,
}

class Medication {
  final int? id;
  final String name;
  final MedicationType type;
  final dynamic unit; // Can be PillUnit or InsulinType
  final String? note;
  final String? photoPath;

  Medication({
    this.id,
    required this.name,
    required this.type,
    required this.unit,
    this.note,
    this.photoPath,
  });

  // Create a copy of this medication with some fields replaced
  Medication copyWith({
    int? id,
    String? name,
    MedicationType? type,
    dynamic unit,
    String? note,
    String? photoPath,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      note: note ?? this.note,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  // Convert a Medication to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'unit': unit is PillUnit
          ? (unit as PillUnit).index
          : (unit as InsulinType).index,
      'unitType': unit is PillUnit ? 'pill' : 'insulin',
      'note': note,
      'photoPath': photoPath,
    };
  }

  // Create a Medication from a Map
  factory Medication.fromMap(Map<String, dynamic> map) {
    final unitType = map['unitType'] as String;
    dynamic unit;

    if (unitType == 'pill') {
      unit = PillUnit.values[map['unit'] as int];
    } else {
      unit = InsulinType.values[map['unit'] as int];
    }

    return Medication(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: MedicationType.values[map['type'] as int],
      unit: unit,
      note: map['note'] as String?,
      photoPath: map['photoPath'] as String?,
    );
  }
}
