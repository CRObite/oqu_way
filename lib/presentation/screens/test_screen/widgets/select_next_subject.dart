import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';

class SelectNextSubject extends StatelessWidget {
  const SelectNextSubject({super.key, required this.onSelected, required this.ended, this.score});

  final VoidCallback onSelected;
  final bool ended;
  final int? score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: AppShadow.litherShadow
      ),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Қазақстан тарихы', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
          SizedBox(
              height: 30,
              child: CommonButton(
                title: score!= null ? '$score' : ended ? AppText.cont : AppText.start,
                onClick: (){
                  onSelected();
                },
                fontSize: 11,
                horizontalPadding: 15,
                verticalPadding: 0,
                radius: 10,
                color:ended ?  Colors.black: AppColors.blueColor,
              )
          )
        ],
      ),
    );
  }
}
