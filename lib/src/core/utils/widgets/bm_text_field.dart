import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';

class BMTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String unit;
  final String? Function(String?)? validator;
  final bool isRequired;
  final double? width;

  const BMTextField({
    super.key,
    required this.label,
    required this.controller,
    this.placeholder = '',
    this.keyboardType = TextInputType.text,
    this.unit = '',
    this.validator,
    this.isRequired = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: grey6),
          ),
        ),
        child: CupertinoTextFormFieldRow(
          controller: controller,
          keyboardType: keyboardType,
          padding: EdgeInsets.zero,
          prefix: Text(label, style: poppinsRegular),
          textAlign: TextAlign.end,
          placeholder: placeholder,
          validator: validator,
        ));
  }
}
