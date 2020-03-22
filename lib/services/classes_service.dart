import 'package:dio/dio.dart';
import 'package:sevenclass/models/default_model.dart';
import 'package:sevenclass/models/my_classes_model.dart';

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

  Future<MyClassesModel> getMyClass() async {
    try {
      Response response = await dio.get('class');
      return MyClassesModel.fromJson(response.data);
    } catch(e) {
      return MyClassesModel(success: false);
    }
  }

  Future<DefaultModel> createNewClass(Map<String, dynamic> payload) async {
    try {
      Response response = await dio.post('class', data: payload);
      return DefaultModel.fromJson(response.data);
    } catch(e) {
      return DefaultModel(success: false);
    }
  }
}