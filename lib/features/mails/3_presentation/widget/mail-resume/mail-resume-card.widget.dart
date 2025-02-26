import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/page/mail-detail.page.dart';
import 'package:newsfunnel_frontend/core/utils/markdown.util.dart';

class MailResumeCardWidget extends StatelessWidget {
  final MailEntity mail;

  const MailResumeCardWidget({
    super.key,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    final String? briefSummary = mail.markdownSummary != null ? MarkdownUtil.getBriefSummary(mail.markdownSummary!) : null;
    final String? title = mail.markdownSummary != null ? MarkdownUtil.getTitle(mail.markdownSummary!) : null;
    final List<String> keywords = mail.markdownSummary != null ? MarkdownUtil.getKeywords(mail.markdownSummary!) : [];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => MailDetailPage(mail: mail),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CupertinoColors.separator,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!mail.isRead)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.activeBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: CupertinoColors.activeBlue,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CupertinoColors.activeBlue,
                                  ),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: mail.markdownSummary != null ? CupertinoColors.activeGreen.withOpacity(0.1) : CupertinoColors.systemGrey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: mail.markdownSummary != null ? CupertinoColors.activeGreen : CupertinoColors.systemGrey,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    mail.markdownSummary != null ? AppIcons.summarized : AppIcons.notSummarized,
                                    size: 14,
                                    color: mail.markdownSummary != null ? CupertinoColors.activeGreen : CupertinoColors.systemGrey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title ?? mail.subject ?? '(No subject)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: mail.isRead ? FontWeight.normal : FontWeight.bold,
                            color: CupertinoTheme.of(context).textTheme.textStyle.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatDate(mail.createdAt),
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                briefSummary ?? '(No resume)',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color?.withAlpha((0.8 * 255).round()),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (keywords.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: keywords
                      .map((keyword) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: CupertinoTheme.of(context).barBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              keyword,
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoTheme.of(context).primaryColor,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                mail.from,
                style: TextStyle(
                  fontSize: 13,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
