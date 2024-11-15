

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/comment.dart';
part 'navigation_page_state.dart';

class NavigationPageCubit extends Cubit<NavigationPageState> {
  NavigationPageCubit() : super(NavigationPageInitial());

  static bool isOpened = false;

  Future<void> openComments(int newsId)async {

    isOpened = true;

    emit(NavigationPageComments(newsId: newsId));
  }


  Future<void> closeComments() async {

   if(isOpened){
     isOpened = false;
     emit(NavigationPageCommentsClose());
   }
  }


}
