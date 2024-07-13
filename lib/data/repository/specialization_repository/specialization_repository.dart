import 'package:dio/dio.dart';
import 'package:oqu_way/domain/specialization.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/pagination.dart';

class SpecializationRepository{
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<Pagination?> getAllSpecializations(String accessToken,int id, int page, int size, String query) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
        AppApiEndpoints.getAllSpecialization,
        data: {
          "page": page,
          "size": size,
          "universityId": id,
          "query": query
        }
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      return Pagination.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<Specialization?> getSpecializationsById(String accessToken,int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';


    final response = await dio.get(
      '${AppApiEndpoints.getSpecializationById}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {
      return Specialization.fromJson(response.data);
    } else {
      return null;
    }
  }

}