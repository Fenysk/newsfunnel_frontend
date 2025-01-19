import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/repository/users.repository.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class CheckIfPseudoExistUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> execute({
    dynamic request,
  }) async {
    return serviceLocator<UsersRepository>().checkIfPseudoExist(request);
  }
}
