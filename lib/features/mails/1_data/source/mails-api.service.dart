import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/source/auth-local.service.dart';
import 'package:newsfunnel_frontend/core/constants/api_urls.dart';
import 'package:newsfunnel_frontend/core/network/dio_client.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

abstract class MailsApiService {
  Future<Either> getUserMailServers();
  Future<Either> getMailsFromAddress(String emailAddress);
  Future<Either> getMailDetails(String mailId);
  Future<Either> deleteMail(String mailId);
}

class MailsApiServiceImpl extends MailsApiService {
  @override
  Future<Either> getUserMailServers() async {
    try {
      final accessToken = await serviceLocator<AuthLocalService>().getAccessToken();

      final response = await serviceLocator<DioClient>().get(
        ApiUrls.getUserMailServers,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return Right(response);
    } on DioException catch (error) {
      if (error.response != null) return Left(error.response!.data['message']);
      return Left(error.message);
    }
  }

  @override
  Future<Either> getMailsFromAddress(String emailAddress) async {
    try {
      final accessToken = await serviceLocator<AuthLocalService>().getAccessToken();

      final response = await serviceLocator<DioClient>().get(
        '${ApiUrls.getMailsFromAddress}/$emailAddress',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return Right(response);
    } on DioException catch (error) {
      if (error.response != null) return Left(error.response!.data['message']);
      return Left(error.message);
    }
  }

  @override
  Future<Either> getMailDetails(String mailId) async {
    try {
      final accessToken = await serviceLocator<AuthLocalService>().getAccessToken();

      final response = await serviceLocator<DioClient>().get(
        '${ApiUrls.getMailDetails}/$mailId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return Right(response);
    } on DioException catch (error) {
      if (error.response != null) return Left(error.response!.data['message']);
      return Left(error.message);
    }
  }

  @override
  Future<Either> deleteMail(String mailId) async {
    try {
      final accessToken = await serviceLocator<AuthLocalService>().getAccessToken();

      final response = await serviceLocator<DioClient>().delete(
        '${ApiUrls.deleteMail}/$mailId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return Right(response);
    } on DioException catch (error) {
      if (error.response != null) return Left(error.response!.data['message']);
      return Left(error.message);
    }
  }
}
