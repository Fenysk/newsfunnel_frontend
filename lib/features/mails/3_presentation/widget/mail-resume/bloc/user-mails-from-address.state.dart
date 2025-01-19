import 'package:equatable/equatable.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';

abstract class UserMailsFromAddressState extends Equatable {
  const UserMailsFromAddressState();

  @override
  List<Object> get props => [];
}

class UserMailsFromAddressLoading extends UserMailsFromAddressState {}

class UserMailsFromAddressLoaded extends UserMailsFromAddressState {
  final List<MailEntity> mails;

  const UserMailsFromAddressLoaded({required this.mails});

  @override
  List<Object> get props => [
        mails
      ];
}

class UserMailsFromAddressFailure extends UserMailsFromAddressState {
  final String errorMessage;

  const UserMailsFromAddressFailure({required this.errorMessage});

  @override
  List<Object> get props => [
        errorMessage
      ];
}
