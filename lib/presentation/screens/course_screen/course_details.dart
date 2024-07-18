import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/course_repository/course_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/common_progress_indicatore.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/icon_text_small_container.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_nested_list.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';
import '../../../data/local/shared_preferences_operator.dart';
import '../../../domain/subject.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.courseId});

  final int? courseId;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {

  Subject? subject;

  @override
  void initState() {
    if(widget.courseId!= null){
      getCourseInfo();
    }

    super.initState();
  }

  Future<void> getCourseInfo() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    Subject? value = await CourseRepository().getCourseSubjectById(token!, widget.courseId!);

    setState(() {
      subject = value;
    });

  }

  @override
  Widget build(BuildContext context) {
    return subject!= null ? SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){context.pop();},
                    child: Text('${AppText.myCourses} > ${subject!.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                const SizedBox(height: 14,),
                Text(subject!.name ?? '???', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 22,),
                Text('${AppText.teacher}: ФИО учителя', style: const TextStyle(fontSize: 15),),
                const SizedBox(height: 22,),
                // const Row(
                //   children: [
                //     IconTextSmallContainer(iconPath: 'assets/icons/ic_calendar.svg', title: '12 ақпан',),
                //     SizedBox(width: 12,),
                //     IconTextSmallContainer(iconPath: 'assets/icons/ic_time.svg', title: '12:00',),
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(child: CommonProgressIndicator(percent: subject!.percentage ?? 0.0,)),
                      const SizedBox(width: 5,),
                      Text('${((subject!.percentage ?? 0.0) * 100).round()}%', style: TextStyle(color: AppColors.greenColor),),
                    ],
                  ),
                ),

                ListView.builder(
                  itemCount: subject!.modules.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return SubjectNestedList(
                        module: subject!.modules[index], subject: subject!.name ?? '',
                    );
                  }
                ),

                const SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
    ): const SizedBox();
  }
}
