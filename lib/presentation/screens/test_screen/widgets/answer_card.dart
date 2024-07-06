import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({super.key, required this.selected, required this.onAnswerSelected, required this.questionText});

  final bool selected;
  final VoidCallback onAnswerSelected;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       onAnswerSelected();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1,color: selected ? AppColors.blueColor : AppColors.greyColor
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 16,
              width: 16,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,color:
                selected ? AppColors.blueColor.withOpacity(0.5) :
                AppColors.greyColor
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: selected ? AppColors.blueColor:AppColors.greyColor.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(width: 30,),

            Expanded(
              child: Text(questionText,
                style: const TextStyle(fontSize: 11),),
            ),

          ],
        ),
      ),
    );
  }
}
