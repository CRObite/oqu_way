import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

import '../../../../config/app_colors.dart';

class TestDeadlineInfoCard extends StatelessWidget {
  const TestDeadlineInfoCard({super.key, required this.isTest, required this.onPressed, this.deadline = '', required this.isActive, required this.description});

  final bool isTest;
  final String deadline;
  final String description ;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 40),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_red_mark.svg', height: 18,),
              const SizedBox(height: 7,),
              Expanded(
                child: Container(
                  color: AppColors.greenColor,
                  width: 1,
                ),
              ),
              const SizedBox(height: 7,),
            ],
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTest? AppText.test: AppText.homeworks, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(child: Text(description ,maxLines: 4,style: TextStyle(color: AppColors.greyColor, fontSize:10,overflow: TextOverflow.ellipsis), )),

                    const SizedBox(width: 10,),

                    SizedBox(
                        height: 30,
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColors.blueColor , width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 14),
                          ),
                          onPressed: onPressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(isActive ? AppText.doIt : 'Нәтижені көру', style: TextStyle(color: AppColors.blueColor, fontSize: 8),),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
