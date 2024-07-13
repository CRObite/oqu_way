import 'package:flutter/material.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/university_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../common/pagination_builder.dart';
import '../../../common/widgets/common_search_field.dart';

class ProfileUniversity extends StatefulWidget {
  const ProfileUniversity({super.key});

  @override
  State<ProfileUniversity> createState() => _ProfileUniversityState();
}

class _ProfileUniversityState extends State<ProfileUniversity> {

  bool isOpened = false;

  TextEditingController searchController = TextEditingController();
  String query = '';


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
                child: CommonSearchField(searchController: searchController, onEnded: (){
                  setState(() {query = searchController.text;});
                },),
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
              ): Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PaginationBuilder(
                    size: 10,
                    bottomSize: 96,
                    type: PageableType.universities,
                    query: query,
                    child: (context, university) => UniversityCard(university: university),
                  ),
                ),
              ),

            ],
        ),
      ),
    );
  }
}
