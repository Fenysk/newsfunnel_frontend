import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state.dart';

class CustomLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomLoadingButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingButtonCubit, LoadingButtonState>(
      builder: (context, state) {
        return switch (state) {
          LoadingButtonLoadingState() => _buildLoading(context),
          LoadingButtonSuccessState() => _buildSuccess(context),
          LoadingButtonFailureState() => _buildFailure(context, state),
          _ => _buildInitial(context),
        };
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: null,
      child: const CupertinoActivityIndicator(),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: CupertinoColors.white),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: null,
      child: const Text(
        'Success',
        style: TextStyle(color: CupertinoColors.white),
      ),
    );
  }

  Widget _buildFailure(BuildContext context, LoadingButtonFailureState state) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: Text(
        state.errorMessage,
        style: const TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
