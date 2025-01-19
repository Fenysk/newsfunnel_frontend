import 'package:equatable/equatable.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-server.entity.dart';

abstract class UserMailServersDisplayState extends Equatable {
  const UserMailServersDisplayState();

  @override
  List<Object> get props => [];
}

class UserMailServersDisplayLoading extends UserMailServersDisplayState {}

class UserMailServersDisplayLoaded extends UserMailServersDisplayState {
  final List<MailServerEntity> mailServers;

  const UserMailServersDisplayLoaded({required this.mailServers});
}

class UserMailServersDisplayFailure extends UserMailServersDisplayState {
  final String errorMessage;

  const UserMailServersDisplayFailure({required this.errorMessage});
}
