import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogTypesPage extends StatefulWidget {
  const LogTypesPage({super.key});

  @override
  State<LogTypesPage> createState() => _LogTypesPageState();
}

class _LogTypesPageState extends State<LogTypesPage> {
  final List<String> _logTypes = [
    'Glucose',
    'Weight',
    'Blood Pressure',
    'Insulin',
    'Medication',
    'Carbs',
    'Temperature',
    'A1C',
    'Exercise',
    'Oxygen',
    'Note',
    'Ketones',
  ];

  Set<String> _selectedTypes = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedTypes();
  }

  Future<void> _loadSelectedTypes() async {
    final prefs = await SharedPreferences.getInstance();
    final selected = prefs.getStringList('selected_log_types') ?? _logTypes;
    if (mounted) {
      setState(() {
        _selectedTypes = Set<String>.from(selected);
      });
    }
  }

  Future<void> _toggleType(String type) async {
    if (type == 'Glucose') return; // Glucose cannot be toggled

    final newSelectedTypes = Set<String>.from(_selectedTypes);
    if (newSelectedTypes.contains(type)) {
      newSelectedTypes.remove(type);
    } else {
      newSelectedTypes.add(type);
    }

    setState(() {
      _selectedTypes = newSelectedTypes;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_log_types', _selectedTypes.toList());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: grey6,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Show/Hide Log Types'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              children: _logTypes.map((type) {
                final isGlucose = type == 'Glucose';
                final isSelected = _selectedTypes.contains(type) || isGlucose;
                return CupertinoListTile(
                  title: Text(
                    type,
                    style: poppinsRegular.copyWith(
                      fontSize: 16,
                      color: isGlucose ? CupertinoColors.systemGrey : null,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          CupertinoIcons.check_mark,
                          color: isGlucose
                              ? CupertinoColors.systemGrey
                              : CupertinoColors.activeBlue,
                          size: 20,
                        )
                      : null,
                  onTap: isGlucose ? null : () => _toggleType(type),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
