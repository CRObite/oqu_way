import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/answer_card.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/select_next_subject.dart';

import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/count_down_timer.dart';
import '../../news_screen/widgets/news_card.dart';
import '../widgets/question_number_row.dart';

class TestPassingPage extends StatefulWidget {
  const TestPassingPage({super.key, this.oneSubjectPage = false, required this.test});

  final bool oneSubjectPage;
  final AppTest? test;

  @override
  State<TestPassingPage> createState() => _TestPassingPageState();
}

class _TestPassingPageState extends State<TestPassingPage> {


  bool subjectSelected = false;
  int subjectIndex = 0;
  int currentQuestion = 0;
  int? hiddenSelected;



  List<String> valuesWithExtra = ['value1value1value1', 'value2','value3','value4',];
  List<String> selectedValues = ['','','',''];


  @override
  void initState() {
    print(widget.oneSubjectPage);

    subjectSelected = widget.oneSubjectPage;
    super.initState();
  }


  List<bool> ended = [false,false,false,false,false];

  void _displayTestEndSource() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 54,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: const BorderRadius.all(Radius.circular(50))
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColors.greyColor),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Тесттен шығуға сенімдісізбе?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 25,),
                      GestureDetector(
                        onTap: (){context.pop();},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: AppColors.blueColor
                            ),
                            color: AppColors.blueColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child: Row(
                            children: [
                              Text('Жалғастыру',style: TextStyle(fontSize: 14,color: AppColors.blueColor,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8,),

                      GestureDetector(
                        onTap: (){
                          if(widget.oneSubjectPage){
                            context.go('/course/courseDetails');
                          }else{
                            context.go('/testSubjectSelectPage');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: AppShadow.cardShadow
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child: const Row(
                            children: [
                              Text('Шығу',style: TextStyle(fontSize: 14,color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    ).whenComplete(() {

    });
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
                setState(() {
                  subjectSelected = false;
                });
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
                                    subjectSelected = false;
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
                          duration: const Duration(hours: 3,minutes: 58,seconds: 48),
                          onTimePassed: () { context.pushReplacement('/testResults'); },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

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
                        onSelectQuestion: (value) {
                          setState(() {
                            currentQuestion = value;
                          });
                        },
                        questionNumber: widget.test!.questions!.length,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              widget.test!.questions![currentQuestion].question ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 20,),

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
                            ) : const SizedBox(),

                            const SizedBox(height: 10,),

                            ListView.builder(
                              itemCount: widget.test!.questions![currentQuestion].options!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){

                                if(widget.test!.questions![currentQuestion].checkedAnswers!= null && widget.test!.questions![currentQuestion].checkedAnswers!.isNotEmpty){
                                  for(int element in widget.test!.questions![currentQuestion].checkedAnswers!){
                                    int index = widget.test!.questions![currentQuestion].options!.indexWhere((option) => option.id == element);
                                    if (index != -1) {
                                      widget.test!.questions![currentQuestion].options![index].checked = true;
                                    }
                                  }
                                }



                                if(widget.test!.questions![currentQuestion].subOptions!= null && widget.test!.questions![currentQuestion].subOptions!.isNotEmpty){
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        const Expanded(child: Text('Абылай хан')),
                                        const SizedBox(width: 25,),
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: AppColors.greyColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(5))
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: DropdownButton2<String>(
                                            value: selectedValues[index].isNotEmpty ? selectedValues[index] : null,
                                            onChanged: (String? newValue) {
                                              if(newValue!= null){

                                                if(selectedValues.contains(newValue)){
                                                  setState(() {
                                                    selectedValues[selectedValues.indexOf(newValue)] = selectedValues[index];
                                                    selectedValues[index] = newValue;
                                                  });
                                                }else{
                                                  setState(() {
                                                    selectedValues[index] = newValue;
                                                  });
                                                }

                                              }
                                            },
                                            items: valuesWithExtra.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                    value,
                                                  style: const TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            iconStyleData: IconStyleData(
                                                icon: Transform.rotate(
                                                  angle: 90 * 3.1415926535/180,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/ic_arrow.svg',
                                                    height: 11,
                                                    width: 5,
                                                  ),
                                                )
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
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return AnswerCard(
                                    selected: widget.test!.questions![currentQuestion].options![index].checked ?? false,
                                    onAnswerSelected: (){
                                      if(!(widget.test!.questions![currentQuestion].multipleAnswers ?? false)){
                                        if(hiddenSelected != null &&  hiddenSelected != index){
                                          widget.test!.questions![currentQuestion].options![hiddenSelected!].checked = false;
                                        }
                                        hiddenSelected = index;
                                      }

                                      setState(() {
                                        if(!(widget.test!.questions![currentQuestion].multipleAnswers ?? false)){

                                          widget.test!.questions![currentQuestion].options![index].checked = true;

                                        }else{

                                          widget.test!.questions![currentQuestion].options![index].checked = !(widget.test!.questions![currentQuestion].options![index].checked ?? false);
                                        }

                                      });
                                    }, questionText: widget.test!.questions![currentQuestion].options![index].text ?? ''
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

                Text('${currentQuestion+1}/${widget.test!.questions!.length}', style: TextStyle(color: AppColors.greyColor, fontSize: 15),),
                CommonButton(title: currentQuestion+1 == widget.test!.questions!.length ?AppText.end:AppText.next, onClick: (){
                  if(currentQuestion+1 != widget.test!.questions!.length){
                    setState(() {
                      currentQuestion ++;
                    });
                  }else {
                    if(widget.oneSubjectPage){
                      context.push('/testPassingPage/courseTestResult');
                    }else{
                      setState(() {
                        ended[subjectIndex] = true;
                        subjectSelected = false;
                        currentQuestion = 0;
                      });
                    }
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
