import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/template/3_presentation/bloc/exemple-display.cubit.dart';
import 'package:newsfunnel_frontend/template/3_presentation/bloc/exemple-display.state.dart';

class ExemplePage extends StatelessWidget {
  const ExemplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExempleDisplayCubit()..displayExemple(),
      child: BlocBuilder<ExempleDisplayCubit, ExempleDisplayState>(
        builder: (context, state) {
          if (state is ExempleDisplayLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExempleDisplayFailure) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is ExempleDisplayLoaded) {
            return Center(child: Text(state.exemple.id));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
