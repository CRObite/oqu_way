import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/domain/context_question.dart';
import 'package:oqu_way/domain/ent_test.dart';
import 'package:oqu_way/domain/sub_option.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/answer_card.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/select_next_subject.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../data/repository/ent_test_repository/ent_test_repository.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../../data/repository/test_repository/test_repository.dart';
import '../../../../domain/question.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/count_down_timer.dart';
import '../../news_screen/widgets/news_card.dart';
import '../widgets/question_number_row.dart';

class TestPassingPage extends StatefulWidget {
  const TestPassingPage({super.key, this.oneSubjectPage = false, required this.test, required this.ent, this.context});

  final bool oneSubjectPage;
  final AppTest? test;
  final EntTest? ent;
  final BuildContext? context;

  @override
  State<TestPassingPage> createState() => _TestPassingPageState();
}

class _TestPassingPageState extends State<TestPassingPage> {

  bool isLoading = true;


  bool subjectSelected = false;
  int subjectIndex = 0;
  int currentQuestion = 0;
  int? hiddenSelected;
  List<String> entSubjectsName = [];
  Map<String, bool> entSubjectsMap = {};

  List<Question> entCurrentSubjectQuestion = [];

  var subOptionsDoom = <SubOption>{};
  List<int> uniqueList = [];

  @override
  void initState() {
    print(widget.oneSubjectPage);

    subjectSelected = widget.oneSubjectPage;

    if(widget.oneSubjectPage){
      _initializeAppTestQuestions();
    }else{
      getEntSubjectsName();
    }

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

      isLoading = false;
    });

    _initializeEntTestQuestions();

  }

  void resetValue(){
   setState(() {
     subjectSelected = false;
     currentQuestion = 0;
   });
  }


  Future<void> endAppTest(bool showResult) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool ended = await TestRepository().endTest(token!, widget.test!.id);

    if(ended && showResult){
      context.pushReplacement('/testPassingPage/courseTestResult', extra: {'appTestId': widget.test!.id, 'context': widget.context});
    }else{
      context.go('/course/courseDetails');
    }
  }

  Future<void> endEntTest(bool showResult) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool ended = await EntTestRepository().endEntTest(token!, widget.ent!.id);

    if(ended && showResult){
      context.pushReplacement('/testResults' , extra: {'testId': widget.ent!.id });
    }else{
      context.go('/testSubjectSelectPage');
    }
  }


  Future<void> answerAppTest(int questionId, int optionId ,int? subOptionId, bool value) async {
    try{
      String? token = await SharedPreferencesOperator.getAccessToken();

      bool answered = await TestRepository().setUserAnswer(token!, questionId, optionId, subOptionId, value);
    }catch(e){
      if(e is DioException){
        CustomException.fromDioException(e);
      }
    }
  }

  Future<void> answerEntTest(int questionId,int optionId,int? subOptionId) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool answered = await EntTestRepository().answerEntTest(token!, widget.ent!.id, questionId, optionId, subOptionId);
  }

  Future<void> deleteAnswerEntTest(int questionId,int optionId,int? subOptionId) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool answered = await EntTestRepository().deleteAnswerEntTest(token!, widget.ent!.id, questionId, optionId, subOptionId);
  }


  void  _displayTestEndSource() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TestEndModal(
          oneSubjectPage: widget.oneSubjectPage,
          onContinue: () => context.pop(),
          onExit: () {
            if (widget.oneSubjectPage) {
              context.go('/course/courseDetails');
              //можно перездать
            } else {
              context.go('/testSubjectSelectPage');
              //можно перездать
            }
          },
        );
      },
    );
  }


  void _initializeAppTestQuestions() {
    // Set initial state for questions


    if(widget.test!.questions![currentQuestion].checkedAnswers!= null && widget.test!.questions![currentQuestion].checkedAnswers!.isNotEmpty){
      for(int element in widget.test!.questions![currentQuestion].checkedAnswers!){
        int index = widget.test!.questions![currentQuestion].options!.indexWhere((option) => option.id == element);
        if (index != -1) {
          setState(() {
            widget.test!.questions![currentQuestion].options![index].checked = true;
            hiddenSelected = index;
          });

        }
      }
    }

    if (widget.test!.questions![currentQuestion].multipleAnswers == false) {
      for (var element in widget.test!.questions![currentQuestion].options!) {
        if (element.checked == true) {
          setState(() {
            hiddenSelected = widget.test!.questions![currentQuestion].options!.indexOf(element);
          });
        }
      }
    }

    if (widget.test!.questions![currentQuestion].type == 'COMPARISON') {
      if(widget.test!.questions![currentQuestion].subOptions!= null){
        setState(() {
          uniqueList = widget.test!.questions![currentQuestion].subOptions!.map((option) => option.id).toList();
        });
      }
    }

  }




  void _initializeEntTestQuestions() {
    // Set initial state for questions

    if(entCurrentSubjectQuestion[currentQuestion].checkedAnswers!= null && entCurrentSubjectQuestion[currentQuestion].checkedAnswers!.isNotEmpty){
      for(int element in entCurrentSubjectQuestion[currentQuestion].checkedAnswers!){
        int index = entCurrentSubjectQuestion[currentQuestion].options!.indexWhere((option) => option.id == element);
        if (index != -1) {

          setState(() {
            entCurrentSubjectQuestion[currentQuestion].options![index].checked = true;
            hiddenSelected = index;
          });
        }
      }
    }


    if (entCurrentSubjectQuestion[currentQuestion].multipleAnswers == false) {
      for (var element in entCurrentSubjectQuestion[currentQuestion].options!) {
        if (element.checked == true) {
          setState(() {
            hiddenSelected = entCurrentSubjectQuestion[currentQuestion].options!.indexOf(element);
          });
        }
      }
    }

    if (entCurrentSubjectQuestion[currentQuestion].type == 'COMPARISON') {
      if(entCurrentSubjectQuestion[currentQuestion].subOptions!= null){
        setState(() {
          uniqueList = entCurrentSubjectQuestion[currentQuestion].subOptions!.map((option) => option.id).toList();
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 20,
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (value){
            if(widget.oneSubjectPage){
              _displayTestEndSource();
            }else{
              if(subjectSelected){
                resetValue();
              }else {
                _displayTestEndSource();
              }
            }
          },
          child: SingleChildScrollView(
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
                              if(widget.oneSubjectPage){
                                _displayTestEndSource();
                              }else{
                                if(subjectSelected){
                                  setState(() {
                                    resetValue();
                                  });
                                }else {
                                  _displayTestEndSource();
                                }
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

                        widget.oneSubjectPage? const SizedBox() : CountDownTimer(
                          duration: Duration(milliseconds: widget.ent!.timeLimitInMilliseconds!),
                          onTimePassed: () {endEntTest(true); },
                        ),
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
                            if(widget.oneSubjectPage){
                              _initializeAppTestQuestions();
                            }else{
                              _initializeEntTestQuestions();
                            }
                          });
                        },
                        questionNumber:widget.oneSubjectPage?  widget.test!.questions!.length : entCurrentSubjectQuestion.length,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              widget.oneSubjectPage ? widget.test!.questions![currentQuestion].question ?? '' : entCurrentSubjectQuestion[currentQuestion].question ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 20,),

                            widget.oneSubjectPage ?
                            widget.test!.questions![currentQuestion].context!= null ? Html(data: widget.test!.questions![currentQuestion].context!): const SizedBox()
                                : entCurrentSubjectQuestion[currentQuestion].context!=null? Html(data:entCurrentSubjectQuestion[currentQuestion].context!): const SizedBox(),

                            widget.oneSubjectPage ?

                            widget.test!.questions![currentQuestion].mediaFiles!= null?ListView.builder(
                                itemCount: widget.test!.questions![currentQuestion].mediaFiles!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return FutureBuilder<Uint8List?>(
                                    future: MediaFileRepository().downloadFile(widget.test!.questions![currentQuestion].mediaFiles![index].id),
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
                            ) : const SizedBox() :
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
                              itemCount: widget.oneSubjectPage ? widget.test!.questions![currentQuestion].options!.length:  entCurrentSubjectQuestion[currentQuestion].options!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){

                                if(widget.oneSubjectPage){
                                  if (widget.test!.questions![currentQuestion].type == 'COMPARISON' && widget.test!.questions![currentQuestion].subOptions != null && widget.test!.questions![currentQuestion].subOptions!.isNotEmpty) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(widget.test!.questions![currentQuestion].options![index].text ?? ' ')),
                                          const SizedBox(width: 25,),
                                          Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: AppColors.greyColor),
                                                  borderRadius: const BorderRadius.all(Radius.circular(5))
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: DropdownButton2<int>(
                                                value: widget.test!.questions![currentQuestion].options![index].subOption?.id,
                                                onChanged: (int? newValue) async {

                                                  if (newValue != null) {

                                                    for(var item in widget.test!.questions![currentQuestion].options!){
                                                      if(item.subOption != null){
                                                        if(item.subOption!.id == newValue){
                                                          item.subOption = widget.test!.questions![currentQuestion].options![index].subOption;

                                                          answerAppTest(widget.test!.questions![currentQuestion].id, item.id, widget.test!.questions![currentQuestion].options![index].subOption?.id,true);
                                                        }
                                                      }
                                                    }

                                                    int subIndex = widget.test!.questions![currentQuestion].subOptions!.indexWhere((option) => option.id == newValue);

                                                    setState(() {
                                                      widget.test!.questions![currentQuestion].options![index].subOption = widget.test!.questions![currentQuestion].subOptions![subIndex];
                                                      answerAppTest( widget.test!.questions![currentQuestion].id, widget.test!.questions![currentQuestion].options![index].id, newValue,true);
                                                    });
                                                  }
                                                },
                                                items:  uniqueList.map<DropdownMenuItem<int>>((int value) {

                                                  int subIndex = widget.test!.questions![currentQuestion].subOptions!.indexWhere((option) => option.id == value);

                                                  return DropdownMenuItem<int>(
                                                      value: value,
                                                      child: Text(
                                                        widget.test!.questions![currentQuestion].subOptions![subIndex].text ?? '',
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
                                      selected: widget.test!.questions![currentQuestion].options![index].checked ?? false,
                                      onAnswerSelected: () async {

                                        String? token = await SharedPreferencesOperator.getAccessToken();

                                        if(!(widget.test!.questions![currentQuestion].multipleAnswers ?? false)){
                                          if(hiddenSelected != null &&  hiddenSelected != index){
                                            widget.test!.questions![currentQuestion].options![hiddenSelected!].checked = false;
                                          }
                                          hiddenSelected = index;
                                        }

                                        setState(() {
                                          if(!(widget.test!.questions![currentQuestion].multipleAnswers ?? false)){

                                            widget.test!.questions![currentQuestion].options![index].checked = true;

                                            answerAppTest( widget.test!.questions![currentQuestion].id, widget.test!.questions![currentQuestion].options![index].id, null, true);
                                          }else{

                                            widget.test!.questions![currentQuestion].options![index].checked = !(widget.test!.questions![currentQuestion].options![index].checked ?? false);

                                            answerAppTest( widget.test!.questions![currentQuestion].id,widget.test!.questions![currentQuestion].options![index].id, null, widget.test!.questions![currentQuestion].options![index].checked ?? false);
                                          }

                                        });
                                      }, questionText: widget.test!.questions![currentQuestion].options![index].text ?? ''
                                  );
                                }else{
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
                                              child: DropdownButton2<int>(
                                                value:  entCurrentSubjectQuestion[currentQuestion].options![index].subOption?.id,
                                                onChanged: (int? newValue) async {
                                                  if (newValue != null) {

                                                    for(var item in entCurrentSubjectQuestion[currentQuestion].options!){
                                                      if(item.subOption != null){
                                                        if(item.subOption!.id == newValue){
                                                          item.subOption = entCurrentSubjectQuestion[currentQuestion].options![index].subOption;

                                                          answerEntTest(entCurrentSubjectQuestion[currentQuestion].id, item.id, entCurrentSubjectQuestion[currentQuestion].options![index].subOption?.id);
                                                        }
                                                      }
                                                    }

                                                    int subIndex = entCurrentSubjectQuestion[currentQuestion].subOptions!.indexWhere((option) => option.id == newValue);

                                                    setState(() {
                                                      entCurrentSubjectQuestion[currentQuestion].options![index].subOption = entCurrentSubjectQuestion[currentQuestion].subOptions![subIndex];
                                                      answerEntTest( entCurrentSubjectQuestion[currentQuestion].id, entCurrentSubjectQuestion[currentQuestion].options![index].id, newValue,);
                                                    });

                                                  }
                                                },
                                                items: uniqueList.map<DropdownMenuItem<int>>((int value) {

                                                  int subIndex = entCurrentSubjectQuestion[currentQuestion].subOptions!.indexWhere((option) => option.id == value);

                                                  return DropdownMenuItem<int>(
                                                      value: value,
                                                      child: Text(
                                                        entCurrentSubjectQuestion[currentQuestion].subOptions![subIndex].text ?? '',
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
                                      onAnswerSelected: () async {

                                        String? token = await SharedPreferencesOperator.getAccessToken();

                                        if(!(entCurrentSubjectQuestion[currentQuestion].multipleAnswers ?? false)){
                                          if(hiddenSelected != null &&  hiddenSelected != index){
                                            entCurrentSubjectQuestion[currentQuestion].options![hiddenSelected!].checked = false;
                                          }
                                          hiddenSelected = index;
                                        }

                                        setState(() {
                                          if(!(entCurrentSubjectQuestion[currentQuestion].multipleAnswers ?? false)){

                                            entCurrentSubjectQuestion[currentQuestion].options![index].checked = true;

                                            answerEntTest(entCurrentSubjectQuestion[currentQuestion].id, entCurrentSubjectQuestion[currentQuestion].options![index].id, null);
                                          }else{

                                            entCurrentSubjectQuestion[currentQuestion].options![index].checked = !(entCurrentSubjectQuestion[currentQuestion].options![index].checked ?? false);

                                            print(entCurrentSubjectQuestion[currentQuestion].options![index].checked);

                                            if(entCurrentSubjectQuestion[currentQuestion].options![index].checked!){
                                              answerEntTest(entCurrentSubjectQuestion[currentQuestion].id, entCurrentSubjectQuestion[currentQuestion].options![index].id,null);
                                            }else{
                                              deleteAnswerEntTest(entCurrentSubjectQuestion[currentQuestion].id, entCurrentSubjectQuestion[currentQuestion].options![index].id,null);
                                            }

                                          }

                                        });
                                      }, questionText: entCurrentSubjectQuestion[currentQuestion].options![index].text ?? ''
                                  );
                                }

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

                    if(widget.oneSubjectPage){
                     _displayTestEndSource();
                    }else{
                      setState(() {
                        subjectSelected = false;
                        currentQuestion = 0;
                      });
                    }

                  },
                  child: Text(AppText.exit, style: TextStyle(color: AppColors.blueColor, fontSize: 15), ),
                ),

                Text('${currentQuestion+1}/${ widget.oneSubjectPage? widget.test!.questions!.length : entCurrentSubjectQuestion.length}', style: TextStyle(color: AppColors.greyColor, fontSize: 15),),
                CommonButton(title: currentQuestion+1 == (widget.oneSubjectPage? widget.test!.questions!.length : entCurrentSubjectQuestion.length) ? AppText.end:AppText.next, onClick: () async {
                  if(currentQuestion+1 != (widget.oneSubjectPage? widget.test!.questions!.length : entCurrentSubjectQuestion.length)){
                    setState(() {
                      currentQuestion ++;
                      if(widget.oneSubjectPage){
                        _initializeAppTestQuestions();
                      }else{
                        _initializeEntTestQuestions();
                      }

                    });
                  }else {
                    if(widget.oneSubjectPage){
                      endAppTest(true);
                    }else{
                      setState(() {
                        entSubjectsMap[entSubjectsName[subjectIndex]] = true;


                        // print(entSubjectsMap);
                        resetValue();
                      });
                    }
                  }
                } , horizontalPadding: 27, verticalPadding: 13,fontSize: 15,)
              ],
            ):
            CommonButton(title: AppText.endTest, onClick: (){
              endEntTest(true);
            }, )
        )
    );
  }
}

class TestEndModal extends StatelessWidget {
  final bool oneSubjectPage;
  final VoidCallback onContinue;
  final VoidCallback onExit;

  const TestEndModal({super.key, required this.oneSubjectPage, required this.onContinue, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Сіз шынымен тестті аяқтағыңыз келе ме?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  title: 'Шығу',
                  onClick: onExit,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CommonButton(
                  title: 'Жалғастыру',
                  onClick: onContinue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}