import 'package:flutter/cupertino.dart';

class HistoryPageConstants {
  static const List<int> segmentDayValues = [3, 7, 14, 30, 90];
  static const List<String> segmentLabels = ['3D', '7D', '14D', '30D', '90D'];

  static const double recordCardMargin = 8.0;
  static const double recordCardPadding = 4.0;
  static const double recordCardBorderRadius = 12.0;
  static const double tagContainerPadding = 8.0;
  static const double tagContainerBorderRadius = 12.0;
  static const double tagTextSize = 12.0;

  static const double quickAddButtonSize = 56.0;
  static const double quickAddButtonIconSize = 24.0;
  static const double quickAddButtonShadowBlur = 8.0;
  static const Offset quickAddButtonShadowOffset = Offset(0, 4);

  static const double statItemSpacing = 4.0;
  static const double statItemFontSize = 14.0;

  static const double recordMenuItemSpacing = 8.0;
  static const double recordMenuItemIconSize = 24.0;
  static const double recordMenuItemFontSize = 14.0;
  static const double recordMenuItemBorderRadius = 24.0;
  static const double recordMenuItemShadowBlur = 8.0;
  static const Offset recordMenuItemShadowOffset = Offset(0, 4);

  static const EdgeInsets recordMenuItemPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  static const Offset recordCardShadowOffset = Offset(0, 2);
  static const double recordCardShadowBlur = 8.0;
}
