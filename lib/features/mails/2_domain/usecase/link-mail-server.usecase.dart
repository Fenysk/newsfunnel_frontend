import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/dto/link-mail-server.request.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class LinkMailServerUsecase implements Usecase<Either, LinkMailServerRequest> {
  @override
  Future<Either> execute({
    LinkMailServerRequest? request,
  }) async {
    return serviceLocator<MailsRepository>().linkMailServer(request!);
  }
}
