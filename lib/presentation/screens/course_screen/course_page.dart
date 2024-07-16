import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/course_repository/course_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/courses_card.dart';

import '../../../config/app_text.dart';
import '../../../domain/subject.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {

  List<Subject> subjects = [];

  @override
  void initState() {
    getAllCourses();
    super.initState();
  }

  Future<void> getAllCourses() async {

    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Subject> value = await CourseRepository().getAllCourseSubjects(token!);
    setState(() {
      subjects = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(AppText.myCourses, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              subjects.isNotEmpty? ListView.builder(
                  itemCount: subjects.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) {
                    return GestureDetector(
                        onTap: (){
                          context.goNamed('courseDetails', extra: {'courseId': subjects[index].id});
                        },
                        child: CoursesCard(courseName: subjects[index].name ?? '???', percent: subjects[index].percentage ?? 0.0,)
                    );
                  }
              ): const Center(
                child: Text('Курстар жоқ'),
              ),


              const SizedBox(height: 69,),
            ],
          ),
        ),
      ),
    );
  }
}
