import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';

class GameFriendList extends StatefulWidget {
  const GameFriendList({super.key});

  @override
  State<GameFriendList> createState() => _GameFriendListState();
}

class _GameFriendListState extends State<GameFriendList> {

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
        title: const Text('Досымды шақыру', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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

            const SizedBox(height: 15,),

            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: AppShadow.shadow
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
              
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration:  BoxDecoration(
                                  color: AppColors.greyColor.withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'B',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          
                              const SizedBox(width: 10,),
                          
                          
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Бекзат Орынжай',style: TextStyle(fontSize: 15,),),
                                  Text('Оқушы',style: TextStyle(fontSize: 10,),),
                                ],
                              )
                          
                            ],
                          ),
              
              
                          SvgPicture.asset('assets/icons/ic_add_user.svg')
                        ],
              
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),

    );
  }
}
