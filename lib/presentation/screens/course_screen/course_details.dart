import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/course_repository/course_repository.dart';
import 'package:oqu_way/presentation/screens/course_screen/course_details_cubit/course_details_cubit.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/common_progress_indicatore.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_nested_list.dart';

import '../../../config/app_colors.dart';
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


  CourseDetailsCubit courseDetailsCubit =CourseDetailsCubit();

  @override
  void initState() {
    if (widget.courseId != null) {
      CourseDetailsCubit.courseId = widget.courseId;
      courseDetailsCubit.getCourseInfo();
    }else{
      print('widget.courseId == null');
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => courseDetailsCubit,
      child: BlocBuilder<CourseDetailsCubit,CourseDetailsState>(
        builder: (context,state){
          if(state is CourseDetailsLoading){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,))
            );
          }else if(state is CourseDetailsFetched){
            return SingleChildScrollView(
              child: Container(
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
                                '${AppText.myCourses} > ${state.subject.name}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            state.subject.name ?? '???',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          // Text('${AppText.teacher}: ФИО учителя', style: const TextStyle(fontSize: 15),),
                          // const SizedBox(height: 22,),
                          // const Row(
                          //   children: [
                          //     IconTextSmallContainer(iconPath: 'assets/icons/ic_calendar.svg', title: '12 ақпан',),
                          //     SizedBox(width: 12,),
                          //     IconTextSmallContainer(iconPath: 'assets/icons/ic_time.svg', title: '12:00',),
                          //   ],
                          // ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CommonProgressIndicator(
                                      percent: state.subject.percentage ?? 0.0,
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${((state.subject.percentage ?? 0.0) * 100).round()}%',
                                  style:
                                  TextStyle(color: AppColors.greenColor),
                                ),
                              ],
                            ),
                          ),

                          ListView.builder(
                              itemCount: state.subject.modules.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SubjectNestedList(
                                  module: state.subject.modules[index],
                                  subject: state.subject.name ?? '',
                                  onChanged: () { courseDetailsCubit.getCourseInfo(); }, context: context,
                                );
                              }),

                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      )),
                ),
              ),
            );
          }else{
            return const SizedBox();
          }
        },
      ),
    );
  }
}
