import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/repository/auth.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class IsLoggedInUsecase implements Usecase<bool, dynamic> {
  @override
  Future<bool> execute({
    dynamic request,
  }) async {
    return serviceLocator<AuthRepository>().isLoggedIn();
  }
}
