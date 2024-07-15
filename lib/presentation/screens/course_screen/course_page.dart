import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    List<Subject> value = await CourseRepository().getAllCourseSubjects(TempToken.token);
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

              ListView.builder(
                  itemCount: subjects.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) {
                    return GestureDetector(
                        onTap: (){
                          context.goNamed('courseDetails');
                        },
                        child: CoursesCard(courseName: subjects[index].name,)
                    );
                  }
              ),


              const SizedBox(height: 69,),
            ],
          ),
        ),
      ),
    );
  }
}
