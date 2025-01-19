import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/repository/users.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class GetUserProfileUsecase implements Usecase<Either, String> {
  @override
  Future<Either> execute({
    String? request,
  }) async {
    return serviceLocator<UsersRepository>().getUserProfile(request!);
  }
}
