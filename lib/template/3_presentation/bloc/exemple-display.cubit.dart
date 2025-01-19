import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/template/2_domain/usecase/get-exemple.usecase.dart';
import 'package:newsfunnel_frontend/template/3_presentation/bloc/exemple-display.state.dart';

class ExempleDisplayCubit extends Cubit<ExempleDisplayState> {
  ExempleDisplayCubit() : super(ExempleDisplayLoading());

  void displayExemple() async {
    final Either result = await serviceLocator<GetExempleUsecase>().execute();

    result.fold(
      (error) => emit(ExempleDisplayFailure(errorMessage: error.toString())),
      (exemple) => emit(ExempleDisplayLoaded(exemple: exemple)),
    );
  }
}
