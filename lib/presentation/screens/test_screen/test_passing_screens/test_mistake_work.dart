import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/answer_card.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/select_next_subject.dart';

import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../../domain/ent_test.dart';
import '../../../../domain/question.dart';
import '../../../../domain/sub_option.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/count_down_timer.dart';
import '../../news_screen/widgets/news_card.dart';
import '../widgets/question_number_row.dart';

class TestMistakeWork extends StatefulWidget {
  const TestMistakeWork({super.key, required this.ent});

  final EntTest? ent;

  @override
  State<TestMistakeWork> createState() => _TestMistakeWorkState();
}

class _TestMistakeWorkState extends State<TestMistakeWork> {
  bool isLoading = true;


  bool subjectSelected = false;
  int subjectIndex = 0;
  int currentQuestion = 0;
  List<String> entSubjectsName = [];
  Map<String, bool> entSubjectsMap = {};

  List<Question> entCurrentSubjectQuestion = [];


  @override
  void initState() {
    getEntSubjectsName();

    super.initState();
  }

  void getEntSubjectsName(){
    List<String> keys = widget.ent!.questionsMap.keys.toList();

    Map<String, bool> boolMap = { for (var k in widget.ent!.questionsMap.keys) k : false };
    setState(() {
      entSubjectsName = keys;
      entSubjectsMap = boolMap;
    });
  }

  void getEntCurrentQuestions(){
    setState(() {
      isLoading = true;
    });
    List<Question> currentQuestions = [];

    var subjectQuestions = widget.ent!.questionsMap[entSubjectsName[subjectIndex]]!;

    currentQuestions.addAll(subjectQuestions.questions);
    currentQuestions.addAll(subjectQuestions.multipleQuestions);
    currentQuestions.addAll(subjectQuestions.comparisonQuestions);

    for (var innerItem in subjectQuestions.contextQuestions) {
      for (var question in innerItem.questions) {
        question.context = innerItem.content;
        currentQuestions.add(question);
      }
    }

    setState(() {
      entCurrentSubjectQuestion = currentQuestions;

      _initializeEntTestQuestions();

      isLoading = false;
    });

  }

  void resetValue(){
    setState(() {
      subjectSelected = false;
      currentQuestion = 0;
    });
  }


  void _initializeEntTestQuestions() {
    // Set initial state for questions

    if(entCurrentSubjectQuestion[currentQuestion].checkedAnswers!= null && entCurrentSubjectQuestion[currentQuestion].checkedAnswers!.isNotEmpty){
      for(int element in entCurrentSubjectQuestion[currentQuestion].checkedAnswers!){
        int index =entCurrentSubjectQuestion[currentQuestion].options!.indexWhere((option) => option.id == element);
        if (index != -1) {

          setState(() {
            entCurrentSubjectQuestion[currentQuestion].options![index].checked = true;
          });
        }
      }
    }

  }

  Color getMistakeColor(String type){
    if(type == 'FULL_CORRECTLY'){
      return Colors.green;
    }else if(type == 'HALF_CORRECTLY'){
      return Colors.yellow;
    }else if(type == 'NO_CORRECT'){
      return Colors.red;
    }else {
      return AppColors.blueColor;
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        if(subjectSelected){
          resetValue();
        }else{
          Future.delayed(const Duration(milliseconds: 100), () {
            if (Navigator.canPop(context)) {
              context.pop();
            }
          });
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 20,
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
                              resetValue();
                            }else{
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  if (!subjectSelected) Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: entSubjectsName.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return SelectNextSubject(
                            onSelected: () {
                              setState(() {
                                subjectIndex = index;
                                subjectSelected = true;
                                getEntCurrentQuestions();
                              });
                            },
                            ended: entSubjectsMap[entSubjectsName[index]] ?? false,
                            title: entSubjectsName[index],
                          );
                        }
                    ),
                  ) else Column(
                    children: [
                      QuestionNumberRow(
                        currentQuestionIndex: currentQuestion,
                        onSelectQuestion: (value) {
                          setState(() {
                            currentQuestion = value;
                            _initializeEntTestQuestions();
                          });
                        },
                        color: getMistakeColor(entCurrentSubjectQuestion[currentQuestion].answeredType!= null ? entCurrentSubjectQuestion[currentQuestion].answeredType! : 'NO_CORRECT '),
                        questionNumber: entCurrentSubjectQuestion.length,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              entCurrentSubjectQuestion[currentQuestion].question ?? '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 20,),

                            entCurrentSubjectQuestion[currentQuestion].context!=null? Html(data:entCurrentSubjectQuestion[currentQuestion].context!): const SizedBox(),


                            entCurrentSubjectQuestion[currentQuestion].mediaFiles!= null?ListView.builder(
                                itemCount: entCurrentSubjectQuestion[currentQuestion].mediaFiles!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return FutureBuilder<Uint8List?>(
                                    future: MediaFileRepository().downloadFile(entCurrentSubjectQuestion[currentQuestion].mediaFiles![index].id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return SizedBox(
                                            height: 250, width: double.infinity,
                                            child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                                      } else if (snapshot.hasError) {
                                        return const NoImagePhoto(height: 100, width: 100);
                                      } else if (!snapshot.hasData) {
                                        return const NoImagePhoto(height: 100, width: 100);
                                      } else {
                                        return Image.memory(snapshot.data!);
                                      }
                                    },
                                  );
                                }
                            ) : const SizedBox(),

                            const SizedBox(height: 10,),

                            ListView.builder(
                                itemCount: entCurrentSubjectQuestion[currentQuestion].options!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){

                                  if (entCurrentSubjectQuestion[currentQuestion].type == 'COMPARISON' && entCurrentSubjectQuestion[currentQuestion].subOptions != null && entCurrentSubjectQuestion[currentQuestion].subOptions!.isNotEmpty) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(entCurrentSubjectQuestion[currentQuestion].options![index].text ?? ' ')),
                                          const SizedBox(width: 25,),
                                          Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: AppColors.greyColor),
                                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: DropdownButton2<SubOption>(
                                                value: entCurrentSubjectQuestion[currentQuestion].options![index].subOption,
                                                onChanged: (SubOption? newValue) async {
                                                },
                                                items: entCurrentSubjectQuestion[currentQuestion].subOptions!
                                                    .map<DropdownMenuItem<SubOption>>((SubOption value) {
                                                  return DropdownMenuItem<SubOption>(
                                                      value: value,
                                                      child: Text(
                                                        value.text ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      )
                                                  );
                                                }).toList(),
                                                iconStyleData: IconStyleData(
                                                  icon: Transform.rotate(
                                                    angle: 90 * 3.1415926535 / 180,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/ic_arrow.svg',
                                                      height: 11,
                                                      width: 5,
                                                    ),
                                                  ),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: 200,
                                                  width: MediaQuery.of(context).size.width - 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  offset: const Offset(-20, 0),
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    radius: const Radius.circular(40),
                                                    thickness: WidgetStateProperty.all(6),
                                                    thumbVisibility: WidgetStateProperty.all(true),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                underline: Container(),
                                                menuItemStyleData: const MenuItemStyleData(
                                                  height: 50,
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    );
                                  }


                                  return AnswerCard(
                                      selected: entCurrentSubjectQuestion[currentQuestion].options![index].checked ?? false,
                                      correct: entCurrentSubjectQuestion[currentQuestion].options![index].isRight,
                                      onAnswerSelected: () async {}, questionText: entCurrentSubjectQuestion[currentQuestion].options![index].text ?? ''
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
              color: Colors.transparent,
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

                  Text('${currentQuestion+1}/${ entCurrentSubjectQuestion.length}', style: TextStyle(color: AppColors.greyColor, fontSize: 15),),
                  CommonButton(title: currentQuestion+1 == (entCurrentSubjectQuestion.length) ? AppText.end:AppText.next, onClick: () async {
                    if(currentQuestion+1 != (entCurrentSubjectQuestion.length)){
                      setState(() {
                        currentQuestion ++;
                        _initializeEntTestQuestions();
                      });
                    }else {
                      setState(() {
                        entSubjectsMap[entSubjectsName[subjectIndex]] = true;


                        // print(entSubjectsMap);
                        resetValue();
                      });
                    }
                  } , horizontalPadding: 27, verticalPadding: 13,fontSize: 15,)
                ],
              ):
              CommonButton(title: AppText.exit, onClick: (){
                context.pop();
              },
              )
          )
      ),
    );
  }
}

