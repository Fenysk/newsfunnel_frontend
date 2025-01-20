import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/user-mails-from-address.widget.dart';

class MailboxPage extends StatelessWidget {
  final String emailAddress;

  const MailboxPage({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(emailAddress),
      ),
      child: SafeArea(
        child: UserMailsFromAddressWidget(
          emailAddress: emailAddress,
        ),
      ),
    );
  }
}
