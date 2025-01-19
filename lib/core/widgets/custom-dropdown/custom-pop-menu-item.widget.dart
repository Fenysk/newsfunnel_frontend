import 'package:flutter/cupertino.dart';

class CustomPopupMenuItem<Type> extends CupertinoContextMenuAction {
  const CustomPopupMenuItem({
    super.key,
    required super.child,
    Type? value,
  }) : super(
          trailingIcon: null,
        );
}
