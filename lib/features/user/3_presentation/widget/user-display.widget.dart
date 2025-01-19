import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/entity/user.entity.dart';
import 'package:newsfunnel_frontend/features/user/3_presentation/bloc/user-display.cubit.dart';
import 'package:newsfunnel_frontend/features/user/3_presentation/bloc/user-display.state.dart';

class UserDisplayWidget extends StatelessWidget {
  final String? userId;

  const UserDisplayWidget({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDisplayCubit()..displayUser(userId: userId),
      child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
        builder: (context, state) {
          return switch (state) {
            UserDisplayLoaded() => buildLoadedContent(state),
            UserDisplayFailure() => buildFailureContent(state),
            _ => buildLoadingContent(),
          };
        },
      ),
    );
  }

  Widget buildLoadingContent() => const Center(child: CupertinoActivityIndicator());

  Widget buildFailureContent(UserDisplayFailure state) => Center(child: Text(state.errorMessage));

  Widget buildLoadedContent(UserDisplayLoaded state) => Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AvatarWidget(user: state.user, diameter: 60),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.user.Profile?.displayName ?? 'No displayName',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.user.Profile?.pseudo ?? 'No pseudo',
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class AvatarWidget extends StatelessWidget {
  final UserEntity user;
  final double diameter;

  const AvatarWidget({
    super.key,
    required this.user,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CupertinoColors.systemGrey,
        image: user.Profile?.avatarUrl != null
            ? DecorationImage(
                image: NetworkImage(user.Profile!.avatarUrl!),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              )
            : null,
      ),
      child: user.Profile?.avatarUrl == null
          ? Center(
              child: Text(
                user.Profile?.pseudo?.toUpperCase().substring(0, 2) ?? '',
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                ),
              ),
            )
          : null,
    );
  }
}
