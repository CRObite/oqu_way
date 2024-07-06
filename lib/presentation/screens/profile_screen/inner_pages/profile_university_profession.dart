import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';

class ProfileUniversityProfession extends StatefulWidget {
  const ProfileUniversityProfession({super.key});

  @override
  State<ProfileUniversityProfession> createState() => _ProfileUniversityProfessionState();
}

class _ProfileUniversityProfessionState extends State<ProfileUniversityProfession> {
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
        title: Text('${AppText.universities} > SDU > Мамандықтар', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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


          Expanded(
            child: ListView.builder(
                itemCount:10,
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      context.push('/profileUniversityDetails/profileUniversityProfession/professionDetails');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          boxShadow: AppShadow.litherShadow
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ақпараттық технологиялар',
                                    style: TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(height: 14,),

                                  Text(
                                    'Код : B057',
                                    style: TextStyle(fontSize: 8,
                                        color: AppColors.greyColor),
                                  ),
                                  Text(
                                    'Грант саны : 200',
                                    style: TextStyle(fontSize: 8,
                                        color: AppColors.greyColor),
                                  ),
                                  Text(
                                    'Грантқа шекті балл : 140',
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
