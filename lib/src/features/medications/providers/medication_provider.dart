import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/features/medications/models/medication.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MedicationProvider extends ChangeNotifier {
  List<Medication> _medications = [];
  List<String> _medicationNames = [];
  bool _isLoading = false;

  List<Medication> get medications => _medications;
  List<String> get medicationNames => _medicationNames;
  bool get isLoading => _isLoading;

  MedicationProvider() {
    _loadMedicationNames();
    _loadMedications();
  }

  // Load medication names from assets/meds.json
  Future<void> _loadMedicationNames() async {
    try {
      final String response = await rootBundle.loadString('assets/meds.json');
      final data = await json.decode(response);
      _medicationNames = List<String>.from(data);
      notifyListeners();
    } catch (e) {
      print('Error loading medication names: $e');
      // Provide some default medication names if the file can't be loaded
      _medicationNames = [
        'Metformin',
        'Insulin Glargine',
        'Insulin Lispro',
        'Aspirin',
        'Atorvastatin',
        'Lisinopril',
        'Metoprolol',
        'Amlodipine',
        'Omeprazole',
        'Albuterol',
      ];
      notifyListeners();
    }
  }

  // Load medications from local storage
  Future<void> _loadMedications() async {
    _isLoading = true;
    notifyListeners();

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/meds.json');
      
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> data = json.decode(contents);
        _medications = data.map((item) => Medication.fromMap(item)).toList();
      }
    } catch (e) {
      print('Error loading medications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save medications to local storage
  Future<void> _saveMedications() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/meds.json');
      
      final List<Map<String, dynamic>> data = 
          _medications.map((med) => med.toMap()).toList();
      
      await file.writeAsString(json.encode(data));
    } catch (e) {
      print('Error saving medications: $e');
    }
  }

  // Add a new medication
  Future<void> addMedication(Medication medication) async {
    // Generate a new ID if needed
    final newId = _medications.isEmpty ? 1 : 
        _medications.map((m) => m.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    
    final newMedication = medication.copyWith(id: newId);
    _medications.add(newMedication);
    await _saveMedications();
    notifyListeners();
  }

  // Update an existing medication
  Future<void> updateMedication(Medication medication) async {
    final index = _medications.indexWhere((m) => m.id == medication.id);
    if (index != -1) {
      _medications[index] = medication;
      await _saveMedications();
      notifyListeners();
    }
  }

  // Delete a medication
  Future<void> deleteMedication(int id) async {
    _medications.removeWhere((m) => m.id == id);
    await _saveMedications();
    notifyListeners();
  }

  // Get a medication by ID
  Medication? getMedicationById(int id) {
    try {
      return _medications.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }
} 