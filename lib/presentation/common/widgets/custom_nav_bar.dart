import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.onNavigation});

  final Function(int) onNavigation;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int selectedIndex = 0;
  List<String> icons= ['assets/icons/ic_news.svg','assets/icons/ic_course.svg','assets/icons/ic_play.svg','assets/icons/ic_test.svg','assets/icons/ic_university.svg',];


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
      height: MediaQuery.of(context).size.width * .175,
      decoration: BoxDecoration(
          color: AppColors.blueColor,
          boxShadow: AppShadow.shadow,
          borderRadius: BorderRadius.circular(100)
      ),
      child: ListView.builder(
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              setState(() {
                selectedIndex = index;
                widget.onNavigation(index);
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: MediaQuery.of(context).size.width * 0.14,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == selectedIndex ? MediaQuery.of(context).size.width * 0.14 : 0,
                    width:  index == selectedIndex ? MediaQuery.of(context).size.width * 0.14 : 0,
                    decoration: BoxDecoration(
                      color: index == selectedIndex ? Colors.white : Colors.transparent,
                      borderRadius:  BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width:  MediaQuery.of(context).size.width * 0.185,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),

                        ],
                      ),

                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:MediaQuery.of(context).size.width * 0.045,
                          ),

                          SvgPicture.asset(
                            icons[index],
                            colorFilter: ColorFilter.mode(
                              index == selectedIndex ? AppColors.blueColor : Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: MediaQuery.of(context).size.width * 0.05,
                          )
                        ],
                      )

                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
