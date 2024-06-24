import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../test_screen/widgets/answer_card.dart';

class GameTestScreen extends StatefulWidget {
  const GameTestScreen({super.key});

  @override
  State<GameTestScreen> createState() => _GameTestScreenState();
}

class _GameTestScreenState extends State<GameTestScreen> {

  int? selectedAns;
  int currentQuestion = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
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
                  
                  
                  
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const PlayerWidget(initial: 'A', name: 'Алуа Алпысбаева'),
                              const SizedBox(
                                height: 9,
                              ),
                              QuestionCounter(question: currentQuestion,),
                            ],
                          ),

                          Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 10,color: AppColors.blueColor.withOpacity(0.5))
                                ),
                                child: Center(child: Text('29',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.blueColor),)),
                              ),

                              const SizedBox(height: 16,),

                              Container(
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(width: 3,color: AppColors.blueColor.withOpacity(0.5))
                                ),
                                child: Center(child: Text('$currentQuestion/5',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.blueColor),)),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              const PlayerWidget(initial: 'B', name: 'Бекзат Орынжай'),
                              const SizedBox(
                                height: 9,
                              ),
                              QuestionCounter(question: currentQuestion,),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),


            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Ақмола-Қарталы темір жолының маңызы:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 30,),

                      ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            return AnswerCard(
                                selected: selectedAns == index,
                                onAnswerSelected: (){
                                  setState(() {
                                    currentQuestion ++;
                                    selectedAns = null;
                                  });


                                  if(currentQuestion >= 5){
                                    context.pushReplacement('/gameStartScreen/gameResult');
                                  }

                                }, questionText: 'Орталық Қазақстанның өнеркәсіп аудандарын Оралдың оңтүстігімен байланыстырады.'
                            );
                          }
                      )
                    ],
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
class PlayerWidget extends StatelessWidget {
  final String initial;
  final String name;

  const PlayerWidget({
    Key? key,
    required this.initial,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                color: AppColors.greenColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: 70,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class QuestionCounter extends StatelessWidget {

  final int  question;

  const QuestionCounter({super.key, required this.question});



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.all(2.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: index < question - 1 ? AppColors.greenColor : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}



