

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigation_page_state.dart';

class NavigationPageCubit extends Cubit<NavigationPageState> {
  NavigationPageCubit() : super(NavigationPageInitial());


  Future<void> openComments(int id)async {
    emit(NavigationPageComments(id: id));
  }

}
