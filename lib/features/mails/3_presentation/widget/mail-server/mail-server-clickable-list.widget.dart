import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/page/mails-from-adress.page.dart';
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

  Widget buildLoadedContent(BuildContext context, UserMailServersDisplayLoaded state) {
    if (state.mailServers.isEmpty) {
      return const Center(
        child: Text('No mail servers found for you'),
      );
    }

    return ListView.builder(
      itemCount: state.mailServers.length,
      itemBuilder: (context, index) {
        final mailServer = state.mailServers[index];
        return CupertinoListTile(
          title: Text(mailServer.name),
          subtitle: Text(mailServer.name),
          trailing: const CupertinoListTileChevron(),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => MailsFromAddressPage(emailAddress: mailServer.user),
              ),
            );
          },
        );
      },
    );
  }
}
