import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_toast.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/ent_test_repository/ent_test_repository.dart';
import 'package:oqu_way/domain/ent_test.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/subject_picker_drop_down.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';
import '../../../domain/subject.dart';

class TestSubjectSelectPage extends StatefulWidget {
  const TestSubjectSelectPage({super.key});

  @override
  State<TestSubjectSelectPage> createState() => _TestSubjectSelectPageState();
}

class _TestSubjectSelectPageState extends State<TestSubjectSelectPage> {

  Subject? selectedFirst;
  Subject? selectedSecond;

  bool isLoading = false;
  String errorText = '';

  List<Subject> firstList = [];
  List<Subject> secondList = [];

  @override
  void initState() {
    getFistSubjects();
    super.initState();
  }

  Future<void> getFistSubjects() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Subject> values = await EntTestRepository().getAllEntSubjects(token!);
    setState(() {
      firstList = values;
    });
  }

  Future<void> getSecondSubjects(int id) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Subject> values = await EntTestRepository().getAllEntSubjectsByFirst(token!, id);
    setState(() {
      secondList = values;
    });
  }

  Future<void> startTest() async {



    try{

      setState(() {
        isLoading = true;
      });
      String? token = await SharedPreferencesOperator.getAccessToken();

      if(selectedFirst != null && selectedSecond != null){
        EntTest? values = await EntTestRepository().generateEntTest(token!, selectedFirst!.id, selectedSecond!.id, 'SURVIVAL');

        setState(() {
          isLoading = false;
        });

        selectedFirst = null;
        selectedSecond = null;

        context.push('/testPassingPage', extra: {'ent_test': values});
      }else{
        AppToast.showToast('Пәндерді таңданыз');

        setState(() {
          isLoading = false;
        });
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });

      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        setState(() {
          errorText = exception.message;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    bool isSmall = MediaQuery.of(context).size.width <= 360;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoading ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                CircularProgressIndicator(color: AppColors.blueColor,),
                const SizedBox(height: 20,),
                
                Text('Тест генерациясы жүріп жатыр күте тұрыңыз',textAlign: TextAlign.center,style: TextStyle(color: AppColors.blueColor,fontSize: 20),)
              ],
            ),):Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('ҰБТ байқау тесті', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height:46,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: isSmall? 100: 138,
                      height: isSmall? 100: 138,
                      padding: EdgeInsets.all( isSmall? 10:20),
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
                      valuesWithExtra: firstList,

                      onValueSelected: (Subject value) {

                        setState(() {
                          selectedSecond = null;
                          selectedFirst = value;
                        });

                        getSecondSubjects(value.id);

                      },
                      hint: AppText.firstSubject,
                    ),

                    const SizedBox(height: 20,),

                    IgnorePointer(
                      ignoring: selectedFirst == null,
                      child: SubjectPickerDropDown(
                        valuesWithExtra: secondList,
                        onValueSelected: (Subject value) {
                          selectedSecond = value;
                        },
                        hint: AppText.secondSubject,
                      ),
                    ),
                    SizedBox(height: errorText.isNotEmpty?10: 0,),

                    errorText.isNotEmpty?Text(errorText, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red,fontSize: 12),): const SizedBox(),

                    const SizedBox(height: 40,),


                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CommonButton(
                        title: AppText.startTest,
                        onClick: (){
                          startTest();
                        },
                        radius: 10,
                        fontSize: 13,
                        horizontalPadding: 24,
                      ),
                    )


                  ],
                ),



                SizedBox(height: isSmall? 0: 90,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
