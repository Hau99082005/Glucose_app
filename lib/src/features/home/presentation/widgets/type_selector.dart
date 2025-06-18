import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:provider/provider.dart';

class TypeSelector extends StatelessWidget {
  final String? selectedType;
  final Function(String?) onTypeSelected;

  const TypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      color: CupertinoColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                ),
              ),
            ),
            child: Text(
              'Select Type',
              style: poppinsRegular.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Consumer<HealthRecordProvider>(
            builder: (context, provider, child) {
              final records = provider.records;
              final recordTypes = records
                  .map((record) => record.maybeWhen(
                        glucose: (id, glucose, tags, date, note) => 'Glucose',
                        weight: (id, weight, tags, date, note) => 'Weight',
                        bloodPressure: (id, systolic, diastolic, heartRate,
                                tags, date, note) =>
                            'Blood Pressure',
                        insulin: (id, units, insulinName, tags, date, note) =>
                            'Insulin',
                        medication: (id, medicationName, medicationTime, tags,
                                date, note) =>
                            'Medications',
                        carbs: (id, carbohydrates, food, fat, protein, tags,
                                date, note) =>
                            'Carbs',
                        temperature: (id, temperature, tags, date, note) =>
                            'Temperature',
                        a1c: (id, a1c, tags, date, note) => 'A1C',
                        exercise:
                            (id, exerciseType, duration, tags, date, note) =>
                                'Exercise',
                        oxygen: (id, oxygen, heartRate, tags, date, note) =>
                            'Oxygen',
                        note: (id, tags, date, note) => 'Notes',
                        ketones: (id, ketones, tags, date, note) => 'Ketones',
                        orElse: () => '',
                      ))
                  .where((type) => type.isNotEmpty)
                  .toSet()
                  .toList();
              recordTypes.sort();
              recordTypes.insert(0, 'All Logs');
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 32),
                itemCount: recordTypes.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final type = recordTypes[index];
                  return CupertinoListTile(
                    title: Text(type),
                    onTap: () {
                      onTypeSelected(type == 'All Logs' ? null : type);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
