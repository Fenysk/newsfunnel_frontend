import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-mail-details.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

part 'mail_details.state.dart';

class MailDetailsCubit extends Cubit<MailDetailsState> {
  MailDetailsCubit() : super(MailDetailsInitialState());

  Future<void> getMailDetails(String mailId) async {
    emit(MailDetailsLoadingState());

    final Either result = await serviceLocator<GetMailDetailsUsecase>().execute(request: mailId);

    result.fold(
      (error) => emit(MailDetailsErrorState(error.toString())),
      (mail) => emit(MailDetailsLoadedState(mail)),
    );
  }
}
