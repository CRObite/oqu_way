import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

class SubjectNameCard extends StatelessWidget {
  const SubjectNameCard({super.key, required this.buttonName, required this.withDate, required this.onButtonPressed});

  final String buttonName;
  final bool withDate;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_check.svg', height: 18,),
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
                const Text('Сабақ атауы', style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text('In iaculis neque ac, lectus et sit sed euismod. Eget arcu eget lectus feugiat quisque amet vitae pulvinar. Iaculis scelerisque rhoncus congue in feugiat in lacus dignissim convallis. Bibendum lacus urna, eget viverra.',
                    maxLines: 4,overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.greyColor,fontSize: 11),
                  ),
                ),

                const SizedBox(height: 8,),



                Row(
                  mainAxisAlignment: withDate ? MainAxisAlignment.start: MainAxisAlignment.end,
                  children: [

                    withDate ? DateTimeRow(color: AppColors.greyColor,):

                    withDate ? const SizedBox():SizedBox(
                        height: 30,
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColors.blueColor, width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 14),
                          ),
                          onPressed: onButtonPressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(buttonName, style: TextStyle(color: AppColors.blueColor, fontSize: 8),),
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
