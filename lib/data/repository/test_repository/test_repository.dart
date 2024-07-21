import 'package:dio/dio.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/domain/pagination.dart';
import 'package:oqu_way/domain/test_result.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/task.dart';
import '../../../domain/university.dart';

class TestRepository{
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<AppTest?> getTestById(String accessToken, int testId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getTestById}$testId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return AppTest.fromJson(response.data);
    } else {
      return null;
    }
  }


  Future<bool> startTest(String accessToken, int testId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.put(
      '${AppApiEndpoints.startTest}$testId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }


  Future<bool> endTest(String accessToken, int testId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.put(
      '${AppApiEndpoints.endTest}$testId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setUserAnswer(String accessToken, int questionId, int optionId, int? subOptionId ,bool value ) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    print(questionId);
    print(optionId);

    print(value);

    final response = await dio.post(
      AppApiEndpoints.userAnswer,
      data: {
        "questionId": questionId,
        "optionId": optionId,
        "subOptionId": subOptionId,
        "value": value
      }
    );


    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return true;
    } else {
      return false;
    }
  }

  Future<TestResult?> getTestResult(String accessToken, int testId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getTestResult}$testId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return TestResult.fromJson(response.data);
    } else {
      return null;
    }
  }

}