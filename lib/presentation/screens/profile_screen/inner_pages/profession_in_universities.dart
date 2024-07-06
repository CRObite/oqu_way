import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../widgets/university_card.dart';

class ProfessionInUniversities extends StatefulWidget {
  const ProfessionInUniversities({super.key});

  @override
  State<ProfessionInUniversities> createState() => _ProfessionInUniversitiesState();
}

class _ProfessionInUniversitiesState extends State<ProfessionInUniversities> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text('Ақпараттық технологиялар',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
            const SizedBox(height: 10,),
            Text('Пәндер : Математика, Информатика',style: TextStyle(fontSize: 10, color: AppColors.greenColor),),

            Expanded(
              child: ListView.builder(
                  itemCount:10,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        context.pop();
                        context.pop();
                        context.pop();
                        context.pop();
                        context.push('/profileUniversityDetails');
                      },
                      child: const UniversityCard()
                    );
                  }
              ),
            )


          ],
        ),
      ),

    );
  }
}
