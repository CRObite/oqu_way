import 'package:dio/dio.dart';
import 'package:oqu_way/domain/comment.dart';
import 'package:oqu_way/domain/comments_answer.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../domain/post.dart';
import '../../../domain/specialization.dart';
import '../../../domain/subject.dart';
import '../../../domain/university.dart';

enum CommentType { Post, University, Specialization }

class CommentRepository {
  Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 3 * 1000),
    receiveTimeout: const Duration(milliseconds: 60 * 1000),
  ));

  Future<List<Comment>> getAllNewsComments(String accessToken, int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getAllPostComments}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      List<dynamic> values = response.data;
      List<Comment> comments = [];

      for (var item in values) {
        comments.add(Comment.fromJson(item));
      }

      return comments;
    } else {
      return [];
    }
  }

  Future<List<Comment>> getAllUniversityComments(
      String accessToken, int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      '${AppApiEndpoints.getAllUniversityComments}$id',
    );

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      List<dynamic> values = response.data;
      List<Comment> comments = [];

      for (var item in values) {
        comments.add(Comment.fromJson(item));
      }

      return comments;
    } else {
      return [];
    }
  }

  Future<List<Comment>> getAllSpecializationComments(
      String accessToken, int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response =
        await dio.get('${AppApiEndpoints.getAllSpecializationComments}$id');

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);
      List<dynamic> values = response.data;
      List<Comment> comments = [];

      for (var item in values) {
        comments.add(Comment.fromJson(item));
      }

      return comments;
    } else {
      return [];
    }
  }

  Future<bool> createComments(
      String accessToken,
      String text,
      CommentType type,
      Post? post,
      University? university,
      Specialization? specialization,
      int userId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.post(AppApiEndpoints.saveComments,
        data: {
      "text": text,
      "type": '$type',
      "dateTime": '${DateTime.now()}',
      "post": post,
      "university": university,
      "specialization": specialization,
      "appUser": {
        "id": userId,
      }
    });

    if (response.statusCode! ~/ 100 == 2) {
      print(response.data);

      return true;
    } else {
      return false;
    }
  }
}
