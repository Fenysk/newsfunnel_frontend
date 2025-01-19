import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/mail-server-clickable-list.widget.dart';

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoNavigationBar(
          middle: const Text('Mails'),
        ),
        const Expanded(
          child: MailServerClickableList(),
        ),
      ],
    );
  }
}
