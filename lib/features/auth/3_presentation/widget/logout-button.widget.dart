import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/logout.usecase.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CupertinoButton(
          child: const Text('Déconnexion'),
          onPressed: () => context.read<LoadingButtonCubit>().execute(usecase: LogoutUsecase()),
        );
      },
    );
  }
}
