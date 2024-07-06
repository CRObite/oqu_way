import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../common/info_border_row.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';

class CourseTestResult extends StatefulWidget {
  const CourseTestResult({super.key});

  @override
  State<CourseTestResult> createState() => _CourseTestResultState();
}

class _CourseTestResultState extends State<CourseTestResult> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0.7).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        const Center(
                          child: Text(
                            '121',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                const InfoBorderRow(label: 'Пән', value: 'Тарих'),
                const InfoBorderRow(label: 'Уақыт', value: '40 мин'),
                const InfoBorderRow(label: 'Сұрақ саны', value: '35'),

                const SizedBox(height: 80,),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 30),
            surfaceTintColor: Colors.transparent,
            height: 160,
            child: Column(
              children: [
                SizedBox(
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

                      padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 27),
                    ),

                    onPressed: () {
                      context.push('/testResults/testMistakeWork');
                    },
                    child: Text('Қатемен жұмыс', style: TextStyle(color: AppColors.blueColor, fontSize: 15), ),
                  ),
                ),
                const SizedBox(height: 15,),
                CommonButton(title:'Шығу', onClick: (){context.go('/course/courseDetails');},),
              ],
            )
        )

    );
  }
}
