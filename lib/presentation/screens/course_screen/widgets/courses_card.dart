import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../../config/app_shadow.dart';
import '../../../common/card_container_decoration.dart';
import 'common_progress_indicatore.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key, required this.courseName});

  final String courseName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: CardContainerDecoration.decoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                height: 58,
                width: 58,
                child: Center(
                  child: Text(courseName[0],style: const TextStyle(color: Colors.white, fontSize: 20),),
                )
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseName,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const CommonProgressIndicator(),
                ],
              ),
            ),
            const SizedBox(width: 20),

            SvgPicture.asset('assets/icons/ic_arrow.svg' , height: 17,),
          ],
        ),
      ),
    );
  }
}
