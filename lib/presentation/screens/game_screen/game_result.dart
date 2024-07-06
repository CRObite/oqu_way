import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';
import '../../common/widgets/common_button.dart';

class GameResult extends StatefulWidget {
  const GameResult({super.key});

  @override
  State<GameResult> createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

  bool isWinner = true;
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                boxShadow: AppShadow.shadow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset(
                      'assets/icons/decoration.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isWinner = !isWinner;
                        });
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: _scale),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Image.asset(isWinner ? 'assets/image/star.png' : 'assets/image/die.png'),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isWinner
                      ? Text(
                    'Сіз ұттыңыз!',
                    style: TextStyle(
                      fontSize: 38,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : const Text(
                    'Сіз ұтылдыңыз!',
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.blueColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Пән',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Тарих',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.blueColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Дұрыс жауаптар',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '3/5',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: AppColors.blueColor,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/ic_again.svg'),
                        const SizedBox(width: 10),
                        const Text(
                          'Реванш',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Соңғы ойындар',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: AppShadow.shadow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.greyColor.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'B',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Бекзат Орынжай',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Пән: Физика',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 42),
        surfaceTintColor: Colors.transparent,
        height: 95,
        child: CommonButton(
          title: 'Ойынды аяқтау',
          onClick: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
