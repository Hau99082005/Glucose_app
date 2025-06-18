import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../entities/health_record.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';
import '../utils/values/font_awesome_icons.dart';

class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;
  final VoidCallback? onTap;

  const HealthRecordCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
        decoration: AppTheme.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppConstants.smallPadding),
              _buildContent(),
              if (record.tags.isNotEmpty) ...[
                const SizedBox(height: AppConstants.smallPadding),
                _buildTags(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final recordType = record.when(
      glucose: (id, glucose, tags, date, note) => 'Glucose',
      weight: (id, weight, tags, date, note) => 'Weight',
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
          'Blood Pressure',
      insulin: (id, units, insulinName, tags, date, note) => 'Insulin',
      medication: (id, medicationName, medicationTime, tags, date, note) =>
          'Medications',
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
          'Carbs',
      temperature: (id, temperature, tags, date, note) => 'Temperature',
      a1c: (id, a1c, tags, date, note) => 'A1C',
      exercise: (id, exerciseType, duration, tags, date, note) => 'Exercise',
      oxygen: (id, oxygen, heartRate, tags, date, note) => 'Oxygen',
      note: (id, tags, date, note) => 'Notes',
      ketones: (id, ketones, tags, date, note) => 'Ketones',
    );

    final iconCode = recordType == 'Glucose'
        ? FontAwesomeIcons.droplet
        : recordType == 'Weight'
            ? FontAwesomeIcons.weightScale
            : recordType == 'Blood Pressure'
                ? FontAwesomeIcons.arrowUpFromWaterPump
                : recordType == 'Insulin'
                    ? FontAwesomeIcons.syringe
                    : recordType == 'Medications'
                        ? FontAwesomeIcons.bandage
                        : recordType == 'Carbs'
                            ? FontAwesomeIcons.wheat
                            : recordType == 'Temperature'
                                ? FontAwesomeIcons.temperature
                                : recordType == 'A1C'
                                    ? FontAwesomeIcons.oxygen
                                    : recordType == 'Exercise'
                                        ? FontAwesomeIcons.exercise
                                        : recordType == 'Oxygen'
                                            ? FontAwesomeIcons.oxygen
                                            : recordType == 'Notes'
                                                ? FontAwesomeIcons.note
                                                : FontAwesomeIcons.oxygen;

    return Row(
      children: [
        Text(
          iconCode,
          style: const TextStyle(
            fontFamily: 'FontAwesome6ProLight',
            color: AppTheme.primaryColor,
            fontSize: AppConstants.defaultIconSize,
          ),
        ),
        const SizedBox(width: AppConstants.smallPadding),
        Expanded(
          child: Text(
            recordType,
            style: AppTheme.heading3,
          ),
        ),
        Text(
          _formatTime(record.date ?? DateTime.now()),
          style: AppTheme.caption,
        ),
      ],
    );
  }

  Widget _buildContent() {
    return record.when(
      glucose: (id, glucose, tags, date, note) => Text(
        '$glucose ${AppConstants.glucoseUnit}',
        style: AppTheme.body1,
      ),
      weight: (id, weight, tags, date, note) => Text(
        '$weight ${AppConstants.weightUnit}',
        style: AppTheme.body1,
      ),
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$systolic/$diastolic ${AppConstants.bloodPressureUnit}',
            style: AppTheme.body1,
          ),
          Text(
            'Pulse: $heartRate bpm',
            style: AppTheme.body2,
          ),
        ],
      ),
      insulin: (id, units, insulinName, tags, date, note) => Text(
        '$units units - $insulinName',
        style: AppTheme.body1,
      ),
      medication: (id, medicationName, medicationTime, tags, date, note) =>
          Text(
        medicationName,
        style: AppTheme.body1,
      ),
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${carbohydrates}g carbs - $food',
            style: AppTheme.body1,
          ),
          Text(
            'Fat: ${fat}g, Protein: ${protein}g',
            style: AppTheme.body2,
          ),
        ],
      ),
      temperature: (id, temperature, tags, date, note) => Text(
        '$temperature${AppConstants.temperatureUnit}',
        style: AppTheme.body1,
      ),
      a1c: (id, a1c, tags, date, note) => Text(
        'A1C: $a1c%',
        style: AppTheme.body1,
      ),
      exercise: (id, exerciseType, duration, tags, date, note) => Text(
        '$exerciseType - ${duration.inMinutes}min',
        style: AppTheme.body1,
      ),
      oxygen: (id, oxygen, heartRate, tags, date, note) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'O2: $oxygen${AppConstants.oxygenUnit}',
            style: AppTheme.body1,
          ),
          Text(
            'Pulse: $heartRate bpm',
            style: AppTheme.body2,
          ),
        ],
      ),
      note: (id, tags, date, note) => Text(
        note ?? '',
        style: AppTheme.body1,
      ),
      ketones: (id, ketones, tags, date, note) => Text(
        '$ketones ${AppConstants.ketonesUnit}',
        style: AppTheme.body1,
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: AppConstants.smallPadding,
      runSpacing: AppConstants.smallPadding,
      children: record.tags
          .map((tag) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.smallPadding,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppConstants.defaultBorderRadius),
                ),
                child: Text(
                  tag,
                  style:
                      AppTheme.caption.copyWith(color: AppTheme.primaryColor),
                ),
              ))
          .toList(),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
