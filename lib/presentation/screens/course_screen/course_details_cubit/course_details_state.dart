part of 'course_details_cubit.dart';

@immutable
abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsFetched extends CourseDetailsState {
  final Subject subject;

  CourseDetailsFetched({required this.subject});
}

class CourseDetailsError extends CourseDetailsState {}

