import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/domain/pagination.dart';

import '../../config/app_colors.dart';
import '../../data/repository/auth_reg_repository/authorization_repository.dart';
import '../../data/repository/post_repository/post_repository.dart';
import '../../data/repository/university_repository/university_repository.dart';
import '../../domain/face_subject.dart';
import '../screens/profile_screen/widgets/university_card.dart';

enum PageableType{
  news,
  universities
}


class PaginationBuilder extends StatefulWidget {
  const PaginationBuilder({super.key, required this.size, required this.child,required this.type, this.cityId, this.specializationId, this.query = ''});

  final int size;
  final Widget Function(BuildContext, dynamic) child;
  final PageableType type;
  final int? cityId;
  final int? specializationId;
  final String query;


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

    print(oldList.length);

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

    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: maxPage - 1 <= currentPageCount ? Text( oldList.length < widget.size ? '' :'Больше нет данных') : CircularProgressIndicator(color: AppColors.blueColor,),
                    ),
                  );
                }
              }else {
                return const SizedBox();
              }
      
            }
        ),
      ),
    );
  }
}
