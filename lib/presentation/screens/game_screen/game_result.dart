import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';
import '../../common/widgets/common_button.dart';

class GameResult extends StatefulWidget {
  const GameResult({super.key});

  @override
  State<GameResult> createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

  bool isWinner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                boxShadow: AppShadow.shadow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset(
                      'assets/icons/decoration.svg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  Center(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isWinner = !isWinner;
                          });
                        },
                        child: Image.asset(isWinner ? 'assets/image/star.png': 'assets/image/die.png')
                    ),
                  )

                ],
              ),
            ),


            const SizedBox(height: 40,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isWinner ?
                  Text('Сіз ұттыңыз!',style: TextStyle(fontSize: 38,color: AppColors.greenColor,fontWeight: FontWeight.bold),):
                  const Text('Сіз ұтылдыңыз!',style: TextStyle(fontSize: 38,color: Colors.red,fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                isWinner ?
                  Text('+50',style: TextStyle(fontSize: 85,color: AppColors.greenColor,fontWeight: FontWeight.bold),):
                  const Text('-50',style: TextStyle(fontSize: 85,color: Colors.red,fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),

                Text('Пән:Tарих', style: TextStyle(color: AppColors.blueColor,fontSize: 24,fontWeight: FontWeight.bold),),
                Text('Дұрыс жауаптар:4/5', style: TextStyle(color: AppColors.blueColor,fontSize: 24,fontWeight: FontWeight.bold),),


              ],
            )

          ],
        ),
      ),

        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title: AppText.cont, onClick: (){context.pop();})
        )


    );
  }
}
