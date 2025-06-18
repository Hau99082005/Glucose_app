// App-wide constants
class AppConstants {
  // Database
  static const String databaseName = 'health_records.db';
  static const int databaseVersion = 3;

  // Time ranges for history segments
  static const Map<int, int> timeRanges = {
    0: 3, // 3 days
    1: 7, // 7 days
    2: 14, // 14 days
    3: 30, // 30 days
    4: 90, // 90 days
  };

  // Default tags
  static const List<String> defaultTags = [
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

  // Record types
  static const List<String> recordTypes = [
    'Glucose',
    'Weight',
    'Blood Pressure',
    'Insulin',
    'Medications',
    'Carbs',
    'Temperature',
    'A1C',
    'Exercise',
    'Oxygen',
    'Notes',
    'Ketones',
  ];

  // Record type icons
  static const Map<String, String> recordTypeIcons = {
    'Glucose': 'assets/icons/menu_glucose.png',
    'Weight': 'assets/icons/menu_weight.png',
    'Blood Pressure': 'assets/icons/menu_blood_pressure.png',
    'Insulin': 'assets/icons/menu_insulin.png',
    'Medications': 'assets/icons/menu_medication.png',
    'Carbs': 'assets/icons/menu_carbs.png',
    'Temperature': 'assets/icons/menu_temperature.png',
    'A1C': 'assets/icons/menu_a1c.png',
    'Exercise': 'assets/icons/menu_exercise.png',
    'Oxygen': 'assets/icons/menu_oxygen.png',
    'Notes': 'assets/icons/menu_notes.png',
    'Ketones': 'assets/icons/menu_ketones.png',
  };

  // Date formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';

  // Units
  static const String glucoseUnit = 'mg/dL';
  static const String weightUnit = 'kg';
  static const String bloodPressureUnit = 'mmHg';
  static const String temperatureUnit = '°C';
  static const String oxygenUnit = '%';
  static const String ketonesUnit = 'mmol/L';

  // Padding and spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;

  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}
