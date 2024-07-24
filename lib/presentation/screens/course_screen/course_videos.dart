import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_colors.dart';
import '../../../domain/media_file.dart';

class CourseVideos extends StatefulWidget {
  const CourseVideos(
      {super.key, required this.description, required this.file});

  final String description;
  final MediaFile? file;

  @override
  State<CourseVideos> createState() => _CourseVideosState();
}

class _CourseVideosState extends State<CourseVideos> {
  FlickManager? flickManager;

  String? videoUrl = '';

  Future<void> getVideo(String fileId) async {
    try {
      String? token = await SharedPreferencesOperator.getAccessToken();

      setState(() {
        flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
              'https://api.oquway.kz/api/media/video/$fileId?access_token=Bearer $token')),
        );
      });
    } catch (e) {
      print('Failed to get video: $e');
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child:
                                FlickVideoPlayer(flickManager: flickManager!),
                          )
                        else
                          Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.black,
                            ),
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.blueColor)),
                          ),
                        const SizedBox(height: 36),
                        Text(
                          AppText.description,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
