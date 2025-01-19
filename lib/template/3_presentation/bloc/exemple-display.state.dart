import 'package:equatable/equatable.dart';
import 'package:newsfunnel_frontend/template/2_domain/entity/exemple.entity.dart';

abstract class ExempleDisplayState extends Equatable {
  const ExempleDisplayState();

  @override
  List<Object> get props => [];
}

class ExempleDisplayLoading extends ExempleDisplayState {}

class ExempleDisplayLoaded extends ExempleDisplayState {
  final ExempleEntity exemple;

  const ExempleDisplayLoaded({required this.exemple});
}

class ExempleDisplayFailure extends ExempleDisplayState {
  final String errorMessage;

  const ExempleDisplayFailure({required this.errorMessage});
}
