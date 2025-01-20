import 'package:dartz/dartz.dart';

abstract class MailsRepository {
  Future<Either> getUserMailServers();
  Future<Either> getMailsFromAddress(String address);
  Future<Either> getMailDetails(String mailId);
  Future<Either> deleteMail(String mailId);
}
