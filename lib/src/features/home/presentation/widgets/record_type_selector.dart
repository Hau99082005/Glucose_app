import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/constants/app_constants.dart';
import 'package:flutter_app/src/features/home/presentation/constants/create_record_page_constants.dart';

class RecordTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const RecordTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  static const List<String> recordTypes = [
    'Glucose',
    'Weight',
    'Blood Pressure',
    'Insulin',
    'Medications',
    'Carbs',
    'Temperature',
    'A1C',
    'Exercise',
    'Oxygen',
    'Notes',
    'Ketones',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(CreateRecordPageConstants.typeContainerPadding),
      height: CreateRecordPageConstants.typeSelectorHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recordTypes.length,
        itemBuilder: (context, index) {
          final type = recordTypes[index];
          final iconPath = AppConstants.recordTypeIcons[type];

          return Padding(
            padding: const EdgeInsets.only(
                right: CreateRecordPageConstants.typeContainerPadding),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                    CreateRecordPageConstants.typeIconContainerSize),
                onTap: () => onTypeSelected(type),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          CreateRecordPageConstants.typeIconPadding),
                      width: CreateRecordPageConstants.typeIconContainerSize,
                      height: CreateRecordPageConstants.typeIconContainerSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedType == type ? accent1 : white,
                      ),
                      child: iconPath != null && iconPath.isNotEmpty
                          ? Image.asset(iconPath)
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(
                        height: CreateRecordPageConstants.typeSpacing),
                    Text(
                      type.replaceAll(' ', '\n'),
                      textAlign: TextAlign.center,
                      style: poppinsMedium.copyWith(
                        fontSize: CreateRecordPageConstants.typeTextSize,
                        color: selectedType == type ? primary1 : grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
