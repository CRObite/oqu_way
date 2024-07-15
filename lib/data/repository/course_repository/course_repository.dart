import 'package:dio/dio.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/subject.dart';

class CourseRepository{

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<List<Subject>> getAllCourseSubjects(String accessToken) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getAllSubjects,
    );

    if (response.statusCode! ~/ 100 == 2) {
      List<dynamic> values = response.data;
      List<Subject> subjects = [];

      for(var item in values){
        subjects.add(Subject.fromJson(item));
      }

      return subjects;
    } else {
      return [];
    }
  }

  Future<Subject?> getCourseSubjectById(String accessToken, int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getSubjectById}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {
      List<dynamic> values = response.data;
      return Subject.fromJson(values.first);
    } else {
      return null;
    }
  }

}