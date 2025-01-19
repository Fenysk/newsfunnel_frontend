import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'package:newsfunnel_frontend/template/1_data/model/exemple.model.dart';
import 'package:newsfunnel_frontend/template/1_data/source/exemple-api.service.dart';
import 'package:newsfunnel_frontend/template/2_domain/entity/exemple.entity.dart';
import 'package:newsfunnel_frontend/template/2_domain/repository/exemple.repository.dart';

class ExempleRepositoryImpl extends ExempleRepository {
  @override
  Future<Either> getExemple() async {
    Either result = await serviceLocator<ExempleApiService>().getExemple();

    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;

        ExempleModel exempleModel = ExempleModel.fromMap(response.data);
        ExempleEntity exempleEntity = exempleModel.toEntity();

        return Right(exempleEntity);
      },
    );
  }
}
