import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail-server.model.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail.model.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/source/mails-api.service.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-server.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class MailsRepositoryImpl extends MailsRepository {
  @override
  Future<Either> getUserMailServers() async {
    Either result = await serviceLocator<MailsApiService>().getUserMailServers();

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        List<MailServerModel> mailServersModels = (response.data as List).map((server) => MailServerModel.fromMap(server)).toList();

        List<MailServerEntity> mailServersEntities = mailServersModels.map((model) => model.toEntity()).toList();

        return Right(mailServersEntities);
      },
    );
  }

  @override
  Future<Either> getMailsFromAddress(String address) async {
    Either result = await serviceLocator<MailsApiService>().getMailsFromAddress(address);

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        List<MailModel> mailModels = (response.data as List).map((mail) => MailModel.fromMap(mail)).toList();

        List<MailEntity> mailEntities = mailModels.map((model) => model.toEntity()).toList();

        return Right(mailEntities);
      },
    );
  }
}
