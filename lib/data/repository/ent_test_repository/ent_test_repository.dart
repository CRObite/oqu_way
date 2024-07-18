import 'package:dio/dio.dart';
import 'package:oqu_way/domain/city.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/subject.dart';

class EntTestRepository {
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );

  Future<List<Subject>> getAllEntSubjects(String accessToken) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getEntSubjects,
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      List<Subject> subjects = [];

      for(var item in response.data){
        subjects.add(Subject.fromJson(item));
      }

      return subjects;
    } else {
      return [];
    }
  }


  Future<List<Subject>> getAllEntSubjectsByFirst(String accessToken,int  id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getEntSubjectByFirst,
      queryParameters: {
        "subjectId": id
      }
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      List<Subject> subjects = [];

      for(var item in response.data){
        subjects.add(Subject.fromJson(item));
      }

      return subjects;
    } else {
      return [];
    }
  }


}