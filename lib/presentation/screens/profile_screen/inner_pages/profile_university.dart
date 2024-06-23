import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_shadow.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';

class ProfileUniversity extends StatefulWidget {
  const ProfileUniversity({super.key});

  @override
  State<ProfileUniversity> createState() => _ProfileUniversityState();
}

class _ProfileUniversityState extends State<ProfileUniversity> {

  TextEditingController searchController = TextEditingController();

  bool isOpened = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: Text(AppText.universities, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Column(
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
          ):
          Expanded(
            child: ListView.builder(
              itemCount:10,
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: AppShadow.litherShadow
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/university.png'
                      ),
                      const SizedBox(width: 17,),

                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Сулейман Демирел атындағы университет',
                                style: TextStyle(fontSize: 13,
                                fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Мамандық саны: 10',
                                style: TextStyle(fontSize: 8,
                                 color: AppColors.greyColor),
                              ),
                              Text(
                                'Алматы қаласы, Қаскелен қаласы ...',
                                style: TextStyle(fontSize: 8,
                                    color: AppColors.greyColor),
                              ),
                            ],
                          )
                      ),

                      const SizedBox(width: 17,),
                      Icon(Icons.arrow_forward_ios_rounded, color:AppColors.greyColor,size: 20,)
                    ],
                  ),
                );
              }
            ),
          )


        ],
      ),

    );
  }
}
