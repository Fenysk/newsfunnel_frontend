import 'package:dartz/dartz.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/dto/link-mail-server.request.dart';

abstract class MailsRepository {
  Future<Either> getUserMailServers();
  Future<Either> getMailsFromAddress(String address);
  Future<Either> getMailDetails(String mailId);
  Future<Either> deleteMail(String mailId);
  Future<Either> markMailReadState(String mailId, bool isRead);
  Future<Either> generateSummary(String mailId);
  Future<Either> unlinkMailServer(String emailAddress);
  Future<Either> linkMailServer(LinkMailServerRequest linkMailServerRequest);
}
