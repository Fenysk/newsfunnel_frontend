import 'package:flutter/cupertino.dart';

class CustomDropdown extends StatelessWidget {
  final String displayText;
  final List<CupertinoActionSheetAction> items;
  final Function(String) onSelected;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelected,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            message: Text(displayText),
            actions: items,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ),
        );
      },
      child: Text(
        displayText,
        style: const TextStyle(color: CupertinoColors.systemGrey),
      ),
    );
  }
}
