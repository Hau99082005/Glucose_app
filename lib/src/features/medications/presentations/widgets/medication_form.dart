import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/medications/models/medication.dart';
import 'package:flutter_app/src/features/medications/providers/medication_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MedicationForm extends StatefulWidget {
  final Medication? medication;

  const MedicationForm({super.key, this.medication});

  @override
  State<MedicationForm> createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  late MedicationType _selectedType;
  late dynamic _selectedUnit;
  String? _photoPath;

  bool _isLoading = false;
  List<String> _filteredMedicationNames = [];
  bool _showDropdown = false;
  bool _isNameValid = true;

  @override
  void initState() {
    super.initState();

    // Initialize with existing medication data or defaults
    if (widget.medication != null) {
      _nameController.text = widget.medication!.name;
      _selectedType = widget.medication!.type;
      _selectedUnit = widget.medication!.unit;
      _noteController.text = widget.medication!.note ?? '';
      _photoPath = widget.medication!.photoPath;
    } else {
      _selectedType = MedicationType.pill;
      _selectedUnit = PillUnit.pill;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _updateFilteredMedicationNames(String query) {
    final provider = Provider.of<MedicationProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredMedicationNames = provider.medicationNames;
      } else {
        // Filter medication names based on the query

        _filteredMedicationNames = provider.medicationNames
            .where((name) => name
                .toLowerCase()
                .split(' ')
                .any((part) => part.startsWith(query.toLowerCase())))
            .toList();
      }
      _showDropdown = query.isNotEmpty && _filteredMedicationNames.isNotEmpty;
    });
  }

  final picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        var image = File(pickedFile.path);
        _photoPath = image.path;
      });
    }
  }

  void _showImagePickerOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Add Photo'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
              child: const Text('Take a Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
              child: const Text('Choose from Library'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  void _handleTypeChange(MedicationType type) {
    setState(() {
      _selectedType = type;

      // Reset unit based on type
      if (type == MedicationType.pill) {
        _selectedUnit = PillUnit.pill;
      } else if (type == MedicationType.insulin) {
        _selectedUnit = InsulinType.basal;
      } else {
        // For injection type, we'll use pill units as a fallback
        _selectedUnit = PillUnit.pill;
      }
    });
  }

  void _handleUnitChange(dynamic unit) {
    setState(() {
      _selectedUnit = unit;
    });
  }

  bool _validateForm() {
    // Validate medication name
    if (_nameController.text.isEmpty) {
      setState(() {
        _isNameValid = false;
      });
      return false;
    }

    setState(() {
      _isNameValid = true;
    });
    return true;
  }

  void _saveMedication() {
    if (_validateForm()) {
      setState(() {
        _isLoading = true;
      });

      final provider = Provider.of<MedicationProvider>(context, listen: false);

      final medication = Medication(
        id: widget.medication?.id,
        name: _nameController.text,
        type: _selectedType,
        unit: _selectedUnit,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        photoPath: _photoPath,
      );

      if (widget.medication == null) {
        provider.addMedication(medication).then((_) {
          Navigator.pop(context);
        });
      } else {
        provider.updateMedication(medication).then((_) {
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: CupertinoColors.systemBackground,
      child: Column(
        children: [
          // Navigation bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                  child: Text(
                    'Cancel',
                    style: poppinsRegular.copyWith(
                        color: CupertinoColors.destructiveRed),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  widget.medication == null
                      ? 'Add Medication'
                      : 'Edit Medication',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _isLoading ? null : _saveMedication,
                  child: Text(
                    'Save',
                    style: poppinsRegular.copyWith(color: primary1),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Photo section
                  GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: CupertinoColors.systemGrey6,
                      child: _photoPath != null
                          ? Image.file(
                              File(_photoPath!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.camera,
                                  size: 48,
                                  color: CupertinoColors.systemGrey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tap to add photo',
                                  style: poppinsRegular.copyWith(
                                    fontSize: 16,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  Stack(children: [
                    Container(
                      color: CupertinoColors.white,
                      child: CupertinoFormSection(
                        children: [
                          // Name field
                          CupertinoFormRow(
                            prefix: Text(
                              'Name',
                              style: poppinsRegular.copyWith(
                                fontSize: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            child: CupertinoTextField(
                                controller: _nameController,
                                textAlign: TextAlign.right,
                                placeholder: 'Enter medication name',
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                style: poppinsRegular.copyWith(fontSize: 16),
                                decoration: null,
                                onChanged: _updateFilteredMedicationNames),
                          ),

                          // Type field
                          CupertinoFormRow(
                            prefix: Text(
                              'Type',
                              style: poppinsRegular.copyWith(
                                fontSize: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            child: CupertinoSegmentedControl<MedicationType>(
                              children: {
                                MedicationType.pill: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text('Pill',
                                      style: poppinsRegular.copyWith(
                                          fontSize: 14,
                                          color: _selectedType ==
                                                  MedicationType.pill
                                              ? white
                                              : CupertinoColors.systemGrey)),
                                ),
                                MedicationType.insulin: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text('Insulin',
                                      style: poppinsRegular.copyWith(
                                          fontSize: 14,
                                          color: _selectedType ==
                                                  MedicationType.insulin
                                              ? white
                                              : CupertinoColors.systemGrey)),
                                ),
                                MedicationType.injection: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text('Injection',
                                      style: poppinsRegular.copyWith(
                                          fontSize: 14,
                                          color: _selectedType ==
                                                  MedicationType.injection
                                              ? white
                                              : CupertinoColors.systemGrey)),
                                ),
                              },
                              groupValue: _selectedType,
                              onValueChanged: _handleTypeChange,
                            ),
                          ),

                          // Unit field (hidden for injection type)
                          if (_selectedType != MedicationType.injection)
                            CupertinoFormRow(
                              prefix: Text(
                                _selectedType == MedicationType.insulin
                                    ? 'Insulin Type'
                                    : 'Unit',
                                style: poppinsRegular.copyWith(
                                  fontSize: 16,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              child: _selectedType == MedicationType.pill
                                  ? CupertinoSegmentedControl<PillUnit>(
                                      children: {
                                        PillUnit.pill: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text('pill',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: _selectedUnit ==
                                                          PillUnit.pill
                                                      ? white
                                                      : CupertinoColors
                                                          .systemGrey)),
                                        ),
                                        PillUnit.mg: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text('mg',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: _selectedUnit ==
                                                          PillUnit.mg
                                                      ? white
                                                      : CupertinoColors
                                                          .systemGrey)),
                                        ),
                                      },
                                      groupValue: _selectedUnit as PillUnit,
                                      onValueChanged: (value) =>
                                          _handleUnitChange(value),
                                    )
                                  : CupertinoSegmentedControl<InsulinType>(
                                      children: {
                                        InsulinType.basal: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text('Basal',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: _selectedUnit ==
                                                          InsulinType.basal
                                                      ? white
                                                      : CupertinoColors
                                                          .systemGrey)),
                                        ),
                                        InsulinType.bolus: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text('Bolus',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: 14,
                                                  color: _selectedUnit ==
                                                          InsulinType.bolus
                                                      ? white
                                                      : CupertinoColors
                                                          .systemGrey)),
                                        ),
                                        InsulinType.mixed: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text('Mixed',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: 14)),
                                        ),
                                      },
                                      groupValue: _selectedUnit as InsulinType,
                                      onValueChanged: (value) =>
                                          _handleUnitChange(value),
                                    ),
                            ),

                          // Note field
                          CupertinoFormRow(
                            prefix: Text(
                              'Note',
                              style: poppinsRegular.copyWith(
                                fontSize: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            child: CupertinoTextField(
                              controller: _noteController,
                              placeholder: 'Add a note (optional)',
                              maxLines: 4,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              style: poppinsRegular.copyWith(fontSize: 16),
                              textAlign: TextAlign.right,
                              decoration: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_showDropdown && _filteredMedicationNames.isNotEmpty)
                      Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: CupertinoColors.systemGrey4),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            maxHeight: 200,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: _filteredMedicationNames.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _nameController.text =
                                        _filteredMedicationNames[index];
                                    _showDropdown = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    border: index <
                                            _filteredMedicationNames.length - 1
                                        ? const Border(
                                            bottom: BorderSide(
                                              color:
                                                  CupertinoColors.systemGrey4,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Text(
                                    _filteredMedicationNames[index],
                                    style:
                                        poppinsRegular.copyWith(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ]),

                  // Form fields

                  if (!_isNameValid)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Please enter a medication name',
                        style: poppinsRegular.copyWith(
                          fontSize: 14,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
