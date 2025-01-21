import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/user-mail-servers-display.widget.dart';
import 'package:newsfunnel_frontend/features/settings/3_presentation/widgets/add-server-sheet.widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(AppIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: const Text('Settings'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => AddServerSheetWidget().show(context),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            UserMailServersDisplayWidget(),
          ],
        ),
      ),
    );
  }
}
