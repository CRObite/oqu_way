import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/ent_test_repository/ent_test_repository.dart';
import 'package:oqu_way/domain/ent_result.dart';
import 'package:oqu_way/domain/ent_test.dart';

import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';
import '../widgets/select_next_subject.dart';

class TestResults extends StatefulWidget {
  const TestResults({super.key, required this.testId});

  final String? testId;


  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> with SingleTickerProviderStateMixin {


  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    getEntTestResult();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EntResult? result;

  Future<void> getEntTestResult() async {

    String? token = await SharedPreferencesOperator.getAccessToken();

    EntResult? value = await EntTestRepository().resultEntTest(token!,widget.testId!);
    setState(() {
      result = value;
      isLoading = false;

      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
      _animation = Tween<double>(begin: 0, end: result!.totalResult.score / result!.totalResult.maxScore ).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.forward();

    });

  }


  Future<void> getEntMistake() async {

    setState(() {
      isLoading = true;
    });
    String? token = await SharedPreferencesOperator.getAccessToken();

    EntTest? value = await EntTestRepository().getMistakes(token!,widget.testId!);

    setState(() {
      isLoading = false;
    });

    context.push('/testResults/testMistakeWork',extra: {'test_mistake': value} );
  }


  //27aa30ec-b882-47f6-a473-d5e75b2f6e72


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
      ),
      body: isLoading? Center(child: CircularProgressIndicator(color: AppColors.blueColor,),): SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: (){
                    context.pop();
                  },
                  child: Transform.rotate(
                    angle: 180 * 3.1415926535/180,
                    child: SvgPicture.asset(
                      'assets/icons/ic_arrow.svg',
                      height: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36,),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomPaint(
                          size: const Size(120, 120),
                          painter: RoundedCircularProgressIndicator(
                            value: _animation.value,
                            color: AppColors.greenColor,
                            strokeWidth: 15,
                            backgroundColor: AppColors.greyColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${result!.totalResult.score}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              const SizedBox(height: 15,),
              Align(alignment: Alignment.center,child: Text('${result!.totalResult.score}/${result!.totalResult.maxScore}')),
              const SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: result!.subjectsResult.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return SelectNextSubject(
                        onSelected: () {
                        },
                        ended: false,
                        score:  result!.subjectsResult[index].score,
                        title: result!.subjectsResult[index].subjectName,
                      );
                    }
                ),
              )
              

            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 27),
              ),
              onPressed: () {
                getEntMistake();
              },
              child: Text(
                'Қатемен жұмыс',
                style: TextStyle(color: AppColors.blueColor, fontSize: 15),
              ),
            ),
          ),
        )
    );
  }
}
