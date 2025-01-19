import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/bloc/user-mail-servers-display.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/bloc/user-mail-servers-display.state.dart';

class UserMailServersDisplayWidget extends StatelessWidget {
  const UserMailServersDisplayWidget({super.key});

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
              UserMailServersDisplayLoaded() => buildLoadedContent(state),
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

  Widget buildLoadedContent(UserMailServersDisplayLoaded state) => Padding(
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
          ],
        ),
      );
}
