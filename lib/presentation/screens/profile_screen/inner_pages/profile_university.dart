import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:oqu_way/config/app_shadow.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/university_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../../data/repository/university_repository/university_repository.dart';
import '../../../../domain/face_subject.dart';
import '../../../../domain/pagination.dart';
import '../../../../domain/university.dart';
import '../../../../util/custom_exeption.dart';
import '../../../common/pagination_builder.dart';

class ProfileUniversity extends StatefulWidget {
  const ProfileUniversity({super.key});

  @override
  State<ProfileUniversity> createState() => _ProfileUniversityState();
}

class _ProfileUniversityState extends State<ProfileUniversity> {

  bool isOpened = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          width: 1,
                          color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,color: AppColors.greyColor,),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: searchController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppText.search,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),


              isOpened ? const SizedBox(): Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1
                    ),
                    top: BorderSide(
                        color: AppColors.greyColor,
                        width: 1
                    ),
                  )
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Қаланы таңдаңыз', style: TextStyle(color: AppColors.greyColor),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOpened = true;
                        });
                      },
                      child: Row(
                        children: [
                          Text('Алматы', style: TextStyle(color: AppColors.greyColor),),
                          Icon(Icons.arrow_forward_ios_rounded, color:AppColors.greyColor,size: 12,)
                        ],
                      ),
                    )
                  ],
                ),
              ),


              isOpened?
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        isOpened = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.greyColor,
                                width: 1
                            ),
                            top: BorderSide(
                                color: AppColors.greyColor,
                                width: 1
                            ),
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      child: const Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Алматы'),
                        ],
                      ),
                    ),
                  );
                }
              ): PaginationBuilder(
                size: 10,
                type: PageableType.universities,
                query: searchController.text,
                child: (context, university) => UniversityCard(university: university),
              ),


              const SizedBox(height: 96,)
            ],
        ),
      ),
    );
  }
}
