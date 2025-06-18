import 'package:shared_preferences/shared_preferences.dart';

class GlucoseCalculator {
  static const String _glucoseUnitKey = 'glucose_unit';
  static const String _mgdl = 'mg/dL';
  static const String _mmol = 'mmol/L';

  static Future<String> getGlucoseUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_glucoseUnitKey) ?? _mgdl;
  }

  static Future<void> setGlucoseUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_glucoseUnitKey, unit);
  }

  static Future<double> calculateEstimatedA1C(List<double> glucoseValues) async {
    if (glucoseValues.isEmpty) return 0.0;

    // Calculate average glucose
    final averageGlucose = glucoseValues.reduce((a, b) => a + b) / glucoseValues.length;

    // Get the current unit
    final unit = await getGlucoseUnit();

    // Calculate eAG based on unit
    double eAG;
    if (unit == _mgdl) {
      eAG = averageGlucose;
    } else {
      // Convert mmol/L to mg/dL
      eAG = averageGlucose * 18.015;
    }

    // Calculate estimated A1C
    final estimatedA1C = (eAG + 46.7) / 28.7;

    // Return with 2 decimal places
    return double.parse(estimatedA1C.toStringAsFixed(2));
  }
} 