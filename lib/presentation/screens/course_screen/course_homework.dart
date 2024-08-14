
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/media_file_repositry/media_file_repository.dart';
import 'package:oqu_way/data/repository/task_repository/task_repository.dart';
import 'package:oqu_way/domain/media_file.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';
import '../../../domain/task.dart';
import 'course_details_cubit/course_details_cubit.dart';

class CourseHomework extends StatefulWidget {
  const CourseHomework({super.key, required this.taskId, this.context});

  final int? taskId;
  final BuildContext? context;

  @override
  State<CourseHomework> createState() => _CourseHomeworkState();
}

class _CourseHomeworkState extends State<CourseHomework> {

  TextEditingController controller = TextEditingController();
  List<MediaFile> titles = [];
  Task? task;


  @override
  void initState() {
    if(widget.taskId!= null){
      getTaskById();
    }
    super.initState();
  }

  Future<void> getTaskById() async {
    String? token = await SharedPreferencesOperator.getAccessToken();
    Task? value = await TaskRepository().getTaskById(token!, widget.taskId!);

    setState(() {
      task = value;
    });
  }

  Future<void> sendAnswer() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool value = await TaskRepository().createAnswer(token!, task!.id, controller.text, titles);

    if(value){

      if(widget.context!= null){
        widget.context!.read<CourseDetailsCubit>().getCourseInfo();
      }

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarHeight: 70,
          leading:
          IconButton(onPressed: () { context.pop(); }, icon: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, ),),
          title: Text(AppText.homeworks, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        ),
        body: task!= null ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Тапсырма уақыты',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    task!.deadline != null ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 11),
                        child: DateTimeRow(color: AppColors.greenColor,)
                      ),
                    ): const Text('мерзім жоқ'),
                  ],
                ),

                const SizedBox(height: 15,),

                Text('Тақырыбы', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                Text(task!.name ?? '',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                // Text('Мұғалім', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),
                //
                // const SizedBox(height: 10,),
                //
                // const Text('Harsh Kadyan',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                //
                // const SizedBox(height: 15,),

                Text('Тапсырма сипаттамасы', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                Text(task!.description ?? 'Cипаттама жоқ',
                  style: const TextStyle(fontSize: 13),),

                const SizedBox(height: 15,),

                Text('Материалдар', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                task!.mediaFiles.isNotEmpty ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 3,
                    ),
                    itemCount: task!.mediaFiles.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () async {
                          Uint8List? bytes =  await MediaFileRepository().downloadFile(task!.mediaFiles[index].id);

                          if(bytes!= null){
                            await MediaFileRepository().downloadUint8List(task!.mediaFiles[index].originalName ?? 'oqu_way_file', bytes);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(task!.mediaFiles[index].originalName ?? '???', style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,),maxLines: 1,)),
                        ),
                      );
                    }
                ): const Text('Материалдар жоқ',
                  style: TextStyle(fontSize: 13),),

                const SizedBox(height: 20,),

                const Text('Тапсыру',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                const Text('Тапсырмаға түсіндірме жазып файлды жүктеңіз',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          width: 1,
                          color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: TextFormField(
                      controller: controller,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Хабарлама қалдырыңыз...',
                      ),
                    )
                ),

                const SizedBox(height: 15,),

                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: titles.length,
                    itemBuilder: (context,index){
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: Text(titles[index].originalName!.split('/').last, style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,),maxLines: 1,)
                              ),
                            ),

                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap:(){
                                  setState(() {
                                    titles.removeAt(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2, right: 2),
                                  height: 15,
                                  width: 15,
                                  decoration:  BoxDecoration(
                                      color: Colors.grey.shade600,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.close,color: Colors.white,size: 10,),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                ),
                const SizedBox(height: 15,),

                GestureDetector(
                  onTap: () async {
                    String? token = await SharedPreferencesOperator.getAccessToken();
                    String path = await MediaFileRepository().pickFile();

                    MediaFile? file = await MediaFileRepository().uploadFile(token!, path);

                    if(file!= null){
                      setState(() {
                        titles.add(file);
                      });
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          width: 1,
                          color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 50),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Файл жүктеңіз',style: TextStyle(fontSize: 10),),
                        SizedBox(width: 5,),
                        Icon(Icons.upload,size: 14,),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15,),


                GestureDetector(
                  onTap: (){
                    sendAnswer();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 22),
                    child: Text('Жіберу',
                      style: TextStyle(color: AppColors.greenColor,fontSize: 10),
                    )
                  ),
                ),

                const SizedBox(height: 10,),

                // task!.status == 'CHECKED'?
                // GestureDetector(
                //   onTap: (){context.push('/courseHomework/courseHomeworkScore');},
                //   child: Container(
                //       decoration: BoxDecoration(
                //           color: AppColors.blueColor.withOpacity(0.3),
                //           borderRadius: const BorderRadius.all(Radius.circular(5))
                //       ),
                //       padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 22),
                //       child: Text('Бағаны көру',
                //         style: TextStyle(color: AppColors.blueColor,fontSize: 10),
                //       )
                //   ),
                // )
                    // : const SizedBox(),

              ],
            ),
          ),
        ) : const SizedBox(),
    );
  }
}
