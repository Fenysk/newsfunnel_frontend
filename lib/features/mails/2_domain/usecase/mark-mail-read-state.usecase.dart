import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/core/usecase/usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class MarkMailReadStateUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> execute({
    dynamic request,
  }) async {
    final String mailId = request['mailId'];
    final bool isRead = request['isRead'];
    return serviceLocator<MailsRepository>().markMailReadState(mailId, isRead);
  }
}
