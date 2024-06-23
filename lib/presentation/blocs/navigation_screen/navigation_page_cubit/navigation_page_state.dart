part of 'navigation_page_cubit.dart';

@immutable
abstract class NavigationPageState {}

class NavigationPageInitial extends NavigationPageState {}

class NavigationPageComments extends NavigationPageState {
  final int id;

  NavigationPageComments({required this.id});
}
