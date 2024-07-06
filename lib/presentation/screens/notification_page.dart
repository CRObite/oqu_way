
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../config/app_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: const Text('Хабарландыру', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: AppColors.greyColor
                ),
                  top: BorderSide(
                      width: 0.5,
                      color: AppColors.greyColor
                  )
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    shape: BoxShape.circle
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Алуа, мамандықты таңдау барысында біздің консультациялардан өтуге кеңес береміз'),
                      Text('23 ч.',style: TextStyle(color: AppColors.greyColor,fontSize: 10),),
                  
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
