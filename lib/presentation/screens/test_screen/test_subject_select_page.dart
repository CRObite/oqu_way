import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/subject_picker_drop_down.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';

class TestSubjectSelectPage extends StatefulWidget {
  const TestSubjectSelectPage({super.key});

  @override
  State<TestSubjectSelectPage> createState() => _TestSubjectSelectPageState();
}

class _TestSubjectSelectPageState extends State<TestSubjectSelectPage> {

  String selectedFirst = '';
  String selectedSecond = '';

  List<String> valuesWithExtra = ['Предмет','Предмет2','Предмет3','Предмет4','Предмет5','Предмет6','Предмет7','Предмет8','Предмет9','Предмет10','Предмет11','Предмет12',];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('${AppText.onlineTests} > ҰБТ байқау тесті', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height:46,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 138,
                      height: 138,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.testCircleGreenColor,
                          shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset('assets/image/chart.png'),
                      ),
                    ),
                    const SizedBox(height: 33,),
                                
                    SubjectPickerDropDown(
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedFirst,
                      onValueSelected: (String value) {
                        selectedFirst = value;
                      },
                      hint: AppText.firstSubject,
                    ),
                                
                    const SizedBox(height: 20,),
                                
                    SubjectPickerDropDown(
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedSecond,
                      onValueSelected: (String value) {
                        selectedSecond = value;
                      },
                      hint: AppText.secondSubject,
                    ),
                                
                    const SizedBox(height: 40,),
                                
                                
                    SizedBox(
                        width: 140,
                        child: CommonButton(
                          title: AppText.startTest,
                          onClick: (){
                            context.push('/testPassingPage');
                          },
                          radius: 10,
                          fontSize: 13,
                          horizontalPadding: 24,
                        )
                    )
                                
                                
                  ],
                ),



                const SizedBox(height: 90,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
