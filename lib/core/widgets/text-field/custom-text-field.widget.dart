import 'package:flutter/cupertino.dart';

class CustomTextField extends CupertinoTextField {
  final CupertinoThemeData themeData;

  CustomTextField({
    super.key,
    super.controller,
    required this.themeData,
    super.onChanged,
  }) : super(
          style: const TextStyle(fontSize: 16),
          cursorHeight: 16,
          cursorColor: themeData.primaryColor,
          maxLines: null,
          placeholder: 'Quoi de neuf ?',
          placeholderStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: themeData.primaryColor.withAlpha(77),
          ),
          decoration: null,
          padding: EdgeInsets.zero,
        );
}
