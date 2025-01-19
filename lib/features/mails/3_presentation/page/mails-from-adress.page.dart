import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/user-mails-from-address.widget.dart';

class MailsFromAddressPage extends StatelessWidget {
  final String emailAddress;

  const MailsFromAddressPage({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Mails'),
      ),
      child: SafeArea(
        child: UserMailsFromAddressWidget(
          emailAddress: emailAddress,
        ),
      ),
    );
  }
}
