import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/specialization_repository/specialization_repository.dart';
import 'package:oqu_way/domain/pagination.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../config/app_colors.dart';
import '../../data/repository/auth_reg_repository/authorization_repository.dart';
import '../../data/repository/post_repository/post_repository.dart';
import '../../data/repository/university_repository/university_repository.dart';
import '../../domain/face_subject.dart';

enum PageableType{
  news,
  universities,
  specialization
}


class PaginationBuilder extends StatefulWidget {
  const PaginationBuilder({super.key, required this.size, required this.child,required this.type, this.cityId, this.specializationId, this.query = '', this.universityId, this.bottomSize = 0.0});

  final int size;
  final Widget Function(BuildContext, dynamic) child;
  final PageableType type;
  final int? universityId;
  final int? cityId;
  final int? specializationId;
  final String query;
  final double bottomSize;


  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {

  ScrollController scrollController = ScrollController();
  List<dynamic> oldList = [];

  int maxPage = 0;
  int currentPageCount = 0;

  @override
  void initState() {
    getNewData();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {

        if(maxPage-1 >= currentPageCount+1 ){
          currentPageCount ++;
          getNewData();
        }
      }
    });
    super.initState();
  }




  Future<void> getNewData() async {

    try{
      Pagination? pagination;
      if(widget.type == PageableType.universities){

        pagination = await UniversityRepository().getAllUniversity(
            TempToken.token, currentPageCount,widget.size ,widget.cityId,widget.specializationId,widget.query);
        if(pagination!= null && pagination.items.isNotEmpty){


          maxPage = pagination.totalPages;
          setState(() {
            oldList.addAll(pagination!.items);
          });
        }

      }else if(widget.type == PageableType.news){

        final int? id = await AuthorizationRepository().userGetMyId(TempToken.token);
        if(id != null){
          final Pagination? pagination = await PostRepository().getAllPost(TempToken.token, id, currentPageCount, widget.size);
          if(pagination!= null && pagination.items.isNotEmpty){
            maxPage = pagination.totalPages;
            setState(() {
              oldList.addAll(pagination.items);
            });

            print(oldList);
          }
        }

      }else if(widget.type == PageableType.specialization){
        if(widget.universityId != null){
          pagination = await SpecializationRepository().getAllSpecializations(
              TempToken.token,widget.universityId!,currentPageCount,widget.size,widget.query);
          if(pagination!= null && pagination.items.isNotEmpty){
            maxPage = pagination.totalPages;
            setState(() {
              oldList.addAll(pagination!.items);
            });
          }
        }
      }
    }catch(error){
      if(error is DioException){
        CustomException exception = CustomException.fromDioException(error);

        if(exception.statusCode == 401){

          bool value = await AuthorizationRepository().refreshToken(TempToken.refToken);
          if(value){
             getNewData();
          }else{
            context.go('/loginPage');
          }
        }

      }
    }

  }


  @override
  void didUpdateWidget(covariant PaginationBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      setState(() {
        oldList.clear();
        currentPageCount = 0;
        getNewData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          oldList = [];
          currentPageCount = 0;
        });

        getNewData();
      },
      child: ListView.builder(
          controller: scrollController,
          itemCount:oldList.length + 1,
          itemBuilder: (context, index){
            if(oldList.isNotEmpty){
              if(index < oldList.length){
                return widget.child(context,oldList[index]);
              }else{
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: maxPage - 1 <= currentPageCount ? Text( oldList.length < widget.size ? '' :'Больше нет данных') : CircularProgressIndicator(color: AppColors.blueColor,),
                      ),
                    ),


                    SizedBox(height: widget.bottomSize,)
                  ],
                );
              }
            }else {
              return const SizedBox();
            }

          }
      ),
    );
  }
}
