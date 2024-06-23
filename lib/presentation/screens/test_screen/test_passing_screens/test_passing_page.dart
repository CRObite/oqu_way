import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/answer_card.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/select_next_subject.dart';

import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/count_down_timer.dart';
import '../widgets/question_number_row.dart';

class TestPassingPage extends StatefulWidget {
  const TestPassingPage({super.key});

  @override
  State<TestPassingPage> createState() => _TestPassingPageState();
}

class _TestPassingPageState extends State<TestPassingPage> {


  bool subjectSelected = false;
  int subjectIndex = 0;
  int currentQuestion = 0;
  int? selectedAns;

  List<bool> ended = [false,false,false,false,false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            if(subjectSelected){
                              setState(() {
                                subjectSelected = false;
                              });
                            }else {
                              context.pop();
                            }
                          },
                          icon: Transform.rotate(
                            angle: 180 * 3.1415926535/180,
                            child: SvgPicture.asset(
                              'assets/icons/ic_arrow.svg',
                              height: 11,
                            ),
                          ),
                      ),

                      const SizedBox(width: 30,),

                      CountDownTimer(
                        duration: const Duration(hours: 3,minutes: 58,seconds: 48),
                        onTimePassed: () { context.pushReplacement('/testResults'); },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36,),

                !subjectSelected ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return SelectNextSubject(
                            onSelected: () {
                              setState(() {
                                subjectIndex = index;
                                subjectSelected = true;
                              });
                            },
                            ended: ended[index],

                          );
                        }
                    ),
                  ):
                Column(
                  children: [
                    QuestionNumberRow(
                      currentQuestionIndex: currentQuestion,
                      onSelectQuestion: (value ) {
                        setState(() {
                          currentQuestion = value;
                        });
                      },
                    ),

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
                                      selectedAns = index;
                                    });
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
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: subjectSelected ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor.withOpacity(0.2),
                    elevation: 0,
                    side: BorderSide(
                        color: AppColors.blueColor,
                        width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 27),
                  ),

                  onPressed: () {
                    setState(() {
                      subjectSelected = false;
                      currentQuestion = 0;
                    });
                  },
                  child: Text(AppText.exit, style: TextStyle(color: AppColors.blueColor, fontSize: 15), ),
                ),

                Text('${currentQuestion+1}/15', style: TextStyle(color: AppColors.greyColor, fontSize: 15),),
                CommonButton(title: currentQuestion+1 == 15 ?AppText.end:AppText.next, onClick: (){
                  if(currentQuestion+1 != 15){
                    setState(() {
                      currentQuestion ++;
                    });
                  }else {
                    setState(() {
                      ended[subjectIndex] = true;
                      subjectSelected = false;
                      currentQuestion = 0;
                    });
                  }
                } , horizontalPadding: 27, verticalPadding: 13,fontSize: 15,)
              ],
            ):
            CommonButton(title: AppText.endTest, onClick: (){
              context.pushReplacement('/testResults');
            }, )
        )
    );
  }
}
