import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/constants/app_constants.dart';
import 'package:flutter_app/src/features/home/presentation/constants/history_page_constants.dart';

class QuickAddMenu extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onToggle;
  final Function(String) onRecordTypeSelected;

  const QuickAddMenu({
    super.key,
    required this.isVisible,
    required this.onToggle,
    required this.onRecordTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isVisible) ...[
          _buildRecordMenuItem('Oxygen', () => onRecordTypeSelected('Oxygen')),
          _buildRecordMenuItem(
              'Medications', () => onRecordTypeSelected('Medications')),
          _buildRecordMenuItem('A1C', () => onRecordTypeSelected('A1C')),
          _buildRecordMenuItem(
              'Insulin', () => onRecordTypeSelected('Insulin')),
          _buildRecordMenuItem(
              'Blood Pressure', () => onRecordTypeSelected('Blood Pressure')),
          _buildRecordMenuItem('Weight', () => onRecordTypeSelected('Weight')),
          _buildRecordMenuItem(
              'Glucose', () => onRecordTypeSelected('Glucose')),
          const SizedBox(height: 16),
        ],
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: HistoryPageConstants.quickAddButtonSize,
            height: HistoryPageConstants.quickAddButtonSize,
            decoration: BoxDecoration(
              color: primary1,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.2),
                  blurRadius: HistoryPageConstants.quickAddButtonShadowBlur,
                  offset: HistoryPageConstants.quickAddButtonShadowOffset,
                ),
              ],
            ),
            child: Icon(
              isVisible ? CupertinoIcons.xmark : CupertinoIcons.plus,
              color: white,
              size: HistoryPageConstants.quickAddButtonIconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordMenuItem(String type, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: HistoryPageConstants.recordMenuItemSpacing),
        padding: HistoryPageConstants.recordMenuItemPadding,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
              HistoryPageConstants.recordMenuItemBorderRadius),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.1),
              blurRadius: HistoryPageConstants.recordMenuItemShadowBlur,
              offset: HistoryPageConstants.recordMenuItemShadowOffset,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppConstants.recordTypeIcons[type] ?? '',
              width: HistoryPageConstants.recordMenuItemIconSize,
              height: HistoryPageConstants.recordMenuItemIconSize,
            ),
            const SizedBox(width: HistoryPageConstants.recordMenuItemSpacing),
            Text(
              type,
              style: poppinsRegular.copyWith(
                fontSize: HistoryPageConstants.recordMenuItemFontSize,
                color: primary1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
