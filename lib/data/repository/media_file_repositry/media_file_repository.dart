import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../config/app_api_endpoints.dart';

class MediaFileRepository{

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<Uint8List?> downloadFile(String accessToken, String fileId) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(fileId);

    if (fileInfo != null) {
      return fileInfo.file.readAsBytes();
    } else {

      final response = await dio.get(
        '${AppApiEndpoints.getContent}$fileId',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        print(response.data);

        Uint8List bytes = Uint8List.fromList(response.data);
        await cacheManager.putFile(fileId, bytes);
        return bytes;
      }else{
        return null;
      }
    }

  }

  Future<String> uploadFile(String accessToken, String filePath) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    print(filePath);

    String fileName = filePath.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    print(formData);

    final response = await dio.post(
      AppApiEndpoints.uploadFile,
      data: formData,
    );


    if (response.statusCode == 200) {
      print(response.data);
      String imageId = response.data['id'];
      return imageId;
    }else{
      return '';
    }
  }
}