import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/constants/app_constants.dart';
import 'package:flutter_app/src/features/home/presentation/constants/history_page_constants.dart';

class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;
  final VoidCallback onTap;

  const HealthRecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: HistoryPageConstants.recordCardMargin),
      decoration: BoxDecoration(
        color: white,
        borderRadius:
            BorderRadius.circular(HistoryPageConstants.recordCardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: HistoryPageConstants.recordCardShadowBlur,
            offset: HistoryPageConstants.recordCardShadowOffset,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: HistoryPageConstants.recordCardPadding),
        child: CupertinoListTile(
          leading: Image.asset(
            AppConstants.recordTypeIcons[record.when(
                  glucose: (id, glucose, tags, date, note) => 'Glucose',
                  weight: (id, weight, tags, date, note) => 'Weight',
                  bloodPressure:
                      (id, systolic, diastolic, heartRate, tags, date, note) =>
                          'Blood Pressure',
                  insulin: (id, units, insulinName, tags, date, note) =>
                      'Insulin',
                  medication:
                      (id, medicationName, medicationTime, tags, date, note) =>
                          'Medications',
                  carbs: (id, carbohydrates, food, fat, protein, tags, date,
                          note) =>
                      'Carbs',
                  temperature: (id, temperature, tags, date, note) =>
                      'Temperature',
                  a1c: (id, a1c, tags, date, note) => 'A1C',
                  exercise: (id, exerciseType, duration, tags, date, note) =>
                      'Exercise',
                  oxygen: (id, oxygen, heartRate, tags, date, note) => 'Oxygen',
                  note: (id, tags, date, note) => 'Notes',
                  ketones: (id, ketones, tags, date, note) => 'Ketones',
                )] ??
                '',
          ),
          title: record.when(
            glucose: (id, glucose, tags, date, note) =>
                Text('$glucose mg/dL', style: poppinsMedium),
            weight: (id, weight, tags, date, note) =>
                Text('$weight kg', style: poppinsMedium),
            bloodPressure:
                (id, systolic, diastolic, heartRate, tags, date, note) =>
                    Text('$systolic/$diastolic mmHg', style: poppinsMedium),
            insulin: (id, units, insulinName, tags, date, note) =>
                Text('$units units - $insulinName', style: poppinsMedium),
            medication:
                (id, medicationName, medicationTime, tags, date, note) =>
                    Text(medicationName, style: poppinsMedium),
            carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
                Text('${carbohydrates}g carbs - $food', style: poppinsMedium),
            temperature: (id, temperature, tags, date, note) =>
                Text('$temperature°C', style: poppinsMedium),
            a1c: (id, a1c, tags, date, note) =>
                Text('A1C: $a1c%', style: poppinsMedium),
            exercise: (id, exerciseType, duration, tags, date, note) => Text(
                '$exerciseType - ${duration.inMinutes}min',
                style: poppinsMedium),
            oxygen: (id, oxygen, heartRate, tags, date, note) =>
                Text('O2: $oxygen%', style: poppinsMedium),
            note: (id, tags, date, note) =>
                Text(note ?? '', style: poppinsMedium),
            ketones: (id, ketones, tags, date, note) =>
                Text('$ketones mmol/L', style: poppinsMedium),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              record.when(
                glucose: (id, glucose, tags, date, note) =>
                    const SizedBox.shrink(),
                weight: (id, weight, tags, date, note) =>
                    const SizedBox.shrink(),
                bloodPressure:
                    (id, systolic, diastolic, heartRate, tags, date, note) =>
                        Text('Pulse: $heartRate bpm',
                            style: poppinsRegular.copyWith(fontSize: 14)),
                insulin: (id, units, insulinName, tags, date, note) =>
                    const SizedBox.shrink(),
                medication:
                    (id, medicationName, medicationTime, tags, date, note) =>
                        const SizedBox.shrink(),
                carbs:
                    (id, carbohydrates, food, fat, protein, tags, date, note) =>
                        Text('Fat: ${fat}g, Protein: ${protein}g',
                            style: poppinsRegular.copyWith(fontSize: 14)),
                temperature: (id, temperature, tags, date, note) =>
                    const SizedBox.shrink(),
                a1c: (id, a1c, tags, date, note) => const SizedBox.shrink(),
                exercise: (id, exerciseType, duration, tags, date, note) =>
                    const SizedBox.shrink(),
                oxygen: (id, oxygen, heartRate, tags, date, note) => Text(
                    'Pulse: $heartRate bpm',
                    style: poppinsRegular.copyWith(fontSize: 14)),
                note: (id, tags, date, note) => const SizedBox.shrink(),
                ketones: (id, ketones, tags, date, note) =>
                    const SizedBox.shrink(),
              ),
              if (record.tags.isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: record.tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  HistoryPageConstants.tagContainerPadding,
                              vertical:
                                  HistoryPageConstants.tagContainerPadding,
                            ),
                            decoration: BoxDecoration(
                              color: primary1.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  HistoryPageConstants
                                      .tagContainerBorderRadius),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: HistoryPageConstants.tagTextSize,
                                color: primary1,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
          trailing: Text(
            _formatTime(record.date ?? DateTime.now()),
            style: poppinsRegular.copyWith(fontSize: 14),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
