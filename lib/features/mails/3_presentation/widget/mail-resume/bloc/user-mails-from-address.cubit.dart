import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-mails-from-address.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/widget/mail-resume/bloc/user-mails-from-address.state.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class UserMailsFromAddressCubit extends Cubit<UserMailsFromAddressState> {
  UserMailsFromAddressCubit() : super(UserMailsFromAddressLoading());

  Future<void> displayUserMailsFromAddress(String address) async {
    final Either result = await serviceLocator<GetMailsFromAddressUsecase>().execute(request: address);

    result.fold(
      (error) => emit(UserMailsFromAddressFailure(errorMessage: error.toString())),
      (mails) => emit(UserMailsFromAddressLoaded(mails: mails)),
    );
  }
}
