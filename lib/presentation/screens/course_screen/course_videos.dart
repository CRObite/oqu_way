import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/util/custom_exeption.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

import '../../../config/app_api_endpoints.dart';
import '../../../config/app_colors.dart';
import '../../../domain/media_file.dart';

class CourseVideos extends StatefulWidget {
  const CourseVideos({super.key, required this.description, required this.file});

  final String description;
  final MediaFile? file;

  @override
  State<CourseVideos> createState() => _CourseVideosState();
}

class _CourseVideosState extends State<CourseVideos> {

  FlickManager? flickManager;

  String? videoFilePath;

  Future<void> getVideo(String fileId) async {
    final Dio dio = Dio();

    try {
      String? token = await SharedPreferencesOperator.getAccessToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get<ResponseBody>(
        '${AppApiEndpoints.getVideo}$fileId',
        options: Options(responseType: ResponseType.stream),
      );

      if (response.data != null) {

        print(response.data!.stream);

        final stream = response.data!.stream;

        // Create a temporary file to store video data
        final tempDir = await getTemporaryDirectory();
        final filePath = path.join(tempDir.path, 'video.mp4');
        final file = File(filePath);

        // Write the video data to the file
        await file.writeAsBytes(await stream.toBytes());

        setState(() {
          videoFilePath = filePath;
          flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.file(file),
          );
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.file != null) {
      getVideo(widget.file!.id);
    }
  }

  @override
  void dispose() {
    flickManager?.dispose();
    if (videoFilePath != null) {
      final file = File(videoFilePath!);
      if (file.existsSync()) {
        file.deleteSync();
        print('deleted');
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    '<  ${AppText.video}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (flickManager != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: FlickVideoPlayer(flickManager: flickManager!),
                          )
                        else
                          Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.black,
                            ),
                            child: Center(child: CircularProgressIndicator(color: AppColors.blueColor)),
                          ),
                        const SizedBox(height: 36),
                        Text(
                          AppText.description,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.description,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 96),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
