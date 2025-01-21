part of 'mail_details.cubit.dart';

abstract class MailDetailsState extends Equatable {
  const MailDetailsState();

  @override
  List<Object> get props => [];
}

class MailDetailsLoadingState extends MailDetailsState {}

class MailDetailsLoadedState extends MailDetailsState {
  final MailEntity mail;

  const MailDetailsLoadedState(this.mail);

  @override
  List<Object> get props => [
        mail
      ];
}

class MailDetailsErrorState extends MailDetailsState {
  final String errorMessage;

  const MailDetailsErrorState(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage
      ];
}

class MailDetailsInitialState extends MailDetailsState {}
