import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class GenerateSummaryUsecase implements Usecase<Either, String> {
  @override
  Future<Either> execute({
    String? request,
  }) async {
    return serviceLocator<MailsRepository>().generateSummary(request!);
  }
}
