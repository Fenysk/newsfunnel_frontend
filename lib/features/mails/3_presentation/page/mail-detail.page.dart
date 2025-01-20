import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/delete-mail.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-details/mail-details.cubit.dart';
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

  String _parseHtmlContent(String? htmlContent) {
    if (htmlContent == null) return '(No content available)';

    // Parse the HTML content
    final document = html_parser.parse(htmlContent);

    // Remove script and style elements
    document.querySelectorAll('script, style').forEach((element) => element.remove());

    // Get the text content
    String parsedText = document.body?.text ?? '';

    // Clean up whitespace
    parsedText = parsedText.replaceAll(RegExp(r'\s+'), ' ').trim();

    return parsedText.isEmpty ? '(No content available)' : parsedText;
  }

  Widget _buildMailContent() {
    return BlocBuilder<MailDetailsCubit, MailDetailsState>(
      builder: (context, state) {
        if (state is MailDetailsLoadingState) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is MailDetailsErrorState) {
          return Center(child: Text(state.message));
        }

        if (state is MailDetailsLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From: ${state.mail.from}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Subject: ${state.mail.metadata?.oneResumeSentence ?? '(No subject)'}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Summary:',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(state.mail.metadata?.longResume ?? '(No summary available)'),
              const SizedBox(height: 16),
              Text(
                'Full Content:',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                _parseHtmlContent(state.mail.body),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MailDetailsCubit()..getMailDetails(mail.id),
      child: CupertinoPageScaffold(
        navigationBar: _buildNavigationBar(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _buildMailContent(),
          ),
        ),
      ),
    );
  }
}
