import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/template/3_presentation/bloc/exemple-display.cubit.dart';
import 'package:newsfunnel_frontend/template/3_presentation/bloc/exemple-display.state.dart';

class ExempleDisplayWidget extends StatelessWidget {
  const ExempleDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExempleDisplayCubit()..displayExemple(),
      child: BlocListener<ExempleDisplayCubit, ExempleDisplayState>(
        listener: (context, state) {
          if (state is ExempleDisplayLoaded) {
            print('id of exemple : ${state.exemple.id}');
          }
        },
        child: BlocBuilder<ExempleDisplayCubit, ExempleDisplayState>(
          builder: (context, state) {
            return switch (state) {
              ExempleDisplayLoaded() => buildLoadedContent(state),
              ExempleDisplayFailure() => buildFailureContent(state),
              _ => buildLoadingContent(),
            };
          },
        ),
      ),
    );
  }

  Widget buildLoadingContent() => const Center(child: CupertinoActivityIndicator());

  Widget buildFailureContent(ExempleDisplayFailure state) => Center(child: Text(state.errorMessage));

  Widget buildLoadedContent(ExempleDisplayLoaded state) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.exemple.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      );
}
