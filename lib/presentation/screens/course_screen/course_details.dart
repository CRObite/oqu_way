import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/common_progress_indicatore.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/icon_text_small_container.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_nested_list.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppText.myCourses} > Математика', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 14,),
                const Text('Математика', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 22,),
                Text('${AppText.teacher}: ФИО учителя', style: const TextStyle(fontSize: 15),),
                const SizedBox(height: 22,),
                const Row(
                  children: [
                    IconTextSmallContainer(iconPath: 'assets/icons/ic_calendar.svg', title: '12 ақпан',),
                    SizedBox(width: 12,),
                    IconTextSmallContainer(iconPath: 'assets/icons/ic_time.svg', title: '12:00',),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const Expanded(child: CommonProgressIndicator()),
                      const SizedBox(width: 5,),
                      Text('70%', style: TextStyle(color: AppColors.greenColor),),
                    ],
                  ),
                ),

                ListView.builder(
                  itemCount: FakeSubject.listOfOpened.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){

                    if(index == 0){
                      return SubjectNestedList(
                          opened: FakeSubject.listOfOpened[index].opened,
                          openedPressed: (){
                           setState(() {
                             FakeSubject.listOfOpened[index].opened= !FakeSubject.listOfOpened[index].opened;
                           });
                          },
                          isFirst: true
                      );
                    }

                    return SubjectNestedList(
                        opened: FakeSubject.listOfOpened[index].opened,
                        openedPressed: (){
                          setState(() {
                            FakeSubject.listOfOpened[index].opened= !FakeSubject.listOfOpened[index].opened;
                          });
                        },
                        isFirst: false
                    );
                  }
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
}
