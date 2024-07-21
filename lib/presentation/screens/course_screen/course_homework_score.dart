import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/media_file_repositry/media_file_repository.dart';
import 'package:oqu_way/data/repository/task_repository/task_repository.dart';
import 'package:oqu_way/domain/task_answer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';
import '../../common/widgets/date_time_row.dart';
import '../../common/widgets/rounded_circular_progress_indicator.dart';
class CourseHomeworkScore extends StatefulWidget {
  const CourseHomeworkScore({super.key, required this.taskId});

  final int? taskId;

  @override
  State<CourseHomeworkScore> createState() => _CourseHomeworkScoreState();
}

class _CourseHomeworkScoreState extends State<CourseHomeworkScore> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  TaskAnswer? answer;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    getAnswer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getAnswer() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    TaskAnswer? value = await TaskRepository().getTaskAnswer(token!, widget.taskId!);
    setState(() {
      answer = value;
      _animation = Tween<double>(
        begin: 0,
        end: answer!.score != null ? answer!.score! / 100 : 0.0,
      ).animate(_controller);
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
        title: const Text(
          'Тапсырмалар > Бағалар',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            answer!= null? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Тапсырма бағасы',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CustomPaint(
                              size: const Size(75, 75),
                              painter: RoundedCircularProgressIndicator(
                                value: _animation.value,
                                color: AppColors.greenColor,
                                strokeWidth: 10,
                                backgroundColor: AppColors.greyColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${answer?.score?.round() ?? ''}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text('${answer?.score?.round() ?? ''}/100',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Тапсырмаға берілген coins : 2 coins',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(height: 20),
                      Text(
                        'Материалдар',
                        style: TextStyle(
                            color: AppColors.greyColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      answer!.mediaFiles.isNotEmpty ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 3,
                          ),
                          itemCount: answer!.mediaFiles.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () async {
                                Uint8List? bytes =  await MediaFileRepository().downloadFile(answer!.mediaFiles[index].id);

                                if(bytes!= null){
                                  await MediaFileRepository().downloadUint8List(answer!.mediaFiles[index].originalName ?? 'oqu_way_file', bytes);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Center(child: Text(answer!.mediaFiles[index].originalName ?? '???', style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,),maxLines: 1,)),
                              ),
                            );
                          }
                      ): const Text('Материалдар жоқ',),

                      const SizedBox(height: 20),
                      Text(
                        'Мұғалімнің пікірі',
                        style: TextStyle(
                            color: AppColors.greyColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.2),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   height: 45,
                                    //   width: 45,
                                    //   decoration: BoxDecoration(
                                    //       color: AppColors.greyColor.withOpacity(0.3),
                                    //       shape: BoxShape.circle),
                                    //   child: const Center(
                                    //     child: Text(
                                    //       'A',
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          answer!.teacherComment ?? 'Мұғалім пікір қалдырған жоқ',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ): const SizedBox(),
            const SizedBox(height: 20),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           height: 45,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: const BorderRadius.all(
            //               Radius.circular(5),
            //             ),
            //             border: Border.all(
            //               width: 1,
            //               color: AppColors.greyColor.withOpacity(0.5),
            //             ),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10),
            //             child: TextFormField(
            //               controller: controller,
            //               keyboardType: TextInputType.text,
            //               style: const TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 hintText: 'Жауап жазу...',
            //                 hintStyle:
            //                 TextStyle(color: AppColors.greyColor.withOpacity(0.5)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 10),
            //       Container(
            //         height: 45,
            //         width: 45,
            //         decoration: BoxDecoration(
            //           color: AppColors.blueColor,
            //           borderRadius: const BorderRadius.all(Radius.circular(5)),
            //         ),
            //         child: const Center(
            //           child: Icon(
            //             Icons.arrow_upward_rounded,
            //             color: Colors.white,
            //             size: 20,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
