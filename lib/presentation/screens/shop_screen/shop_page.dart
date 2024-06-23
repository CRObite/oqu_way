import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_shadow.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/screens/shop_screen/widgets/frosted_glass.dart';

import '../../../config/app_text.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 260,
                child: Stack(
                  children: [


                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor.withOpacity(0.5),
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Center(
                      child: FrostedGlassBox(
                        theWidth: MediaQuery.of(context).size.width - 100,
                        theHeight: 180,
                        theChild: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 31),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('Алуа Алпысбаева', style: TextStyle(color: AppColors.darkBlueColor, fontWeight: FontWeight.bold),),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    child: Image.asset('assets/image/coin.png'),
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('150', style: TextStyle(color: AppColors.darkBlueColor, fontSize: 40,fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 8,),
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                          child: Text(AppText.coins, style: TextStyle(color: AppColors.darkBlueColor, fontSize: 20,fontWeight: FontWeight.bold),)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                      ),

                    ),


                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 64,
                      child: Text(
                        AppText.getGiftsByCoin,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 20,),


              GridView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.6,
                  ),
                itemCount: 10,
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: AppShadow.litherShadow
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 10),
                        child: Center(child: Image.asset('assets/image/phone.png')),
                      ),

                      const SizedBox(height: 15,),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Айфон 12 ',style: TextStyle(fontSize: 11),),
                          Text('10000 cns',style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(height: 15,),
                      
                      SizedBox(
                        width: 100,
                        child: CommonButton(
                            title: 'Сатып алу',
                            onClick: (){},
                            horizontalPadding: 17,
                            verticalPadding: 7,
                            fontSize: 10,
                            radius: 10,
                          color: AppColors.blueColor.withOpacity(0.75),
                        ),
                      )
                      
                    ],
                  );
                }
              )



            ],
          ),
        ),
      ),
    );
  }
}
