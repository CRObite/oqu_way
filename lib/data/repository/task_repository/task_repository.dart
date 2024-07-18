import 'package:dio/dio.dart';
import 'package:oqu_way/domain/pagination.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/task.dart';
import '../../../domain/university.dart';

class TaskRepository{
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<Task?> getTaskById(String accessToken, int taskId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getTaskById}$taskId',
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return Task.fromJson(response.data);
    } else {
      return null;
    }
  }
}