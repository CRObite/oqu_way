import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/specialization_repository/specialization_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/domain/specialization.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../../data/repository/comment_repository/comment_repository.dart';

class ProfessionDetails extends StatefulWidget {
  const ProfessionDetails({super.key, required this.specializationId});

  final int? specializationId;

  @override
  State<ProfessionDetails> createState() => _ProfessionDetailsState();
}

class _ProfessionDetailsState extends State<ProfessionDetails> {

  Specialization? specialization;

  @override
  void initState() {
    if(widget.specializationId != null){
      getSpecialization();
    }

    super.initState();
  }

  Future<void> getSpecialization() async {
    Specialization? value = await SpecializationRepository().getSpecializationsById(TempToken.token, widget.specializationId!);

    setState(() {
      specialization = value;
    });
  }


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
        title: specialization!=null? Text('${AppText.universities} > Мамандықтар > ${specialization!.name}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),): const SizedBox(),
      ),
      body: specialization!=null? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(specialization!.name ?? '???',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
              const SizedBox(height: 10,),
              Text('Пәндер : ${specialization!.subjects![0].name}, ${specialization!.subjects![1].name}',style: TextStyle(fontSize: 10, color: AppColors.greenColor),),

              const SizedBox(height: 20,),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Код бағасы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text(specialization!.code ?? '???',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Грант саны',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text('${specialization!.grandCount}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Грантқа шекті балл',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text('${specialization!.grandScore}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Орташа жалақы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text('${specialization!.averageSalary}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Сұраныс',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text(specialization!.demand ?? '???',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),

                  ],
                ),
              ),

              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push('/profileUniversityDetails/profileUniversityProfession/professionDetails/professionInUniversities',
                        extra: {'specializationId': specialization!.id , 'specializationName': specialization!.name, 'listOfSubject': specialization!.subjects});
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
                          Text('${specialization!.universities!.length}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      context.push('/profileComments', extra: {'id': specialization!.id, 'type': '${CommentType.Specialization}'});
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
                  Text(specialization!.description ?? '???'
                    ,style: const TextStyle(fontSize: 12),)
                ],
              ),
              const SizedBox(height: 20,)

            ],
          ),
        ),
      ): const SizedBox(),

    );
  }
}
