import 'package:flutter/cupertino.dart';

class ModalUtil {
  Future<void> openBottomDrawer({
    required BuildContext context,
    required Widget child,
    bool snap = true,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
