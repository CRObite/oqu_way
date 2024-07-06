import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../common/card_container_decoration.dart';
import 'common_progress_indicatore.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({super.key, required this.opened, required this.openedChanged});

  final bool opened;
  final VoidCallback openedChanged;

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> with SingleTickerProviderStateMixin {

  late bool isOpened;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isOpened = widget.opened;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    if (isOpened) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      isOpened = !isOpened;
    });

    if (isOpened) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    widget.openedChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: CardContainerDecoration.decoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Модуль атауы', style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * (180 * 3.1415926535 / 180),
                          child: Transform.rotate(
                            angle: 90 * 3.1415926535/180,
                            child: SvgPicture.asset('assets/icons/ic_arrow.svg', height: 10,),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    const Expanded(child: CommonProgressIndicator()),
                    const SizedBox(width: 5,),
                    Text('90%', style: TextStyle(color: AppColors.greenColor, fontSize: 11),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
