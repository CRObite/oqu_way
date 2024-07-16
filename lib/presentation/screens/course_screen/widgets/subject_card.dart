import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../domain/module.dart';
import '../../../common/card_container_decoration.dart';
import 'common_progress_indicatore.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({super.key, required this.module, required this.onOpened});

  final Module module;
  final VoidCallback onOpened;

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
    isOpened = widget.module.opened;

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

    widget.onOpened();
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
                    Text(widget.module.name ?? '???', style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
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
                    Expanded(child: CommonProgressIndicator(percent: widget.module.percentage ?? 0.0,)),
                    const SizedBox(width: 5,),
                    Text('${((widget.module.percentage ?? 0.0) * 100).round()}%', style: TextStyle(color: AppColors.greenColor, fontSize: 11),),
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
