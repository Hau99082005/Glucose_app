import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/utils/widgets/bm_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/health_record_provider.dart';
import '../../../../core/utils/values/colors.dart';
import '../../../../core/entities/health_record.dart';
import '../widgets/record_form.dart';
import '../../../../core/services/health_service.dart';
import '../widgets/record_type_selector.dart';
import '../constants/create_record_page_constants.dart';

@RoutePage()
class CreateRecordPage extends StatefulWidget {
  final String initialType;
  final HealthRecord? record;

  const CreateRecordPage({
    super.key,
    required this.initialType,
    this.record,
  });

  @override
  State<CreateRecordPage> createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  final GlobalKey<RecordFormState> _formKey = GlobalKey<RecordFormState>();
  final HealthService _healthService = HealthService();
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  Future<void> _writeToHealthKit(HealthRecord record) async {
    try {
      final date = record.date ?? DateTime.now();

      await record.maybeWhen(
        glucose: (id, glucose, tags, date, note) async {
          await _healthService.writeHealthData(
            HealthService.bloodGlucoseType,
            glucose,
            date ?? DateTime.now(),
            date ?? DateTime.now(),
          );
        },
        weight: (id, weight, tags, date, note) async {
          await _healthService.writeHealthData(
            HealthService.weightType,
            weight,
            date ?? DateTime.now(),
            date ?? DateTime.now(),
          );
        },
        bloodPressure:
            (id, systolic, diastolic, heartRate, tags, date, note) async {
          await _healthService.writeBloodPressure(
            systolic,
            diastolic,
            date: date ?? DateTime.now(),
          );
        },
        orElse: () async {},
      );
    } catch (e) {
      debugPrint('Error writing to HealthKit: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primary1,
      navigationBar: commonCupertinoAppBar(
        context,
        widget.record != null ? 'Edit' : 'Create Record',
        white,
        primary1,
        backButtonMode: BackButtonMode.close,
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.all(
                CreateRecordPageConstants.saveButtonPadding),
            child: Text(
              'Save',
              style: poppinsRegular.copyWith(
                color: white,
                fontSize: CreateRecordPageConstants.saveButtonFontSize,
              ),
            ),
            onPressed: () {
              _formKey.currentState?.save();
            },
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          color: grey6,
          child: Column(
            children: [
              if (widget.record == null)
                RecordTypeSelector(
                  selectedType: _selectedType,
                  onTypeSelected: (type) {
                    setState(() {
                      _selectedType = type;
                    });
                  },
                ),
              Expanded(
                child: RecordForm(
                  key: _formKey,
                  recordType: widget.record != null
                      ? widget.initialType
                      : _selectedType,
                  record: widget.record,
                  onSave: (record) async {
                    if (widget.record != null) {
                      final updatedRecord = record.maybeWhen(
                        glucose: (_, glucose, tags, date, note) =>
                            HealthRecord.glucose(
                                id: widget.record!.id,
                                glucose: glucose,
                                tags: tags,
                                date: date,
                                note: note),
                        weight: (_, weight, tags, date, note) =>
                            HealthRecord.weight(
                                id: widget.record!.id,
                                weight: weight,
                                tags: tags,
                                date: date,
                                note: note),
                        bloodPressure: (_, systolic, diastolic, heartRate, tags,
                                date, note) =>
                            HealthRecord.bloodPressure(
                                id: widget.record!.id,
                                systolic: systolic,
                                diastolic: diastolic,
                                heartRate: heartRate,
                                tags: tags,
                                date: date,
                                note: note),
                        insulin: (_, units, insulinName, tags, date, note) =>
                            HealthRecord.insulin(
                                id: widget.record!.id,
                                units: units,
                                insulinName: insulinName,
                                tags: tags,
                                date: date,
                                note: note),
                        medication: (_, medicationName, medicationTime, tags,
                                date, note) =>
                            HealthRecord.medication(
                                id: widget.record!.id,
                                medicationName: medicationName,
                                medicationTime: medicationTime,
                                tags: tags,
                                date: date,
                                note: note),
                        carbs: (_, carbohydrates, food, fat, protein, tags,
                                date, note) =>
                            HealthRecord.carbs(
                                id: widget.record!.id,
                                carbohydrates: carbohydrates,
                                food: food,
                                fat: fat,
                                protein: protein,
                                tags: tags,
                                date: date,
                                note: note),
                        temperature: (_, temperature, tags, date, note) =>
                            HealthRecord.temperature(
                                id: widget.record!.id,
                                temperature: temperature,
                                tags: tags,
                                date: date,
                                note: note),
                        a1c: (_, a1c, tags, date, note) => HealthRecord.a1c(
                            id: widget.record!.id,
                            a1c: a1c,
                            tags: tags,
                            date: date,
                            note: note),
                        exercise:
                            (_, exerciseType, duration, tags, date, note) =>
                                HealthRecord.exercise(
                                    id: widget.record!.id,
                                    exerciseType: exerciseType,
                                    duration: duration,
                                    tags: tags,
                                    date: date,
                                    note: note),
                        oxygen: (_, oxygen, heartRate, tags, date, note) =>
                            HealthRecord.oxygen(
                                id: widget.record!.id,
                                oxygen: oxygen,
                                heartRate: heartRate,
                                tags: tags,
                                date: date,
                                note: note),
                        note: (_, tags, date, note) => HealthRecord.note(
                            id: widget.record!.id,
                            tags: tags,
                            date: date,
                            note: note),
                        ketones: (_, ketones, tags, date, note) =>
                            HealthRecord.ketones(
                                id: widget.record!.id,
                                ketones: ketones,
                                tags: tags,
                                date: date,
                                note: note),
                        orElse: () => record,
                      );
                      await context
                          .read<HealthRecordProvider>()
                          .updateRecord(updatedRecord);
                      await _writeToHealthKit(updatedRecord);
                    } else {
                      await context
                          .read<HealthRecordProvider>()
                          .addRecord(record);
                      await _writeToHealthKit(record);
                    }
                    if (mounted) {
                      await context
                          .read<HealthRecordProvider>()
                          .loadAllRecords();
                      context.router.pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
