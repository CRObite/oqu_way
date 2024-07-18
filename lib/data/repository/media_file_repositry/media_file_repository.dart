import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:oqu_way/config/app_toast.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:path_provider/path_provider.dart';


import '../../../config/app_api_endpoints.dart';

class MediaFileRepository{

  Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 3 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
      )
  );


  Future<Uint8List?> downloadFile( String fileId) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    dio.options.headers['Authorization'] = 'Bearer $token';

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


  Future<String> pickFile() async {
    print('picker');

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if(file.path != null){
        return file.path!;
      }else{
        return '';
      }
    } else {
      return '';
    }
  }


  Future<void> downloadUint8List(String filename, Uint8List bytes) async {
    try {
      final directory = await getTemporaryDirectory();

      final file = File('${directory.path}/oqu_way_files');

      await file.writeAsBytes(bytes);

      final params = SaveFileDialogParams(
        sourceFilePath: file.path,
        fileName: filename,
      );

      final result = await FlutterFileDialog.saveFile(params: params);


      if (result != null) {
        print('File saved at $result');
      } else {
        print('File save canceled');
      }
    } catch (e) {

      AppToast.showToast('Файл сақталмады');

      print('Error downloading file: $e');
    }
  }
}