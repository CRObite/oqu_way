import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/comment_view_check_row.dart';
import '../../../common/widgets/common_button.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: CardContainerDecoration.decoration,
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),),
              boxShadow: AppShadow.shadow,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.network(
                AppImage.newsImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('Как будет проходить ЕНТ в  2023 году?', maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                    const SizedBox(width: 8,),
                    SizedBox(
                        height: 20,
                        width: 40,
                        child: CommonButton(title: AppText.read,fontSize: 8,verticalPadding: 4,horizontalPadding: 8, onClick: () {  },)
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '2 сағат бұрын',
                      style: TextStyle(fontSize: 8),
                    )
                ),

                Divider(color: AppColors.greyColor,),

                CommentViewCheckRow(iconSize: 10, fontSize: 8, onCommentsTap: () {},),




              ],
            ),
          ),

        ],
      ),
    );
  }
}
