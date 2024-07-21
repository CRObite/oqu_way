

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../data/repository/course_repository/course_repository.dart';
import '../../../../domain/subject.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());

  static int? courseId;


  Future<void> getCourseInfo() async {

    print('called');

    if(courseId!= null){
      emit(CourseDetailsLoading());

      String? token = await SharedPreferencesOperator.getAccessToken();

      Subject? value = await CourseRepository().getCourseSubjectById(token!, courseId!);

      if(value!= null){
        emit(CourseDetailsFetched(subject: value));
      }
    }
  }
}
