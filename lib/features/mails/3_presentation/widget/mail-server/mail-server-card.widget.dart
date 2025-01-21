import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-server.entity.dart';

class MailServerCardWidget extends StatefulWidget {
  final MailServerEntity mailServer;

  const MailServerCardWidget({
    super.key,
    required this.mailServer,
  });

  @override
  State<MailServerCardWidget> createState() => _MailServerCardWidgetState();
}

class _MailServerCardWidgetState extends State<MailServerCardWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.separator,
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _showPassword = true),
        onTapUp: (_) => setState(() => _showPassword = false),
        onTapCancel: () => setState(() => _showPassword = false),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mailServer.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Host: ${widget.mailServer.host}:${widget.mailServer.port}',
                  style: TextStyle(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                Text(
                  'User: ${widget.mailServer.user}',
                  style: TextStyle(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                Text(
                  'Password: ${_showPassword ? widget.mailServer.password : '••••••••'}',
                  style: TextStyle(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                Text(
                  'TLS: ${widget.mailServer.tls ? 'Enabled' : 'Disabled'}',
                  style: TextStyle(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                if (widget.mailServer.mails != null)
                  Text(
                    'Emails: ${widget.mailServer.mails!.length}',
                    style: TextStyle(
                      color: CupertinoTheme.of(context).textTheme.textStyle.color,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
