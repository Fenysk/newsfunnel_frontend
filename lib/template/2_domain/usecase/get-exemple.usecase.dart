import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/template/2_domain/repository/exemple.repository.dart';

class GetExempleUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> execute({
    dynamic request,
  }) async {
    return serviceLocator<ExempleRepository>().getExemple();
  }
}
