import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/rating_card.dart';

import '../../../../config/app_text.dart';

class ProfileRating extends StatefulWidget {
  const ProfileRating({super.key});

  @override
  State<ProfileRating> createState() => _ProfileRatingState();
}

class _ProfileRatingState extends State<ProfileRating> {


  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: GestureDetector(
              onTap: (){
                context.pop();
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
          ),
          title: Text(AppText.rating, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.studentsRating,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,color: AppColors.greyColor,),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: searchController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppText.search,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
              ),


              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1
                    )
                  )
                ),
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Рейтинг',style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 30,),
                        Text('Аты жөні',style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text('Coins',style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),


              Expanded(
                child: ListView.builder(
                  itemCount: 40,
                  itemBuilder: (context,index){
                    return RatingCard(index: index);
                  }
                ),
              ),
            ],
          ),
        ),

    );
  }
}
