import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart' as auto_route;
import 'package:flutter_app/src/core/utils/mapper/date_time_mapper.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/utils/widgets/bm_text_field.dart';
import '../../../../core/entities/health_record.dart';
import '../../../../core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';

class RecordForm extends StatefulWidget {
  final String recordType;
  final HealthRecord? record;
  final Function(HealthRecord) onSave;

  const RecordForm({
    super.key,
    required this.recordType,
    required this.onSave,
    this.record,
  });

  @override
  RecordFormState createState() => RecordFormState();
}

class RecordFormState extends State<RecordForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedTags = [];
  List<String> _mostUsedTags = [];
  late DateTime _selectedDate;
  late DateTime _selectedTime;
  late Duration _selectedDuration;

  // Form controllers for each record type
  final _glucoseController = TextEditingController();
  final _weightController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _insulinUnitsController = TextEditingController();
  final _insulinNameController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _carbsController = TextEditingController();
  final _foodController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _a1cController = TextEditingController();
  final _exerciseTypeController = TextEditingController();
  final _oxygenController = TextEditingController();
  final _noteController = TextEditingController();
  final _ketonesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.record?.date ?? DateTime.now();
    _selectedTime = widget.record?.date ?? DateTime.now();
    _selectedDuration = const Duration(minutes: 30);

    _loadMostUsedTags();

    if (widget.record != null) {
      _initializeFormWithRecord();
    }
  }

  void _initializeFormWithRecord() {
    widget.record?.maybeWhen(
      glucose: (id, glucose, tags, date, note) {
        _glucoseController.text = glucose.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      weight: (id, weight, tags, date, note) {
        _weightController.text = weight.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) {
        _systolicController.text = systolic.toString();
        _diastolicController.text = diastolic.toString();
        _heartRateController.text = heartRate.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      insulin: (id, units, insulinName, tags, date, note) {
        _insulinUnitsController.text = units.toString();
        _insulinNameController.text = insulinName;
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      medication: (id, medicationName, medicationTime, tags, date, note) {
        _medicationNameController.text = medicationName;
        _selectedTime = medicationTime;
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) {
        _carbsController.text = carbohydrates.toString();
        _foodController.text = food;
        _fatController.text = fat.toString();
        _proteinController.text = protein.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      temperature: (id, temperature, tags, date, note) {
        _temperatureController.text = temperature.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      a1c: (id, a1c, tags, date, note) {
        _a1cController.text = a1c.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      exercise: (id, exerciseType, duration, tags, date, note) {
        _exerciseTypeController.text = exerciseType;
        _selectedDuration = duration;
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      oxygen: (id, oxygen, heartRate, tags, date, note) {
        _oxygenController.text = oxygen.toString();
        _heartRateController.text = heartRate.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      note: (id, tags, date, note) {
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      ketones: (id, ketones, tags, date, note) {
        _ketonesController.text = ketones.toString();
        _noteController.text = note ?? '';
        _selectedTags.addAll(tags);
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _glucoseController.dispose();
    _weightController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _insulinUnitsController.dispose();
    _insulinNameController.dispose();
    _medicationNameController.dispose();
    _carbsController.dispose();
    _foodController.dispose();
    _fatController.dispose();
    _proteinController.dispose();
    _temperatureController.dispose();
    _a1cController.dispose();
    _exerciseTypeController.dispose();
    _oxygenController.dispose();
    _noteController.dispose();
    _ketonesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTypeSpecificFields(),
                const SizedBox(height: 16),
                _buildDateField(),
                const SizedBox(height: 16),
                _buildNoteField(),
                _buildTagsFields()
              ],
            )),
      ),
    );
  }

  String? Function(String?)? validator(String label, TextInputType inputType) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a $label';
      }
      if (inputType == TextInputType.number) {
        final num = double.tryParse(value);
        if (num == null || num < 0) {
          return 'Please enter a valid $label';
        }
      }
      return null;
    };
  }

  Widget _buildTypeSpecificFields() {
    switch (widget.recordType.toLowerCase()) {
      case 'glucose':
        return BMTextField(
          label: 'Glucose',
          placeholder: 'mg/dL',
          keyboardType: TextInputType.number,
          controller: _glucoseController,
          validator: validator('glucose', TextInputType.number),
        );
      case 'weight':
        return BMTextField(
          label: 'Weight',
          placeholder: 'kg',
          keyboardType: TextInputType.number,
          controller: _weightController,
          validator: validator('weight', TextInputType.number),
        );
      case 'blood pressure':
        return Column(
          children: [
            BMTextField(
              label: 'Systolic',
              placeholder: 'mmHg',
              keyboardType: TextInputType.number,
              controller: _systolicController,
              validator: validator('systolic', TextInputType.number),
            ),
            BMTextField(
              label: 'Diastolic',
              placeholder: 'mmHg',
              keyboardType: TextInputType.number,
              controller: _diastolicController,
              validator: validator('diastolic', TextInputType.number),
            ),
            BMTextField(
                label: 'Heart Rate',
                placeholder: 'Optional',
                keyboardType: TextInputType.number,
                controller: _heartRateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null; // optional
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null) {
                    return 'Please enter a valid number for heart rate';
                  }
                  return null;
                }),
          ],
        );
      case 'insulin':
        return BMTextField(
          label: 'Insulin',
          placeholder: 'Enter insulin units',
          keyboardType: TextInputType.number,
          controller: _insulinUnitsController,
          validator: validator('insulin units', TextInputType.number),
        );
      case 'medication':
        return BMTextField(
          label: 'Medication',
          placeholder: 'Enter medication name',
          controller: _medicationNameController,
          validator: validator('medication name', TextInputType.text),
        );
      case 'carbs':
        return Column(
          children: [
            BMTextField(
              label: 'Carbs',
              placeholder: 'Enter carbohydrates',
              keyboardType: TextInputType.number,
              controller: _carbsController,
              validator: validator('carbohydrates', TextInputType.number),
            ),
          ],
        );
      case 'temperature':
        return BMTextField(
          label: 'Temperature',
          placeholder: 'Enter temperature',
          keyboardType: TextInputType.number,
          controller: _temperatureController,
          validator: validator('temperature', TextInputType.number),
        );
      case 'a1c':
        return BMTextField(
          label: 'A1C',
          placeholder: 'Enter A1C',
          keyboardType: TextInputType.number,
          controller: _a1cController,
          validator: validator('a1c', TextInputType.number),
        );
      case 'exercise':
        return BMTextField(
          label: 'Exercise',
          placeholder: 'Enter exercise type',
          controller: _exerciseTypeController,
          validator: validator('exercise type', TextInputType.text),
        );
      case 'oxygen':
        return BMTextField(
          label: 'Oxygen',
          placeholder: 'Enter oxygen level',
          keyboardType: TextInputType.number,
          controller: _oxygenController,
          validator: validator('oxygen level', TextInputType.number),
        );
      case 'ketones':
        return BMTextField(
          label: 'Ketones',
          placeholder: 'Enter ketones level',
          keyboardType: TextInputType.number,
          controller: _ketonesController,
          validator: validator('ketones level', TextInputType.number),
        );
      default:
        return Container();
    }
  }

  Widget _buildDateField() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: grey6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date', style: poppinsRegular),
            Text(
                formatDayHeader(_selectedDate,
                    hasTime: widget.record != null, hasNow: true),
                style: poppinsRegular),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteField() {
    return CupertinoTextFormFieldRow(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      controller: _noteController,
      placeholder: 'Note (optional)',
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      maxLines: 3,
    );
  }

  Widget _buildTagsFields() {
    return Container(
        color: grey6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedTags.isNotEmpty)
              Container(
                  color: grey6,
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
                  child: Text('Tags',
                      style:
                          poppinsRegular.copyWith(fontSize: 13, color: grey))),
            if (_selectedTags.isNotEmpty)
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedTags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tag,
                              style: poppinsRegular.copyWith(fontSize: 13)),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTags.remove(tag);
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.xmark_circle_fill,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (_mostUsedTags.isNotEmpty)
              Container(
                  color: grey6,
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
                  child: Text('MOST USED TAGS',
                      style:
                          poppinsRegular.copyWith(fontSize: 13, color: grey))),
            if (_mostUsedTags.isNotEmpty)
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _mostUsedTags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_selectedTags.contains(tag)) return;
                              setState(() {
                                _selectedTags.add(tag);
                              });
                            },
                            child: Text(tag,
                                style: poppinsRegular.copyWith(fontSize: 13)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (_mostUsedTags.isNotEmpty)
              Container(
                  color: grey6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text('Tap to quick add tags',
                      style:
                          poppinsRegular.copyWith(fontSize: 11, color: grey))),
            Container(
              color: white,
              margin: const EdgeInsets.only(top: 24),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onPressed: () => _showTagSelectionModal(context),
                child: Text('Add Tag',
                    style: poppinsRegular.copyWith(
                        fontSize: 13, color: blue203C6F)),
              ),
            ),
          ],
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: false,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _showTagSelectionModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: textColor,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Select Tags',
                    style: poppinsRegular.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.add_circled,
                      color: textColor,
                      size: 24,
                    ),
                    onPressed: () => _showCreateTagModal(context),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<HealthRecordProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<List<String>>(
                    future: provider.getAllTags(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error loading tags: ${snapshot.error}',
                            style: poppinsRegular.copyWith(
                              color: CupertinoColors.destructiveRed,
                            ),
                          ),
                        );
                      }
                      final allTags = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: allTags.length,
                        itemBuilder: (context, index) {
                          final tag = allTags[index];
                          return Dismissible(
                            key: Key(tag),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: CupertinoColors.destructiveRed,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: CupertinoColors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                _selectedTags.remove(tag);
                              });
                              context
                                  .read<HealthRecordProvider>()
                                  .deleteTag(tag);
                            },
                            child: CupertinoListTile(
                              title: Text(tag),
                              trailing: _selectedTags.contains(tag)
                                  ? Icon(
                                      CupertinoIcons.check_mark,
                                      color: primary1,
                                    )
                                  : null,
                              onTap: () {
                                setState(() {
                                  if (_selectedTags.contains(tag)) {
                                    _selectedTags.remove(tag);
                                  } else {
                                    _selectedTags.add(tag);
                                  }
                                });
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTagModal(BuildContext context) {
    final tagController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: CupertinoColors.systemBackground,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create New Tag',
                style: poppinsRegular.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: tagController,
                placeholder: 'Enter tag name',
                autofocus: true,
                style: poppinsRegular,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'Cancel',
                      style: poppinsRegular.copyWith(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'Create',
                      style: poppinsRegular.copyWith(
                        color: primary1,
                      ),
                    ),
                    onPressed: () async {
                      if (tagController.text.isNotEmpty) {
                        final provider = context.read<HealthRecordProvider>();
                        await provider.addTag(tagController.text);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  HealthRecord _createRecord() {
    final now = DateTime.now();
    final date = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedDate.hour,
      _selectedDate.minute,
    );

    switch (widget.recordType.toLowerCase()) {
      case 'glucose':
        return HealthRecord.glucose(
          id: 0,
          glucose: double.parse(_glucoseController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'weight':
        return HealthRecord.weight(
          id: 0,
          weight: double.parse(_weightController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'blood pressure':
        return HealthRecord.bloodPressure(
          id: 0,
          systolic: double.parse(_systolicController.text),
          diastolic: double.parse(_diastolicController.text),
          heartRate: double.tryParse(_heartRateController.text) ?? 0.0,
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'insulin':
        return HealthRecord.insulin(
          id: 0,
          units: double.parse(_insulinUnitsController.text),
          insulinName: _insulinNameController.text,
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'medication':
        return HealthRecord.medication(
          id: 0,
          medicationName: _medicationNameController.text,
          medicationTime: _selectedTime,
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'carbs':
        return HealthRecord.carbs(
          id: 0,
          carbohydrates: double.parse(_carbsController.text),
          food: _foodController.text,
          fat: double.parse(_fatController.text),
          protein: double.parse(_proteinController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'temperature':
        return HealthRecord.temperature(
          id: 0,
          temperature: double.parse(_temperatureController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'a1c':
        return HealthRecord.a1c(
          id: 0,
          a1c: double.parse(_a1cController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'exercise':
        return HealthRecord.exercise(
          id: 0,
          exerciseType: _exerciseTypeController.text,
          duration: _selectedDuration,
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'oxygen':
        return HealthRecord.oxygen(
          id: 0,
          oxygen: double.parse(_oxygenController.text),
          heartRate: double.parse(_heartRateController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      case 'ketones':
        return HealthRecord.ketones(
          id: 0,
          ketones: double.parse(_ketonesController.text),
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
      default:
        return HealthRecord.note(
          id: 0,
          date: date,
          note: _noteController.text,
          tags: _selectedTags,
        );
    }
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      final record = _createRecord();
      widget.onSave(record);
    }
  }

  void _loadMostUsedTags() {
    final provider = context.read<HealthRecordProvider>();
    final allRecords = provider.records;

    final tagCount = <String, int>{};

    for (final record in allRecords) {
      for (final tag in record.tags) {
        tagCount[tag] = (tagCount[tag] ?? 0) + 1;
      }
    }

    final sortedTags = tagCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    setState(() {
      _mostUsedTags = sortedTags.take(5).map((e) => e.key).toList();
    });
  }
}
