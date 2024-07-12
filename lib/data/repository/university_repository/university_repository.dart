import 'package:dio/dio.dart';
import 'package:oqu_way/domain/pagination.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/university.dart';

class UniversityRepository{
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );

  Future<Pagination?> getAllUniversity(
      String accessToken,
      int page,
      int size,
      int? cityId,
      int? specializationId,
      String query) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';


    print(page);
    print(size);

    final response = await dio.get(
      AppApiEndpoints.getAllUniversity,
      data: {
        "page": page,
        "size": size,
        "cityId": cityId,
        "specializationId": specializationId,
        "query": query,
      }
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return Pagination.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<University?> getUniversityById(String accessToken, int universityId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getUniversityById}$universityId',
    );

    if (response.statusCode! ~/ 100 == 2) {
      return University.fromJson(response.data);
    } else {
      return null;
    }
  }
}