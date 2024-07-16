import 'package:dio/dio.dart';
import 'package:oqu_way/domain/city.dart';

import '../../../config/app_api_endpoints.dart';

class DictionaryRepository {
  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );

  Future<List<City>> getAllCities(String accessToken) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getAllCities,
    );

    if (response.statusCode! ~/ 100 == 2) {

      List<City> cities = [];

      for(var item in response.data){
        cities.add(City.fromJson(item));
      }

      return cities;
    } else {
      return [];
    }
  }

}