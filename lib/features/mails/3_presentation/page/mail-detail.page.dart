import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/delete-mail.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class MailDetailPage extends StatelessWidget {
  final MailEntity mail;

  const MailDetailPage({
    super.key,
    required this.mail,
  });

  void _showSettingsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Settings'),
            onPressed: () {
              Navigator.pop(context);
              // Add settings navigation logic here
            },
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () async {
              Either result = await serviceLocator<DeleteMailUsecase>().execute(request: mail.id);
              if (result.isRight()) {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  ObstructingPreferredSizeWidget _buildNavigationBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(mail.metadata?.oneResumeSentence ?? 'Mail Detail'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.settings),
        onPressed: () => _showSettingsSheet(context),
      ),
    );
  }

  Widget _buildMailContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From: ${mail.from}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Subject: ${mail.metadata?.oneResumeSentence ?? '(No subject)'}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Summary:',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          mail.metadata?.longResume ?? '(No longResume available)',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildNavigationBar(context),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: _buildMailContent(),
        ),
      ),
    );
  }
}
