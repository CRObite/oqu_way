import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/presentation/screens/on_board_screens/widgets/progress_button.dart';

import '../../../config/app_colors.dart';
import '../../common/widgets/rounded_circular_progress_indicator.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {



  Future<void> checkOnboard() async {
    if(await SharedPreferencesOperator.containsOnBoardStatus()){
      bool? value  = await SharedPreferencesOperator.getOnBoardStatus();
      if(value != null && value){
        context.go('/loginPage');
      }
    }

  }


  late Animation<double> _animation;
  late AnimationController _controller;

  double value = 0.33;
  double beginValue = 0;

  int currentPage = 1;

  @override
  void initState() {
    checkOnboard();

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: beginValue, end: value).animate(_controller)
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

  void _updateAnimation() {
    _controller.reset();
    _animation = Tween<double>(begin: beginValue, end: value).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  String _getImage(int pageNumber) {
    switch(pageNumber){
      case 1: return 'assets/image/onboard1.png';
      case 2: return 'assets/image/onboard2.png';
      case 3: return 'assets/image/onboard3.png';
      default: return 'assets/image/onboard1.png';
    }
  }

  void _changeParam(double currentParam) {
    beginValue = currentParam;
    value += 0.33;
    if(value >= 0.99){
      value = 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SafeArea(
                    child: TextButton(
                        onPressed: () {context.go('/loginPage');},
                        child: Text(
                          AppText.skip,
                          style: TextStyle(color: AppColors.blueColor),
                        ))),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_getImage(currentPage)),
                  Text(
                    AppText.preparingToExam,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppText.withOquway,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ProgressButton(
                    animation: _animation,
                    onPressed: () {
                      if(value!= 1){
                        currentPage ++;
                        setState(() {
                          _changeParam(value);
                        });
                        _updateAnimation();
                      }else{
                        SharedPreferencesOperator.saveOnBoardStatus(true);
                        context.go('/loginPage');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
