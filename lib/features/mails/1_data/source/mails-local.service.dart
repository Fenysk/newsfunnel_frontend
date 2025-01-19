import 'package:newsfunnel_frontend/template/1_data/model/exemple.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExempleLocalService {
  Future<ExempleModel> getExemple();
}

class ExempleLocalServiceImpl extends ExempleLocalService {
  @override
  Future<ExempleModel> getExemple() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final currentExempleJson = sharedPreferences.getString('currentExemple');

    if (currentExempleJson == null || currentExempleJson.isEmpty) {
      throw Exception('currentExemple is empty');
    }

    final currentExempleModel = ExempleModel.fromJson(currentExempleJson);

    return currentExempleModel;
  }
}
