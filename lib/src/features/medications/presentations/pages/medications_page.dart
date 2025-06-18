import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/medications/presentations/widgets/medication_form.dart';
import 'package:flutter_app/src/features/medications/presentations/widgets/medication_list.dart';

@RoutePage()
class MedicationsPage extends StatefulWidget {
  bool isModal = false;

  MedicationsPage({super.key, this.isModal = false});

  @override
  State<StatefulWidget> createState() {
    return _MedicationsPageState();
  }
}

class _MedicationsPageState extends State<MedicationsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Medications',
            style: poppinsMedium.copyWith(color: white, fontSize: 18),
          ),
          backgroundColor: primary1,
          leading: CupertinoButton(
            padding: const EdgeInsets.all(4),
            child: widget.isModal
                ? Icon(CupertinoIcons.xmark, color: white, size: 24)
                : Icon(CupertinoIcons.profile_circled, color: white, size: 24),
            onPressed: () {
              if (widget.isModal) {
                Navigator.pop(context);
              }
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.all(4),
                child: Icon(CupertinoIcons.add, color: white, size: 24),
                onPressed: () {
                  _showAddMedication(context);
                },
              )
            ],
          )),
      child: const SafeArea(
        child: MedicationList(),
      ),
    );
  }

  void _showAddMedication(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return const MedicationForm();
      },
    );
  }
}
