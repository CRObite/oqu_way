import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oqu_way/domain/face_subject.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/app_user.dart';
import '../../local/shared_preferences_operator.dart';

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

  Future<bool> registration(String email,String phoneNumber, String firstName,String lastName, String iin) async {

    final response = await dio.post(
      AppApiEndpoints.registration,
      data: {
        "email": email,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
        "iin": iin
      }
    );

    if (response.statusCode! ~/ 100 == 2) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String email,String password) async {

    final response = await dio.post(
        AppApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        }
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      AppUser user = AppUser.fromJson(response.data['user']);

      await SharedPreferencesOperator.saveAccessToken(response.data['accessToken']);
      await SharedPreferencesOperator.saveRefreshToken(response.data['refreshToken']);
      await SharedPreferencesOperator.saveCurrentUser(jsonEncode(user.toJson()));

      return true;
    } else {
      return false;
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