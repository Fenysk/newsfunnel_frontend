import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/page/mailbox.page.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/bloc/user-mail-servers-display.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/bloc/user-mail-servers-display.state.dart';

class MailServerClickableList extends StatelessWidget {
  const MailServerClickableList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserMailServersDisplayCubit()..displayUserMailServers(),
      child: BlocBuilder<UserMailServersDisplayCubit, UserMailServersDisplayState>(
        builder: (context, state) {
          return switch (state) {
            UserMailServersDisplayLoaded() => buildLoadedContent(context, state),
            UserMailServersDisplayFailure() => buildFailureContent(state),
            _ => buildLoadingContent(),
          };
        },
      ),
    );
  }

  Widget buildLoadingContent() => const Center(child: CupertinoActivityIndicator());

  Widget buildFailureContent(UserMailServersDisplayFailure state) => Center(child: Text(state.errorMessage));

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Your mailboxes',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildLoadedContent(BuildContext context, UserMailServersDisplayLoaded state) {
    if (state.mailServers.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 16),
          const Text('No mail servers found for you'),
        ],
      );
    }

    return Column(
      children: [
        _buildTitle(),
        Expanded(
          child: ListView.builder(
            itemCount: state.mailServers.length,
            itemBuilder: (context, index) {
              final mailServer = state.mailServers[index];
              return CupertinoListTile(
                title: Text(mailServer.name),
                subtitle: Text(mailServer.user),
                trailing: Icon(AppIcons.right),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => MailboxPage(emailAddress: mailServer.user),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
