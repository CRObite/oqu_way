import 'package:dio/dio.dart';

import '../../../config/app_api_endpoints.dart';

class AuthorizationRepository {

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  // Future<void> getAllCities(String accessToken) async {
  //   dio.options.headers['Authorization'] = 'Bearer $accessToken';
  //
  //   final response = await dio.get(
  //     AppApiEndpoints.getAllCities,
  //   );
  //
  //   if (response.statusCode! ~/ 100 == 2) {
  //
  //     print(response.data);
  //     List<dynamic> data = response.data as List<dynamic>;
  //     List<City> listOfCities = data
  //         .map((json) => City.fromJson(json as Map<String, dynamic>))
  //         .toList();
  //
  //
  //     return listOfCities;
  //   } else {
  //     return [];
  //   }
  // }

  Future<int?> userGetMyId(String accessToken) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getMe,
    );

    if (response.statusCode! ~/ 100 == 2) {
      return response.data['id'];
    } else {
      return null;
    }
  }

}