import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/logout.usecase.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/bloc/auth.cubit.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/page/auth.page.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<LoadingButtonCubit, LoadingButtonState>(
        listener: (context, state) {
          if (state is LoadingButtonSuccessState || state is LoadingButtonFailureState) {
            context.read<AuthCubit>().logout();
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (_) => const AuthPage()),
              (route) => false,
            );
          }
        },
        child: CupertinoButton(
          child: const Text('Déconnexion'),
          onPressed: () {
            context.read<LoadingButtonCubit>().execute(
                  usecase: LogoutUsecase(),
                );
          },
        ),
      ),
    );
  }
}
