import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/bloc/user-mail-servers-display.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/bloc/user-mail-servers-display.state.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-server/mail-server-card.widget.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/unlink-mail-server.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';

class UserMailServersDisplayWidget extends StatelessWidget {
  const UserMailServersDisplayWidget({super.key});

  Future<bool> _showDeleteConfirmation(BuildContext context, String emailAddress) async {
    final bool? result = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Mail Server'),
        content: const Text('Are you sure you want to delete this mail server?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await serviceLocator<UnlinkMailServerUsecase>().execute(request: emailAddress);
              if (context.mounted) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Delete'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserMailServersDisplayCubit()..displayUserMailServers(),
      child: BlocListener<UserMailServersDisplayCubit, UserMailServersDisplayState>(
        listener: (context, state) {
          if (state is UserMailServersDisplayLoaded) {
            print('Number of mail servers: ${state.mailServers.length}');
          }
        },
        child: BlocBuilder<UserMailServersDisplayCubit, UserMailServersDisplayState>(
          builder: (context, state) {
            return switch (state) {
              UserMailServersDisplayLoaded() => buildLoadedContent(context, state),
              UserMailServersDisplayFailure() => buildFailureContent(state),
              _ => buildLoadingContent(),
            };
          },
        ),
      ),
    );
  }

  Widget buildLoadingContent() => const Center(child: CupertinoActivityIndicator());

  Widget buildFailureContent(UserMailServersDisplayFailure state) => Center(child: Text(state.errorMessage));

  Widget buildLoadedContent(BuildContext context, UserMailServersDisplayLoaded state) => SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Number of mail servers: ${state.mailServers.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              for (final mailServer in state.mailServers)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(mailServer.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      color: CupertinoColors.destructiveRed,
                      child: Icon(
                        AppIcons.delete,
                        color: CupertinoColors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmation(context, mailServer.user);
                    },
                    onDismissed: (direction) {
                      context.read<UserMailServersDisplayCubit>().displayUserMailServers();
                    },
                    child: MailServerCardWidget(mailServer: mailServer),
                  ),
                ),
            ],
          ),
        ),
      );
}
