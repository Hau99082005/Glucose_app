import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/medications/models/medication.dart';
import 'package:flutter_app/src/features/medications/providers/medication_provider.dart';
import 'package:flutter_app/src/features/medications/presentations/widgets/medication_form.dart';
import 'package:provider/provider.dart';

class MedicationList extends StatelessWidget {
  const MedicationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(
      builder: (context, provider, child) {
        if (provider.medications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.circle_grid_hex,
                  size: 48,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No medications added yet',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to add a medication',
                  style: poppinsRegular.copyWith(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey2,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.medications.length,
          itemBuilder: (context, index) {
            final medication = provider.medications[index];
            return _MedicationListItem(medication: medication);
          },
        );
      },
    );
  }
}

class _MedicationListItem extends StatelessWidget {
  final Medication medication;

  const _MedicationListItem({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('medication_${medication.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: CupertinoColors.destructiveRed,
        child: const Icon(CupertinoIcons.delete, color: CupertinoColors.white),
      ),
      confirmDismiss: (direction) async {
        return await showCupertinoDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Delete Medication'),
                  content: Text(
                    'Are you sure you want to delete ${medication.name}?',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text('Delete'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                );
              },
            ) ??
            false;
      },
      onDismissed: (direction) {
        Provider.of<MedicationProvider>(
          context,
          listen: false,
        ).deleteMedication(medication.id!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showEditMedication(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Medication photo or icon
                  if (medication.photoPath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(medication.photoPath!),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getMedicationIcon(),
                        size: 24,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  const SizedBox(width: 16),

                  // Medication details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.name,
                          style: poppinsRegular.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getMedicationTypeText(),
                          style: poppinsRegular.copyWith(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        if (medication.note != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            medication.note!,
                            style: poppinsRegular.copyWith(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Chevron indicator
                  const Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: CupertinoColors.systemGrey3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getMedicationIcon() {
    switch (medication.type) {
      case MedicationType.pill:
        return CupertinoIcons.circle_grid_hex;
      case MedicationType.insulin:
        return CupertinoIcons.drop;
      case MedicationType.injection:
        return CupertinoIcons.arrow_up_circle;
    }
  }

  String _getMedicationTypeText() {
    final type =
        medication.type == MedicationType.pill
            ? 'Pill'
            : medication.type == MedicationType.insulin
            ? 'Insulin'
            : 'Injection';

    final unit =
        medication.type == MedicationType.insulin
            ? (medication.unit as InsulinType).toString().split('.').last
            : (medication.unit as PillUnit).toString().split('.').last;

    return '$type • $unit';
  }

  void _showEditMedication(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return MedicationForm(medication: medication);
      },
    );
  }
}
