import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/bloc/user-mails-from-address.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/bloc/user-mails-from-address.state.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/mail-resume-card.widget.dart';

class UserMailsFromAddressWidget extends StatelessWidget {
  final String emailAddress;

  const UserMailsFromAddressWidget({
    super.key,
    required this.emailAddress,
  });

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
              UserMailsFromAddressLoaded() => buildLoadedContent(state),
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

  Widget buildLoadedContent(UserMailsFromAddressLoaded state) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number of mails: ${state.mails.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final mail in state.mails)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: MailResumeCardWidget(mail: mail),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
