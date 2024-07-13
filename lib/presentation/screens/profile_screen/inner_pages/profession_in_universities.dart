import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/domain/subject.dart';
import 'package:oqu_way/presentation/common/pagination_builder.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../widgets/university_card.dart';

class ProfessionInUniversities extends StatefulWidget {
  const ProfessionInUniversities({super.key, required this.specializationId, required this.specializationName, required this.listOfSubject});

  final int? specializationId;
  final String specializationName;
  final List<Subject> listOfSubject;

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
        title: Text('${AppText.universities} > ${widget.specializationName}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(widget.specializationName,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
            const SizedBox(height: 10,),
            Text('Пәндер : ${widget.listOfSubject[0].name}, ${widget.listOfSubject[1].name}',style: TextStyle(fontSize: 10, color: AppColors.greenColor),),

            Expanded(
              child: PaginationBuilder(
                size: 10,
                bottomSize: 96,
                type: PageableType.universities,
                specializationId: widget.specializationId,
                child: (context, university) => UniversityCard(university: university, popUntil: true,),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
