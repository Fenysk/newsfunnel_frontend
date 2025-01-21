import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/delete-mail.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/generate-summary.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/mark-mail-read-state.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/core/utils/markdown.util.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';

class MailDetailPage extends StatefulWidget {
  final MailEntity mail;

  const MailDetailPage({
    super.key,
    required this.mail,
  });

  @override
  State<MailDetailPage> createState() => _MailDetailPageState();
}

class _MailDetailPageState extends State<MailDetailPage> {
  bool _isSummaryExpanded = true;
  bool _areQuotesExpanded = true;
  bool _areSectionsExpanded = true;
  bool _areNotesExpanded = true;
  bool _isRawDataExpanded = false;
  Map<String, bool> _sectionExpanded = {};

  @override
  void initState() {
    super.initState();
    _markAsRead();
  }

  Future<void> _markAsRead() async {
    if (!widget.mail.isRead) {
      await serviceLocator<MarkMailReadStateUsecase>().execute(
        request: {
          'mailId': widget.mail.id,
          'isRead': true,
        },
      );
    }
  }

  void _showSettingsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Generate Summary'),
            onPressed: () async {
              Navigator.pop(context);
              Either result = await serviceLocator<GenerateSummaryUsecase>().execute(request: widget.mail.id);
              if (result.isRight()) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MailDetailPage(mail: result.getOrElse(() => null)),
                    ),
                  );
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () async {
              Either result = await serviceLocator<DeleteMailUsecase>().execute(request: widget.mail.id);
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
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(AppIcons.back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      middle: Text(widget.mail.markdownSummary != null ? MarkdownUtil.getTitle(widget.mail.markdownSummary!) ?? 'Mail Detail' : 'Mail Detail'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(AppIcons.settings),
        onPressed: () => _showSettingsSheet(context),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isExpanded ? AppIcons.down : AppIcons.right,
                size: 16,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        if (isExpanded) child,
      ],
    );
  }

  Widget _buildMailContent(BuildContext context) {
    final String? title = widget.mail.markdownSummary != null ? MarkdownUtil.getTitle(widget.mail.markdownSummary!) : null;
    final String? briefSummary = widget.mail.markdownSummary != null ? MarkdownUtil.getBriefSummary(widget.mail.markdownSummary!) : null;
    final List<Map<String, List<String>>> sections = widget.mail.markdownSummary != null ? MarkdownUtil.getMainSections(widget.mail.markdownSummary!) : [];
    final List<String> quotes = widget.mail.markdownSummary != null ? MarkdownUtil.getImportantQuotes(widget.mail.markdownSummary!) : [];
    final List<Map<String, String>> notes = widget.mail.markdownSummary != null ? MarkdownUtil.getAdditionalNotes(widget.mail.markdownSummary!) : [];

    for (var section in sections) {
      for (var entry in section.entries) {
        if (!_sectionExpanded.containsKey(entry.key)) {
          _sectionExpanded[entry.key] = true;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title ?? widget.mail.subject ?? '(No subject)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoTheme.of(context).textTheme.textStyle.color),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'From: ${widget.mail.from}',
          style: TextStyle(
            fontSize: 12,
            color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        if (widget.mail.markdownSummary != null) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MarkdownUtil.getKeywords(widget.mail.markdownSummary!).map((keyword) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: CupertinoTheme.of(context).primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  keyword,
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
        _buildExpandableSection(
          title: 'Summary',
          isExpanded: _isSummaryExpanded,
          onTap: () => setState(() => _isSummaryExpanded = !_isSummaryExpanded),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              briefSummary ?? '(No summary available)',
              style: TextStyle(fontSize: 14, color: CupertinoTheme.of(context).textTheme.textStyle.color),
            ),
          ),
        ),
        if (quotes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildExpandableSection(
            title: 'Important Quotes',
            isExpanded: _areQuotesExpanded,
            onTap: () => setState(() => _areQuotesExpanded = !_areQuotesExpanded),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: quotes
                    .map((quote) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: CupertinoTheme.of(context).primaryColor.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '"$quote"',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: CupertinoTheme.of(context).textTheme.textStyle.color,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
        if (sections.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildExpandableSection(
            title: 'Main Sections',
            isExpanded: _areSectionsExpanded,
            onTap: () => setState(() => _areSectionsExpanded = !_areSectionsExpanded),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections
                    .expand((section) => [
                          ...section.entries.expand((entry) => [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => setState(() => _sectionExpanded[entry.key] = !(_sectionExpanded[entry.key] ?? true)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          entry.key,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CupertinoTheme.of(context).primaryContrastingColor),
                                        ),
                                      ),
                                      const SizedBox(width: 32),
                                      Icon(
                                        _sectionExpanded[entry.key] ?? true ? AppIcons.down : AppIcons.right,
                                        size: 16,
                                        color: CupertinoTheme.of(context).primaryContrastingColor,
                                      ),
                                    ],
                                  ),
                                ),
                                if (_sectionExpanded[entry.key] ?? true) ...[
                                  const SizedBox(height: 8),
                                  ...entry.value.map((bullet) => Padding(
                                        padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                                        child: Text(
                                          '• $bullet',
                                          style: TextStyle(fontSize: 14, color: CupertinoTheme.of(context).textTheme.textStyle.color),
                                        ),
                                      )),
                                  const SizedBox(height: 8),
                                ],
                              ]),
                        ])
                    .toList(),
              ),
            ),
          ),
        ],
        if (notes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildExpandableSection(
            title: 'Additional Notes',
            isExpanded: _areNotesExpanded,
            onTap: () => setState(() => _areNotesExpanded = !_areNotesExpanded),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: notes
                    .expand((note) => note.entries.map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${entry.key}: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                                  ),
                                ),
                                TextSpan(
                                  text: entry.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                    .toList(),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        _buildExpandableSection(
          title: 'Raw Data',
          isExpanded: _isRawDataExpanded,
          onTap: () => setState(() => _isRawDataExpanded = !_isRawDataExpanded),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.2) ?? CupertinoColors.systemGrey4,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From: ${widget.mail.from}',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.mail.markdownSummary ?? '(No raw data available)',
                  style: TextStyle(
                    fontSize: 13,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: _buildNavigationBar(context),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: _buildMailContent(context),
        ),
      ),
    );
  }
}
