import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/page/auth.page.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/widget/logout-button.widget.dart';
import 'package:newsfunnel_frontend/features/settings/3_presentation/page/settings.page.dart';
import 'package:newsfunnel_frontend/features/user/3_presentation/widget/user-display.widget.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;

  const ProfilePage({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingButtonCubit(),
      child: BlocListener<LoadingButtonCubit, LoadingButtonState>(
        listener: (context, state) {
          if (state is LoadingButtonSuccessState) {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const AuthPage()));
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            UserDisplayWidget(userId: userId),
            const Spacer(),
            CupertinoButton(
              child: const Text('Settings'),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
