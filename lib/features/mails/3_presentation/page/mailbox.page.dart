import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/list-mails-from-address.widget.dart';

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
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(AppIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text(emailAddress),
      ),
      child: SafeArea(
        child: ListMailsFromAddressWidget(
          emailAddress: emailAddress,
        ),
      ),
    );
  }
}
