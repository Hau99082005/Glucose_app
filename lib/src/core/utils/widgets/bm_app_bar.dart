import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';

enum BackButtonMode {
  close,
  back,
  auto,
  none,
}

CupertinoNavigationBar commonCupertinoAppBar(BuildContext context,
    String? title, Color? tintColor, Color? backgroundColor,
    {BackButtonMode backButtonMode = BackButtonMode.back,
    List<Widget>? leftWidgets,
    List<Widget>? actions,
    bool? centerTitle = true,
    VoidCallback? customBackAction}) {
  Widget? leadingWidget;
  switch (backButtonMode) {
    case BackButtonMode.none:
      leadingWidget =
          leftWidgets?.isNotEmpty == true ? Row(children: leftWidgets!) : null;
      break;
    case BackButtonMode.close:
      leadingWidget = CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.xmark, color: tintColor),
        onPressed: () {
          if (customBackAction != null) {
            customBackAction();
          } else {
            Navigator.of(context).pop();
          }
        },
      );
    default:
      leadingWidget = CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
            Platform.isIOS ? CupertinoIcons.back : CupertinoIcons.chevron_left,
            color: tintColor),
        onPressed: () {
          if (customBackAction != null) {
            customBackAction();
          } else {
            Navigator.of(context).pop();
          }
        },
      );
      break;
  }

  return CupertinoNavigationBar(
    middle: Text(
      title ?? '',
      style: poppinsMedium.copyWith(fontSize: 18, color: tintColor),
    ),
    backgroundColor: backgroundColor?.withOpacity(1.0),
    automaticallyImplyLeading: false,
    leading: leadingWidget,
    trailing: actions != null && actions.isNotEmpty
        ? Row(mainAxisSize: MainAxisSize.min, children: actions)
        : null,
  );
}
