import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'dart:math' as math;

class GameStartScreen extends StatefulWidget {
  const GameStartScreen({super.key});

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();


    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacement('/gameStartScreen/gameTestScreen');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: 90 * math.pi / 180,
              child: Transform.scale(
                scale: 3,
                child: SvgPicture.asset(
                  'assets/icons/decoration.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const PlayerWidget(
                  initial: 'В',
                  name: 'Орынжай Бекзат',
                ),
                const SizedBox(height: 80),
                AnimatedBuilder(
                  animation: _animation,
                  child: Image.asset('assets/image/thunder.png'),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value * 1.5,
                      child: Transform.rotate(
                        angle: _animation.value * 2 * math.pi,
                        child: child,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 80),
                const PlayerWidget(
                  initial: 'A',
                  name: 'Алуа Алпысбаева',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String initial;
  final String name;

  const PlayerWidget({
    Key? key,
    required this.initial,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                color: AppColors.greenColor,
                fontSize: 40,

              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
