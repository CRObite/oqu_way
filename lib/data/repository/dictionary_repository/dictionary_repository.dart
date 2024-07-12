import 'package:dio/dio.dart';

import '../../../config/app_api_endpoints.dart';

class DictionaryRepository {
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );

  // Future<int?> userGetMyId(String accessToken) async {
  //   dio.options.headers['Authorization'] = 'Bearer $accessToken';
  //
  //   final response = await dio.get(
  //     AppApiEndpoints.getAllCities,
  //   );
  //
  //   if (response.statusCode! ~/ 100 == 2) {
  //     return response.data['id'];
  //   } else {
  //     return null;
  //   }
  // }

}