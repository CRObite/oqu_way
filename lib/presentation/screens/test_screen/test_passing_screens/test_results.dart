import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';
import '../widgets/select_next_subject.dart';

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> with SingleTickerProviderStateMixin {

  List<int> values = [9,18,20,35,38];
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
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
      ),
      body:SingleChildScrollView(
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


              const SizedBox(height: 15,),
              const Align(alignment: Alignment.center,child: Text('121/140')),
              const SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return SelectNextSubject(
                        onSelected: () {
                          context.push('/testResults/testMistakeWork');
                        },
                        ended: false,
                        score: values[index],
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
            child: CommonButton(title: AppText.exit, onClick: (){
              context.pop();
            }, )
        )
    );
  }
}
