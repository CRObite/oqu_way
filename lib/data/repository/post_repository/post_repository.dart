import 'package:dio/dio.dart';
import 'package:oqu_way/domain/pagination.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/post.dart';

class PostRepository {

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<Pagination?> getAllPost(String accessToken,int id, int page, int size) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      AppApiEndpoints.getAllPost,
      data: {
        "appUserId": id,
        "page": page,
        "size": size,
      }
    );

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);
      return Pagination.fromJson(response.data);
    } else {
      return null;
    }
  }


  Future<Post?> getPostById(String accessToken,int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
        '${AppApiEndpoints.getPostById}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {
      return Post.fromJson(response.data);
    } else {
      return null;
    }
  }


}