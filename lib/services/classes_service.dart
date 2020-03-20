import 'package:dio/dio.dart';
import 'package:sevenclass/models/default_model.dart';

import '../app.dart';

class ClassesServices {
  Dio dio = App().dio;

  Future<DefaultModel> classEnroll(Map<String, dynamic> payload) async {
    try {
      Response response = await dio.post('class/enroll', data: payload);
      return DefaultModel.fromJson(response.data);
    } catch(e) {
      return DefaultModel(success: false);
    }
  }
}