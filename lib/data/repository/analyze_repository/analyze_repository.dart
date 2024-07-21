import 'package:dio/dio.dart';
import 'package:oqu_way/domain/specialization.dart';

import '../../../config/app_api_endpoints.dart';

class AnalyzeRepository{

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<List<Specialization>> getAnalyzeResult(String accessToken, List<int> specializationIds,int entResult ) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.analyzeResult,
      queryParameters: {
        'specializationIds': specializationIds,
        'entResult': entResult
      }
    );

    if (response.statusCode! ~/ 100 == 2) {

      List<Specialization> data = [];

      for(var item in response.data){
        data.add(Specialization.fromJson(item));
      }

      return data;
    } else {
      return [];
    }
  }

  Future<List<Specialization>> getSpecialisations(String accessToken,List<int> subjectIds  ) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getSpecializations,
      queryParameters: {
        'subjectIds':subjectIds
      }
    );

    if (response.statusCode! ~/ 100 == 2) {

      List<Specialization> data = [];

      for(var item in response.data){
        data.add(Specialization.fromJson(item));
      }

      return data;
    } else {
      return [];
    }
  }
}