import 'package:dartz/dartz.dart';

abstract class MailsRepository {
  Future<Either> getUserMailServers();
}
