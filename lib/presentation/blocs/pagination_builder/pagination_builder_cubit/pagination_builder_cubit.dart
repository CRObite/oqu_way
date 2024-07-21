import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';

import '../../../../data/repository/auth_reg_repository/authorization_repository.dart';
import '../../../../data/repository/post_repository/post_repository.dart';
import '../../../../data/repository/specialization_repository/specialization_repository.dart';
import '../../../../data/repository/university_repository/university_repository.dart';
import '../../../../domain/face_subject.dart';
import '../../../../domain/pagination.dart';
import '../../../../util/custom_exeption.dart';

part 'pagination_builder_state.dart';

enum PageableType{
  news,
  universities,
  specialization
}

class PaginationBuilderCubit extends Cubit<PaginationBuilderState> {
  PaginationBuilderCubit() : super(PaginationBuilderInitial());

  List<dynamic> oldList = [];

  int maxPage = 0;
  int currentPageCount = 1;

  Future<void> getNewData(int size,PageableType type,
    int? universityId,int? cityId,int? specializationId,String query) async {


    String? token = await SharedPreferencesOperator.getAccessToken();

    try{
      Pagination? pagination;
      if(type == PageableType.universities){

        pagination = await UniversityRepository().getAllUniversity(
            token!, currentPageCount ,size,cityId,specializationId,query);
        if(pagination!= null && pagination.items.isNotEmpty){

          maxPage = pagination.totalPages;

          oldList.addAll(pagination.items);

          emit(PaginationBuilderFetched(listOfValue: oldList));

        }

      }else if(type == PageableType.news){
        final int? id = await AuthorizationRepository().userGetMyId(token!);
        if(id != null){
          final Pagination? pagination = await PostRepository().getAllPost(token, id, currentPageCount, size);
          if(pagination!= null && pagination.items.isNotEmpty){
            maxPage = pagination.totalPages;
            oldList.addAll(pagination.items);
            print(oldList);
            emit(PaginationBuilderFetched(listOfValue: oldList));
          }
        }

      }else if(type == PageableType.specialization){
        if(universityId != null){
          pagination = await SpecializationRepository().getAllSpecializations(
              token!,universityId,currentPageCount,size,query);
          if(pagination!= null && pagination.items.isNotEmpty){
            maxPage = pagination.totalPages;
            oldList.addAll(pagination.items);

            emit(PaginationBuilderFetched(listOfValue: oldList));
          }
        }
      }
    }catch(error){
      if(error is DioException){
        CustomException exception = CustomException.fromDioException(error);

        if(exception.statusCode == 401){

          String? refToken = await SharedPreferencesOperator.getRefreshToken();

          bool value = await AuthorizationRepository().refreshToken(refToken!);
          if(value){
            getNewData(size,type,universityId,cityId,specializationId,query);
          }else{
            emit(PaginationBuilderPushLogin());
          }
        }else{
          emit(PaginationBuilderError(errorText: error.message ?? 'неизвестная ошибка'));
        }
      }else{
        emit(PaginationBuilderError(errorText: 'неизвестная ошибка'));
      }
    }

  }


  void resetPage(int size,PageableType type,
      int? universityId,int? cityId,int? specializationId,String query){
    oldList = [];

    if(type == PageableType.universities){
      currentPageCount = 1;
    }else{
      currentPageCount = 0;
    }

    getNewData(size,type,universityId,cityId,specializationId,query);
  }
}
