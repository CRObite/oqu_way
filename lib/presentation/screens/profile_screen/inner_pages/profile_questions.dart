import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../test_screen/widgets/subject_picker_drop_down.dart';

class ProfileQuestions extends StatefulWidget {
  const ProfileQuestions({super.key});

  @override
  State<ProfileQuestions> createState() => _ProfileQuestionsState();
}

class _ProfileQuestionsState extends State<ProfileQuestions> {

  String selectedFirst = '';
  int selected = 0;
  bool ananimus = false;
  TextEditingController controller = TextEditingController();

  List<String> questionTitle = ['Платформа бойынша','Сабақтар бойынша','Төлем бойынша','Басқа'];
  List<String> valuesWithExtra = ['Мұғлімге','Кураторға','Психологқа','Техподдержка'];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          title: Text(AppText.questions, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Сұрақ тақырыбы',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                ListView.builder(
                    itemCount:  questionTitle.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap:  (){
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(questionTitle[index],
                                style: TextStyle(
                                  color:  selected == index ?  null:AppColors.greyColor,
                                  fontWeight:  selected == index ?  FontWeight.bold : null,
                                ),
                              ),

                              Container(
                                height: 16,
                                width: 16,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1,color:
                                  selected == index ? AppColors.blueColor.withOpacity(0.5) :
                                  AppColors.greyColor
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selected == index ? AppColors.blueColor:Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),


                const SizedBox(height: 30,),

                SubjectPickerDropDown(
                  valuesWithExtra: valuesWithExtra,
                  selectedValue: selectedFirst,
                  onValueSelected: (String value) {
                    selectedFirst = value;
                  },
                  hint: 'Кімге',
                ),
                const SizedBox(height: 30,),

                const Text('Өзіңіздің сұрағыңызды жазыңыз',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(width: 2, color: AppColors.greyColor.withOpacity(0.5)),
                  ),
                  padding: const EdgeInsets.only(top: 2,bottom: 2, left: 16),
                  child: TextFormField(
                    maxLines: 3,
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Сұрақ тураkлы жазыңыз',
                      hintStyle: TextStyle(color: AppColors.greyColor)
                    ),
                  ),
                ),
                
                const SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      ananimus = !ananimus;
                    });
                  },
                  child: Row(
                    children: [

                      Container(
                        height: 16,
                        width: 16,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1,color:
                          ananimus ? AppColors.blueColor.withOpacity(0.5) :
                          AppColors.greyColor
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ananimus ? AppColors.blueColor:Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10,),

                      Text('Анонимді')
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title: 'Жіберу', onClick: (){context.pop();})
        )

    );
  }
}
