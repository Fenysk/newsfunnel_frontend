import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail-server.model.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail.model.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/source/mails-api.service.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-server.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/dto/link-mail-server.request.dart';
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

  @override
  Future<Either> getMailDetails(String mailId) async {
    Either result = await serviceLocator<MailsApiService>().getMailDetails(mailId);

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        MailModel mailModel = MailModel.fromMap(response.data);

        MailEntity mailEntity = mailModel.toEntity();

        return Right(mailEntity);
      },
    );
  }

  @override
  Future<Either> deleteMail(String mailId) async {
    Either result = await serviceLocator<MailsApiService>().deleteMail(mailId);

    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }

  @override
  Future<Either> markMailReadState(String mailId, bool isRead) async {
    Either result = await serviceLocator<MailsApiService>().markMailReadState(mailId, isRead);

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        MailModel mailModel = MailModel.fromMap(response.data);

        MailEntity mailEntity = mailModel.toEntity();

        return Right(mailEntity);
      },
    );
  }

  @override
  Future<Either> generateSummary(String mailId) async {
    Either result = await serviceLocator<MailsApiService>().generateSummary(mailId);

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        MailModel mailModel = MailModel.fromMap(response.data);

        MailEntity mailEntity = mailModel.toEntity();

        return Right(mailEntity);
      },
    );
  }

  @override
  Future<Either> unlinkMailServer(String emailAddress) async {
    Either result = await serviceLocator<MailsApiService>().unlinkMailServer(emailAddress);

    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }

  @override
  Future<Either> linkMailServer(LinkMailServerRequest linkMailServerRequest) async {
    Either result = await serviceLocator<MailsApiService>().linkMailServer(linkMailServerRequest);

    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }
}
