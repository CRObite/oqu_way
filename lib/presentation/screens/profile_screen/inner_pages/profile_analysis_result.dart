import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/university_card.dart';

import '../../../../config/app_text.dart';

class ProfileAnalysisResult extends StatefulWidget {
  const ProfileAnalysisResult({super.key});

  @override
  State<ProfileAnalysisResult> createState() => _ProfileAnalysisResultState();
}

class _ProfileAnalysisResultState extends State<ProfileAnalysisResult> {
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
        title: Text('${AppText.analysis} > Ықтималдылық', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text('100%',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Center(child: Text('Мемлекеттік грантқа түсу ықтималдылығы',style: TextStyle(fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),

              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: AppColors.greyColor
                        )
                      )
                    ),
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('1',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Магистральдық желілер және инфрақұрылым',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                Text('Код : B165',style: TextStyle(fontSize: 10,color: AppColors.greyColor),),
                              ],
                            )
                          ],
                        ),

                        GestureDetector(
                            onTap: (){
                              context.push('/profilePage/profileUniversity/profileUniversityDetails');
                            },
                            child: const UniversityCard()
                        ),
                      ],
                    )

                  );
                }
              ),
              const SizedBox(height: 30,),
              const Text('80%',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Center(child: Text('Мемлекеттік грантқа түсу ықтималдылығы',style: TextStyle(fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: AppColors.greyColor
                                )
                            )
                        ),
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('1',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                const SizedBox(width: 5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Магистральдық желілер және инфрақұрылым',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                    Text('Код : B165',style: TextStyle(fontSize: 10,color: AppColors.greyColor),),
                                  ],
                                )
                              ],
                            ),

                            GestureDetector(
                              onTap: (){
                                context.push('/profilePage/profileUniversity/profileUniversityDetails');
                              },
                                child: const UniversityCard()
                            ),
                          ],
                        )

                    );
                  }
              ),

            ],
          ),
        ),
      )
    );
  }
}
