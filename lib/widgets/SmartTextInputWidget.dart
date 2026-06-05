import 'package:flutter/material.dart';

class SmartTextInputWidget extends StatelessWidget {
  const SmartTextInputWidget({
    super.key,
    required this.titleController,
    required this.titleText,
    this.maxLine,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.onTab,
  });

  final TextEditingController titleController;
  final String titleText;
  final bool readOnly;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      maxLines: maxLine,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onTap: onTab,
      onTapOutside: (v){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: titleText,
        alignLabelWithHint: true,
        suffixIcon: suffixIcon,
      ),
    );
  }
}