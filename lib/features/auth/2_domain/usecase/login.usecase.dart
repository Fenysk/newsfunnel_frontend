import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/dto/login.request.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/repository/auth.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class LoginUsecase implements Usecase<Either, LoginRequest> {
  @override
  Future<Either> execute({
    LoginRequest? request,
  }) async {
    return serviceLocator<AuthRepository>().login(request!);
  }
}
