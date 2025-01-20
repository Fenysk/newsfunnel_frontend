part of 'mail-details.cubit.dart';

abstract class MailDetailsState extends Equatable {
  const MailDetailsState();

  @override
  List<Object> get props => [];
}

class MailDetailsInitialState extends MailDetailsState {}

class MailDetailsLoadingState extends MailDetailsState {}

class MailDetailsErrorState extends MailDetailsState {
  final String message;

  const MailDetailsErrorState(this.message);

  @override
  List<Object> get props => [
        message
      ];
}

class MailDetailsLoadedState extends MailDetailsState {
  final MailEntity mail;

  const MailDetailsLoadedState(this.mail);

  @override
  List<Object> get props => [
        mail
      ];
}
