import 'package:dio/dio.dart';
import 'package:oqu_way/domain/city.dart';
import 'package:oqu_way/domain/ent_result.dart';
import 'package:oqu_way/domain/ent_test.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/app_test.dart';
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


  Future<EntTest?> generateEntTest(String accessToken,int first, int second,String type) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.post(
      AppApiEndpoints.generateEnt,
      data: {
        'firstSubjectId': first,
        'secondSubjectId': second,
        "type": type
      }
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return EntTest.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool> endEntTest(String accessToken,String id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.put(
       '${AppApiEndpoints.endEnt}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return true;
    } else {
      return false;
    }
  }

  Future<EntResult?> resultEntTest(String accessToken,String id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.testResult}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return EntResult.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool> answerEntTest(String accessToken,String id,int questionId,int? optionId,int? subOptionId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.post(
      AppApiEndpoints.answerToTest,
        data: {
          "entTestId": id,
          "questionId": questionId,
          "optionId": optionId,
          "subOptionId": subOptionId
        }
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAnswerEntTest(String accessToken,String id,int questionId,int? optionId,int? subOptionId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.delete(
        AppApiEndpoints.answerToTest,
        data: {
          "entTestId": id,
          "questionId": questionId,
          "optionId": optionId,
          "subOptionId": subOptionId
        }
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return true;
    } else {
      return false;
    }
  }


  Future<EntTest?> getMistakes(String accessToken,String id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
        '${AppApiEndpoints.getMistakes}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return EntTest.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<EntTest?> getLastMistakes(String accessToken,String id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getMistakes}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return EntTest.fromJson(response.data);
    } else {
      return null;
    }
  }



  Future<bool> deleteTest(String accessToken, String testId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.deleteEntTest}$testId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }
}