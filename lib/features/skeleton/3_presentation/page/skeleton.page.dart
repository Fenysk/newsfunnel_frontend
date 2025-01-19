import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/bloc/auth.cubit.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/bloc/auth.state.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/page/auth.page.dart';
import 'package:newsfunnel_frontend/features/skeleton/3_presentation/page/authenticated-layout.page.dart';

class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit()..appStarted(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return switch (state) {
            AuthLoadingState() => buildLoadingContent(),
            UnauthenticatedState() => buildUnauthenticatedContent(),
            AuthenticatedState() => buildAuthenticatedContent(),
            _ => Container(),
          };
        },
      ),
    );
  }

  Widget buildLoadingContent() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Threads'),
            SizedBox(height: 16),
            CupertinoActivityIndicator(),
          ],
        ),
      );

  Widget buildUnauthenticatedContent() {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const AuthPage()));
        });
        return Container();
      },
    );
  }

  Widget buildAuthenticatedContent() {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const AuthenticatedLayoutPage()));
        });
        return Container();
      },
    );
  }
}
