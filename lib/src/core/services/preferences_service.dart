import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _nonFastingMinKey = 'non_fasting_min';
  static const String _nonFastingMaxKey = 'non_fasting_max';
  static const String _fastingMinKey = 'fasting_min';
  static const String _fastingMaxKey = 'fasting_max';
  static const String _glucoseUnitKey = 'glucose_unit';
  static const String _weightUnitKey = 'weight_unit';
  static const String _hideQuickAddButtonKey = 'hide_quick_add_button';
  static const String _hideNotePreviewKey = 'hide_note_preview';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  // Non-fasting range
  double get nonFastingMin => _prefs.getDouble(_nonFastingMinKey) ?? 60.0;
  double get nonFastingMax => _prefs.getDouble(_nonFastingMaxKey) ?? 200.0;

  Future<void> setNonFastingRange(double min, double max) async {
    await _prefs.setDouble(_nonFastingMinKey, min);
    await _prefs.setDouble(_nonFastingMaxKey, max);
  }

  // Fasting range
  double get fastingMin => _prefs.getDouble(_fastingMinKey) ?? 60.0;
  double get fastingMax => _prefs.getDouble(_fastingMaxKey) ?? 200.0;

  Future<void> setFastingRange(double min, double max) async {
    await _prefs.setDouble(_fastingMinKey, min);
    await _prefs.setDouble(_fastingMaxKey, max);
  }

  // Glucose unit
  String get glucoseUnit => _prefs.getString(_glucoseUnitKey) ?? 'mg/dL';

  Future<void> setGlucoseUnit(String unit) async {
    await _prefs.setString(_glucoseUnitKey, unit);
  }

  // Weight unit
  String get weightUnit => _prefs.getString(_weightUnitKey) ?? 'kgs';

  Future<void> setWeightUnit(String unit) async {
    await _prefs.setString(_weightUnitKey, unit);
  }

  // Hide quick add button
  bool get hideQuickAddButton => _prefs.getBool(_hideQuickAddButtonKey) ?? false;

  Future<void> setHideQuickAddButton(bool value) async {
    await _prefs.setBool(_hideQuickAddButtonKey, value);
  }

  bool get hideNotePreview => _prefs.getBool(_hideNotePreviewKey) ?? false;

  Future<void> setHideNotePreview(bool value) async {
    await _prefs.setBool(_hideNotePreviewKey, value);
  }
} 