import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../entities/health_record.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('health_records.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create standalone tags table
    await db.execute('''
      CREATE TABLE standalone_tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tag TEXT NOT NULL UNIQUE,
        created_at TEXT NOT NULL
      )
    ''');

    // Create default tags initialization table
    await db.execute('''
      CREATE TABLE default_tags_initialized (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        initialized INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Create reminders table
    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_type TEXT NOT NULL,
        day TEXT NOT NULL,
        time TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL
      )
    ''');

    // Create tags table for record-specific tags
    await db.execute('''
      CREATE TABLE tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        record_type TEXT NOT NULL,
        tag TEXT NOT NULL
      )
    ''');

    // Create records table with type-specific fields
    await db.execute('''
      CREATE TABLE health_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        date TEXT NOT NULL,
        note TEXT NOT NULL,
        -- Glucose
        glucose REAL,
        -- Weight
        weight REAL,
        -- Blood Pressure
        systolic REAL,
        diastolic REAL,
        heart_rate REAL,
        -- Insulin
        units REAL,
        insulin_name TEXT,
        -- Medication
        medication_name TEXT,
        medication_time TEXT,
        -- Carbs
        carbohydrates REAL,
        food TEXT,
        fat REAL,
        protein REAL,
        -- Temperature
        temperature REAL,
        -- A1C
        a1c REAL,
        -- Exercise
        exercise_type TEXT,
        duration INTEGER,
        -- Oxygen
        oxygen REAL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create standalone_tags table if it doesn't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS standalone_tags (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tag TEXT NOT NULL UNIQUE,
          created_at TEXT NOT NULL
        )
      ''');

      // Create default_tags_initialized table if it doesn't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS default_tags_initialized (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          initialized INTEGER NOT NULL DEFAULT 0
        )
      ''');
    }
    
    if (oldVersion < 3) {
      // Create reminders table if it doesn't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS reminders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          record_type TEXT NOT NULL,
          day TEXT NOT NULL,
          time TEXT NOT NULL,
          is_active INTEGER NOT NULL DEFAULT 1,
          created_at TEXT NOT NULL
        )
      ''');
    }
  }

  Future<int> insertRecord(HealthRecord record) async {
    final db = await database;
    final String recordType = record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => 'GlucoseRecord',
      weight: (id, weight, tags, date, note) => 'WeightRecord',
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) => 'BloodPressureRecord',
      insulin: (id, units, insulinName, tags, date, note) => 'InsulinRecord',
      medication: (id, medicationName, medicationTime, tags, date, note) => 'MedicationRecord',
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => 'CarbsRecord',
      temperature: (id, temperature, tags, date, note) => 'TemperatureRecord',
      a1c: (id, a1c, tags, date, note) => 'A1CRecord',
      exercise: (id, exerciseType, duration, tags, date, note) => 'ExerciseRecord',
      oxygen: (id, oxygen, heartRate, tags, date, note) => 'OxygenRecord',
      note: (id, tags, date, note) => 'NoteRecord',
      ketones: (id, ketones, tags, date, note) => 'KetonesRecord',
      orElse: () => 'UnknownRecord',
    );

    final Map<String, dynamic> data = {
      'type': recordType,
      'date': record.date?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'note': record.note ?? '',
    };

    // Add type-specific fields
    record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => data['glucose'] = glucose,
      weight: (id, weight, tags, date, note) => data['weight'] = weight,
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) {
        data['systolic'] = systolic;
        data['diastolic'] = diastolic;
        data['heart_rate'] = heartRate;
      },
      insulin: (id, units, insulinName, tags, date, note) {
        data['units'] = units;
        data['insulin_name'] = insulinName;
      },
      medication: (id, medicationName, medicationTime, tags, date, note) {
        data['medication_name'] = medicationName;
        data['medication_time'] = medicationTime.toIso8601String();
      },
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) {
        data['carbohydrates'] = carbohydrates;
        data['food'] = food;
        data['fat'] = fat;
        data['protein'] = protein;
      },
      temperature: (id, temperature, tags, date, note) => data['temperature'] = temperature,
      a1c: (id, a1c, tags, date, note) => data['a1c'] = a1c,
      exercise: (id, exerciseType, duration, tags, date, note) {
        data['exercise_type'] = exerciseType;
        data['duration'] = duration.inMinutes;
      },
      oxygen: (id, oxygen, heartRate, tags, date, note) {
        data['oxygen'] = oxygen;
        data['heart_rate'] = heartRate;
      },
      orElse: () {},
    );

    print('Inserting record with data: $data'); // Debug log

    final id = await db.insert('health_records', data);
    print('Record inserted with ID: $id'); // Debug log

    // Insert tags if they exist and are not empty
    final List<String> tags = record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => tags,
      weight: (id, weight, tags, date, note) => tags,
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) => tags,
      insulin: (id, units, insulinName, tags, date, note) => tags,
      medication: (id, medicationName, medicationTime, tags, date, note) => tags,
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => tags,
      temperature: (id, temperature, tags, date, note) => tags,
      a1c: (id, a1c, tags, date, note) => tags,
      exercise: (id, exerciseType, duration, tags, date, note) => tags,
      oxygen: (id, oxygen, heartRate, tags, date, note) => tags,
      note: (id, tags, date, note) => tags,
      ketones: (id, ketones, tags, date, note) => tags,
      orElse: () => [],
    );

    print('Inserting tags: $tags'); // Debug log

    if (tags.isNotEmpty) {
      for (final tag in tags) {
        if (tag.isNotEmpty) {
          await db.insert('tags', {
            'record_id': id,
            'record_type': recordType,
            'tag': tag,
          });
        }
      }
    }

    return id;
  }

  Future<List<HealthRecord>> getAllRecords() async {
    final db = await database;
    print('Starting getAllRecords...'); // Debug log
    
    // First, let's check if the database is properly initialized
    final tables = await db.query('sqlite_master', where: "type = 'table'");
    print('Available tables: ${tables.map((t) => t['name']).join(', ')}'); // Debug log
    
    final List<Map<String, dynamic>> maps = await db.query('health_records');
    print('Raw database query result: $maps'); // Debug log
    print('Found ${maps.length} records in database'); // Debug log
    
    if (maps.isEmpty) {
      print('No records found in health_records table'); // Debug log
      return [];
    }
    
    final List<HealthRecord> records = [];

    for (final map in maps) {
      print('Processing record: ${map['type']}'); // Debug log
      print('Record data: $map'); // Debug log
      
      // Get tags for this record
      final tags = await db.query(
        'tags',
        where: 'record_id = ? AND record_type = ?',
        whereArgs: [map['id'], map['type']],
      );
      print('Found ${tags.length} tags for record ${map['id']}'); // Debug log

      // Convert tags to list, filtering out any empty tags
      final tagList = tags
          .map((t) => t['tag'] as String)
          .where((tag) => tag.isNotEmpty)
          .toList();
      
      print('Processed tags for record: $tagList'); // Debug log
      final date = DateTime.parse(map['date'] as String);
      final note = map['note'] as String?;

      try {
        switch (map['type']) {
          case 'GlucoseRecord':
            records.add(HealthRecord.glucose(
              id: map['id'] as int,
              glucose: map['glucose'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'WeightRecord':
            records.add(HealthRecord.weight(
              id: map['id'] as int,
              weight: map['weight'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'BloodPressureRecord':
            records.add(HealthRecord.bloodPressure(
              id: map['id'] as int,
              systolic: map['systolic'] as double,
              diastolic: map['diastolic'] as double,
              heartRate: map['heart_rate'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'InsulinRecord':
            records.add(HealthRecord.insulin(
              id: map['id'] as int,
              units: map['units'] as double,
              insulinName: map['insulin_name'] as String,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'MedicationRecord':
            records.add(HealthRecord.medication(
              id: map['id'] as int,
              medicationName: map['medication_name'] as String,
              medicationTime: DateTime.parse(map['medication_time'] as String),
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'CarbsRecord':
            records.add(HealthRecord.carbs(
              id: map['id'] as int,
              carbohydrates: map['carbohydrates'] as double,
              food: map['food'] as String,
              fat: map['fat'] as double,
              protein: map['protein'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'TemperatureRecord':
            records.add(HealthRecord.temperature(
              id: map['id'] as int,
              temperature: map['temperature'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'A1CRecord':
            records.add(HealthRecord.a1c(
              id: map['id'] as int,
              a1c: map['a1c'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'ExerciseRecord':
            records.add(HealthRecord.exercise(
              id: map['id'] as int,
              exerciseType: map['exercise_type'] as String,
              duration: Duration(minutes: map['duration'] as int),
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'OxygenRecord':
            records.add(HealthRecord.oxygen(
              id: map['id'] as int,
              oxygen: map['oxygen'] as double,
              heartRate: map['heart_rate'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'NoteRecord':
            records.add(HealthRecord.note(
              id: map['id'] as int,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          case 'KetonesRecord':
            records.add(HealthRecord.ketones(
              id: map['id'] as int,
              ketones: map['ketones'] as double,
              date: date,
              note: note,
              tags: tagList,
            ));
            break;
          default:
            print('Unknown record type: ${map['type']}'); // Debug log
            break;
        }
        print('Successfully processed record of type ${map['type']}'); // Debug log
      } catch (e) {
        print('Error processing record: $e'); // Debug log
        print('Record data that caused error: $map'); // Debug log
      }
    }

    print('Returning ${records.length} processed records'); // Debug log
    return records;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> updateRecord(HealthRecord record) async {
    final db = await database;
    final String recordType = record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => 'GlucoseRecord',
      weight: (id, weight, tags, date, note) => 'WeightRecord',
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) => 'BloodPressureRecord',
      insulin: (id, units, insulinName, tags, date, note) => 'InsulinRecord',
      medication: (id, medicationName, medicationTime, tags, date, note) => 'MedicationRecord',
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => 'CarbsRecord',
      temperature: (id, temperature, tags, date, note) => 'TemperatureRecord',
      a1c: (id, a1c, tags, date, note) => 'A1CRecord',
      exercise: (id, exerciseType, duration, tags, date, note) => 'ExerciseRecord',
      oxygen: (id, oxygen, heartRate, tags, date, note) => 'OxygenRecord',
      note: (id, tags, date, note) => 'NoteRecord',
      ketones: (id, ketones, tags, date, note) => 'KetonesRecord',
      orElse: () => 'UnknownRecord',
    );

    final Map<String, dynamic> data = {
      'type': recordType,
      'date': record.date?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'note': record.note ?? '',
    };

    // Add type-specific fields
    record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => data['glucose'] = glucose,
      weight: (id, weight, tags, date, note) => data['weight'] = weight,
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) {
        data['systolic'] = systolic;
        data['diastolic'] = diastolic;
        data['heart_rate'] = heartRate;
      },
      insulin: (id, units, insulinName, tags, date, note) {
        data['units'] = units;
        data['insulin_name'] = insulinName;
      },
      medication: (id, medicationName, medicationTime, tags, date, note) {
        data['medication_name'] = medicationName;
        data['medication_time'] = medicationTime.toIso8601String();
      },
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) {
        data['carbohydrates'] = carbohydrates;
        data['food'] = food;
        data['fat'] = fat;
        data['protein'] = protein;
      },
      temperature: (id, temperature, tags, date, note) => data['temperature'] = temperature,
      a1c: (id, a1c, tags, date, note) => data['a1c'] = a1c,
      exercise: (id, exerciseType, duration, tags, date, note) {
        data['exercise_type'] = exerciseType;
        data['duration'] = duration.inMinutes;
      },
      oxygen: (id, oxygen, heartRate, tags, date, note) {
        data['oxygen'] = oxygen;
        data['heart_rate'] = heartRate;
      },
      orElse: () {},
    );

    // Get the record ID from the record
    final int recordId = record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => id,
      weight: (id, weight, tags, date, note) => id,
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) => id,
      insulin: (id, units, insulinName, tags, date, note) => id,
      medication: (id, medicationName, medicationTime, tags, date, note) => id,
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => id,
      temperature: (id, temperature, tags, date, note) => id,
      a1c: (id, a1c, tags, date, note) => id,
      exercise: (id, exerciseType, duration, tags, date, note) => id,
      oxygen: (id, oxygen, heartRate, tags, date, note) => id,
      note: (id, tags, date, note) => id,
      ketones: (id, ketones, tags, date, note) => id,
      orElse: () => 0,
    );

    // Update the record
    await db.update(
      'health_records',
      data,
      where: 'id = ?',
      whereArgs: [recordId],
    );

    // Delete existing tags
    await db.delete(
      'tags',
      where: 'record_id = ? AND record_type = ?',
      whereArgs: [recordId, recordType],
    );

    // Insert new tags
    final List<String> tags = record.maybeWhen(
      glucose: (id, glucose, tags, date, note) => tags,
      weight: (id, weight, tags, date, note) => tags,
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) => tags,
      insulin: (id, units, insulinName, tags, date, note) => tags,
      medication: (id, medicationName, medicationTime, tags, date, note) => tags,
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => tags,
      temperature: (id, temperature, tags, date, note) => tags,
      a1c: (id, a1c, tags, date, note) => tags,
      exercise: (id, exerciseType, duration, tags, date, note) => tags,
      oxygen: (id, oxygen, heartRate, tags, date, note) => tags,
      note: (id, tags, date, note) => tags,
      ketones: (id, ketones, tags, date, note) => tags,
      orElse: () => [],
    );

    if (tags.isNotEmpty) {
      for (final tag in tags) {
        if (tag.isNotEmpty) {
          await db.insert('tags', {
            'record_id': recordId,
            'record_type': recordType,
            'tag': tag,
          });
        }
      }
    }
  }

  Future<bool> areDefaultTagsInitialized() async {
    final db = await database;
    final result = await db.query(
      'default_tags_initialized',
      where: 'initialized = ?',
      whereArgs: [1],
    );
    return result.isNotEmpty;
  }

  Future<void> markDefaultTagsAsInitialized() async {
    final db = await database;
    await db.insert('default_tags_initialized', {'initialized': 1});
  }

  Future<void> deleteTag(String tag) async {
    final db = await database;
    // Delete from both tables
    await db.delete(
      'tags',
      where: 'tag = ?',
      whereArgs: [tag],
    );
    await db.delete(
      'standalone_tags',
      where: 'tag = ?',
      whereArgs: [tag],
    );
  }

  Future<void> addTag(String tag) async {
    final db = await database;
    // Check if tag already exists in standalone_tags
    final existing = await db.query(
      'standalone_tags',
      where: 'tag = ?',
      whereArgs: [tag],
    );
    if (existing.isEmpty) {
      await db.insert('standalone_tags', {
        'tag': tag,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<List<String>> getAllStandaloneTags() async {
    final db = await database;
    final result = await db.query('standalone_tags');
    return result.map((row) => row['tag'] as String).toList();
  }

  // Reminder methods
  Future<int> addReminder(String recordType, DateTime day, DateTime time) async {
    final db = await database;
    return await db.insert('reminders', {
      'record_type': recordType,
      'day': day.toIso8601String(),
      'time': time.toIso8601String(),
      'is_active': 1,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getAllReminders() async {
    final db = await database;
    return await db.query('reminders', orderBy: 'day ASC, time ASC');
  }

  Future<void> updateReminder(int id, String recordType, DateTime day, DateTime time, bool isActive) async {
    final db = await database;
    await db.update(
      'reminders',
      {
        'record_type': recordType,
        'day': day.toIso8601String(),
        'time': time.toIso8601String(),
        'is_active': 1,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteReminder(int id) async {
    final db = await database;
    await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleReminderActive(int id, bool isActive) async {
    final db = await database;
    await db.update(
      'reminders',
      {'is_active': isActive ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 