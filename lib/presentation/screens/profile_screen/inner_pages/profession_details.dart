import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';

class ProfessionDetails extends StatefulWidget {
  const ProfessionDetails({super.key});

  @override
  State<ProfessionDetails> createState() => _ProfessionDetailsState();
}

class _ProfessionDetailsState extends State<ProfessionDetails> {
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
        title: Text('${AppText.universities} > SDU  > Мамандықтар', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text('Ақпараттық технологиялар',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
              const SizedBox(height: 10,),
              Text('Пәндер : Математика, Информатика',style: TextStyle(fontSize: 10, color: AppColors.greenColor),),

              const SizedBox(height: 20,),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Код бағасы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('B057',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Грант саны',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('2500',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Грантқа шекті балл',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('140',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Орташа жалақы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('1000 000 тг',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Сұраныс',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        const Text('жоғары',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),

                  ],
                ),
              ),

              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push('/profilePage/profileUniversity/profileUniversityDetails/profileUniversityProfession/professionDetails/professionInUniversities');
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
                          const Text('Университеттер',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('15',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      context.push('/profilePage/profileUniversity/profileComments');
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
              const SizedBox(height: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Қысқаша сипаттама',style: TextStyle(fontSize: 11, color: AppColors.greenColor),),
                  const SizedBox(height: 10,),
                  const Text('Біз көрсететін Грант саны - ЖАЛПЫ ГРАНТ конкурсында ойнатылатын грант саны. Бұл жерде «педагогикалық квота», «медициналық квота», «серпін» секілді квоталық гранттар көрсетілмеген. IT маман – компьютерлік жүйелерді әзірлейді. Бағдарлама жасайды, компьютерге қатысты жұмыстарды істейді. Олар – электроника инженерлері, байланыс және аспап жасаушы инженерлер, өнеркәсіптік роботтарға техникалық қызмет көрсетуші. Жұмысы жайлы: IT маманы әлемдегі ең керекті және перспективті мамандықтардың бірі. IT мамандығына түсу арқылы сіз JAVA, C++, PYTHON, HTML жүйесінде код жазып үйрене аласыз. Осы білімді алдағы уақытта жаңа программалар және веб-сайттар жасау үшін қолдана аласыз. Кез-келген компанияға осындай қызметтер қажет болғандықтан, жұмыс табу қиын болмайды. Сондай-ақ егер сіз бөгде адамға бағынғыңыз келмей, еркін жұмыс жасағыңыз келсе, онда фрилансерлік жұмыс атқара аласыз. Фрилансер дегеніміз интернеттегі түрлі тапсырыстарды белгілі бір уақытқа қабылдап, орындайтын жұмысшыларды айтамыз. Осындай тапсырыстардың қатарына веб-сайттар мен программалар жасау жатады. Басты қасиеттері: - Компьютердің нағыз маманы; - Ағылшын тілінде еркін сөйлеу; - JAVA, C++, PYTHON және т.б. программаларда еркін код жаза алу; - Логикалық өй-өрісі дамыған болу; - Күні бойы компьютер алдында отыруға дайын болу.'
                    ,style: TextStyle(fontSize: 12),)
                ],
              ),
              const SizedBox(height: 20,)

            ],
          ),
        ),
      ),

    );
  }
}
