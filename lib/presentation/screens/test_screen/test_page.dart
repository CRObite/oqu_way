import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/test_colored_card.dart';

import '../../../config/app_text.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(AppText.onlineTests, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context,index){
                  return GestureDetector(
                      onTap: (){
                        context.goNamed('testSubjectSelectPage');
                      },
                      child: TestColoredCard(index: index)
                  );
                }
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: CardContainerDecoration.decoration,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Профорентационный тест (полный)', style: TextStyle(fontSize: 12),),
                          SizedBox(
                            height: 30,
                              child: CommonButton(title: AppText.pass, onClick: (){context.goNamed('testSubjectSelectPage');}, fontSize: 11, horizontalPadding: 15, verticalPadding: 0,)
                          )
                        ],
                      ),
                    );
                  }
              )
            ),


            const SizedBox(height: 69,),

          ],
        ),
      ),
    );
  }
}
