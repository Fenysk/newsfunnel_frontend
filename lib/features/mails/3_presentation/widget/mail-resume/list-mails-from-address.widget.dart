import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/bloc/user-mails-from-address.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/bloc/user-mails-from-address.state.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/mail-resume-card.widget.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/delete-mail.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/mark-mail-read-state.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';

class ListMailsFromAddressWidget extends StatelessWidget {
  final String emailAddress;

  const ListMailsFromAddressWidget({
    super.key,
    required this.emailAddress,
  });

  Future<bool> _showDeleteConfirmation(BuildContext context, String mailId) async {
    final bool? result = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Mail'),
        content: const Text('Are you sure you want to delete this mail?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await serviceLocator<DeleteMailUsecase>().execute(request: mailId);
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
      create: (context) => UserMailsFromAddressCubit()..displayUserMailsFromAddress(emailAddress),
      child: BlocListener<UserMailsFromAddressCubit, UserMailsFromAddressState>(
        listener: (context, state) {
          if (state is UserMailsFromAddressLoaded) {
            print('Number of mails: ${state.mails.length}');
          }
        },
        child: BlocBuilder<UserMailsFromAddressCubit, UserMailsFromAddressState>(
          builder: (context, state) {
            return switch (state) {
              UserMailsFromAddressLoaded() => buildLoadedContent(context, state),
              UserMailsFromAddressFailure() => buildFailureContent(state),
              _ => buildLoadingContent(),
            };
          },
        ),
      ),
    );
  }

  Widget buildLoadingContent() => const Center(child: CupertinoActivityIndicator());

  Widget buildFailureContent(UserMailsFromAddressFailure state) => Center(child: Text(state.errorMessage));

  Widget buildLoadedContent(BuildContext context, UserMailsFromAddressLoaded state) {
    // Sort mails by unread first
    final sortedMails = [
      ...state.mails
    ]..sort((a, b) {
        if (!a.isRead && b.isRead) return -1;
        if (a.isRead && !b.isRead) return 1;
        return 0;
      });

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Number of mails: ${sortedMails.length}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async => await context.read<UserMailsFromAddressCubit>().displayUserMailsFromAddress(emailAddress),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final mail = sortedMails[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Dismissible(
                          key: Key(mail.id),
                          direction: DismissDirection.horizontal,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            color: CupertinoColors.systemBlue,
                            child: Icon(
                              AppIcons.unread,
                              color: CupertinoColors.white,
                            ),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: CupertinoColors.destructiveRed,
                            child: Icon(
                              AppIcons.delete,
                              color: CupertinoColors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              return await _showDeleteConfirmation(context, mail.id);
                            } else {
                              final result = await serviceLocator<MarkMailReadStateUsecase>().execute(
                                request: {
                                  'mailId': mail.id,
                                  'isRead': !mail.isRead,
                                },
                              );
                              if (result.isRight()) {
                                context.read<UserMailsFromAddressCubit>().displayUserMailsFromAddress(emailAddress);
                              }
                              return false;
                            }
                          },
                          onDismissed: (direction) {
                            context.read<UserMailsFromAddressCubit>().displayUserMailsFromAddress(emailAddress);
                          },
                          child: MailResumeCardWidget(mail: mail),
                        ),
                      );
                    },
                    childCount: sortedMails.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
