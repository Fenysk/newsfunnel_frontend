import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/mail-server-clickable-list.widget.dart';
import 'package:newsfunnel_frontend/features/settings/3_presentation/page/settings.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.settings),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
          ),
          middle: const Text('Home'),
        ),
        const Expanded(
          child: MailServerClickableList(),
        ),
      ],
    );
  }
}
