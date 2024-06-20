import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_shadow.dart';
import 'common_progress_indicatore.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: AppShadow.cardShadow
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 58,
                width: 58,
                child: SvgPicture.asset('assets/icons/ic_math.svg' , height: 30,)
            ),

            const SizedBox(width: 20),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Математика',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  CommonProgressIndicator(),
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
