import 'package:dio/dio.dart';
import 'package:oqu_way/domain/face_subject.dart';

import '../../../config/app_api_endpoints.dart';

class AuthorizationRepository {

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


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



  Future<bool> refreshToken(String refreshToken) async {

    final response = await dio.post(
      AppApiEndpoints.refresh,
      queryParameters: {
        'refreshToken': refreshToken
      }
    );

    if (response.statusCode! ~/ 100 == 2) {


      TempToken.token = response.data['accessToken'];
      TempToken.token = response.data['refreshToken'];

      return true;
    } else {
      return false;
    }
  }


}