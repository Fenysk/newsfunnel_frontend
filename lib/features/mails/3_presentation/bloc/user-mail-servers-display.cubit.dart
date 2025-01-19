import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-user-mail-servers.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/bloc/user-mail-servers-display.state.dart';

class UserMailServersDisplayCubit extends Cubit<UserMailServersDisplayState> {
  UserMailServersDisplayCubit() : super(UserMailServersDisplayLoading());

  void displayUserMailServers() async {
    final Either result = await serviceLocator<GetUserMailServersUsecase>().execute();

    result.fold(
      (error) => emit(UserMailServersDisplayFailure(errorMessage: error.toString())),
      (mailServers) => emit(UserMailServersDisplayLoaded(mailServers: mailServers)),
    );
  }
}
