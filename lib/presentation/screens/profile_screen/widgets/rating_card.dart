import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: AppColors.greyColor.withOpacity(0.2)
                ),
                child: Center(
                  child: Text('${index +1}',style: const TextStyle(fontSize: 10),),
                ),
              ),

              const SizedBox(width: 10,),

              const Icon(Icons.arrow_drop_down),
              const SizedBox(width: 20,),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 5,),
                  const Text('Charles Puyol Capitano',style: TextStyle(fontWeight:FontWeight.bold, fontSize: 10),),
                ],
              )

            ],
          ),

          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text('100',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 10),),
          ),
        ],
      ),
    );
  }
}
