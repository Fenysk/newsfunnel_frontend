import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail_details/bloc/mail_details.cubit.dart';

class MailOriginalPage extends StatelessWidget {
  final MailEntity mail;

  const MailOriginalPage({
    super.key,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MailDetailsCubit()..getMailDetails(mail.id),
      child: BlocBuilder<MailDetailsCubit, MailDetailsState>(
        builder: (context, state) {
          if (state is MailDetailsLoadingState) {
            return const CupertinoPageScaffold(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (state is MailDetailsErrorState) {
            return CupertinoPageScaffold(
              child: Center(
                child: Text(state.errorMessage),
              ),
            );
          }

          if (state is MailDetailsLoadedState) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: const Text('Original Email'),
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Back'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context).barBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.2) ?? CupertinoColors.systemGrey4,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'From: ${state.mail.from}',
                              style: TextStyle(
                                fontSize: 14,
                                color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(state.mail.body ?? '(No body)'),
                    ],
                  ),
                ),
              ),
            );
          }

          return const CupertinoPageScaffold(
            child: Center(
              child: Text('Something went wrong'),
            ),
          );
        },
      ),
    );
  }
}
