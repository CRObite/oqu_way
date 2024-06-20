import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/courses_card.dart';

import '../../../config/app_text.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

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
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) {
                    return GestureDetector(
                        onTap: (){
                          context.goNamed('courseDetails');
                        },
                        child: const CoursesCard()
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
