import 'package:flutter/material.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/user-mail-servers-display.widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserMailServersDisplayWidget(),
      ],
    );
  }
}
