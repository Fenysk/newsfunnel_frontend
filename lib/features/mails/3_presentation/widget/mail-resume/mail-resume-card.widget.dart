import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';

class MailResumeCardWidget extends StatelessWidget {
  final MailEntity mail;

  const MailResumeCardWidget({
    super.key,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getPriorityColor(mail.metadata?.priority ?? 0),
                        ),
                        margin: const EdgeInsets.only(right: 8),
                      ),
                      Expanded(
                        child: Text(
                          mail.from,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CupertinoTheme.of(context).textTheme.textStyle.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
              mail.metadata?.oneResumeSentence ?? '(No subject)',
              style: TextStyle(
                fontSize: 15,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              mail.metadata?.longResume ?? '(No resume)',
              style: TextStyle(
                fontSize: 14,
                color: CupertinoTheme.of(context).textTheme.textStyle.color?.withAlpha((0.8 * 255).round()),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getPriorityColor(int priority) {
    return switch (priority) {
      1 => CupertinoColors.systemRed,
      2 => CupertinoColors.systemOrange,
      3 => CupertinoColors.systemYellow,
      _ => CupertinoColors.systemGrey,
    };
  }
}
