import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/widgets/bm_app_bar.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/reminder_form.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/reminder_list.dart';

@RoutePage()
class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: grey6,
      navigationBar: commonCupertinoAppBar(
        context,
        'Reminders',
        white,
        primary1,
        backButtonMode: BackButtonMode.close,
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.add_circled,
              color: white,
              size: 24,
            ),
            onPressed: () => _showCreateReminderModal(context),
          )
        ],
      ),
      child: const SafeArea(
        child: ReminderList(),
      ),
    );
  }

  void _showCreateReminderModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const ReminderForm(),
    );
  }
}
