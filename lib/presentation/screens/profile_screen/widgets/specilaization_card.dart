import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../domain/specialization.dart';

class SpecializationCard extends StatefulWidget {
  const SpecializationCard({super.key, required this.specialization});

  final dynamic specialization;

  @override
  State<SpecializationCard> createState() => _SpecializationCardState();
}

class _SpecializationCardState extends State<SpecializationCard> {

  Specialization? specialization;

  @override
  void initState() {
    specialization = Specialization.fromJson(widget.specialization);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return specialization != null? GestureDetector(
      onTap: (){
        context.push('/profileUniversityDetails/profileUniversityProfession/professionDetails', extra: {'specializationId': specialization!.id});
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
                    Text(
                      specialization!.name ?? '???',
                      style: const TextStyle(fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 14,),

                    Text(
                      'Код : ${specialization!.code}',
                      style: TextStyle(fontSize: 8,
                          color: AppColors.greyColor),
                    ),
                    Text(
                      'Грант саны : ${specialization!.grandCount}',
                      style: TextStyle(fontSize: 8,
                          color: AppColors.greyColor),
                    ),
                    Text(
                      'Грантқа шекті балл : ${specialization!.grandScore}',
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
    ): const SizedBox();
  }
}
