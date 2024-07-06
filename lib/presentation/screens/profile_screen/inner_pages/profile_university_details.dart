import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../../config/app_text.dart';

class ProfileUniversityDetails extends StatefulWidget {
  const ProfileUniversityDetails({super.key});

  @override
  State<ProfileUniversityDetails> createState() => _ProfileUniversityDetailsState();
}

class _ProfileUniversityDetailsState extends State<ProfileUniversityDetails> {
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
        title: Text('${AppText.universities} > SDU', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: Image.asset(
                  'assets/image/university.png',
                  fit: BoxFit.cover
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58),
                child: Text('Сулейман Демирел атындағы университет',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
              ),
              const SizedBox(height: 10,),
              Text('Алматы қаласы Қаскелен қаласы',style: TextStyle(fontSize: 10, color: AppColors.moreDarkerBlueColor),),
              Text('Код : 190',style: TextStyle(fontSize: 10, color: AppColors.moreDarkerBlueColor),),
          
              const SizedBox(height: 20,),
          
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Орташа бағасы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('1000 000 тг',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Статус',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('бірлескен',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Жатақхана',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('жоқ',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Әскери кафедра',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('бар',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
          
                  ],
                ),
              ),
          
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push('/profileUniversityDetails/profileUniversityProfession');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                            top: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Мамандықтар',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('15',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),
          
                  GestureDetector(
                    onTap: (){
                      context.push('/profileComments');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                            top: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Сұрақтар',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('666',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Қысқаша сипаттама',style: TextStyle(fontSize: 11, color: AppColors.greenColor),),
                  const SizedBox(height: 10,),
                  const Text('SDU – оқу үдерісін халықаралық үлгідегі бағдарламаға сай жүргізетін оқу орны. SDU University материалдық-техникалық базаны нығайтуға, халықаралық серіктестермен байланыс орнатуға және білікті кадрлар даярлауға қабілетті ауқымды білім беру және ғылыми мекемелердің бірі. Университеттің стратегиялық жоспары оны тек Қазақстанда ғана емес, бүкіл Орталық Азияда танылған әлемдік беделі бар жетекші жоғары оқу орнына айналдыруды көздейді.'
                      ,style: TextStyle(fontSize: 12),)
                ],
              )
          
            ],
          ),
        ),
      ),

    );
  }
}
