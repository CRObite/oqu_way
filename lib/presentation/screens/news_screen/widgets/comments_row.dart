import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';

class CommentsRow extends StatefulWidget {
  const CommentsRow({super.key});




  @override
  State<CommentsRow> createState() => _CommentsRowState();
}

class _CommentsRowState extends State<CommentsRow> with SingleTickerProviderStateMixin {

  bool isOpened = false;

  late AnimationController _controller;
  late Animation<double> _rotateAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleOpened() {
    setState(() {
      isOpened = !isOpened;
      if (isOpened) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.3),
                        shape: BoxShape.circle
                    ),
                    padding: const EdgeInsets.all(13),
                    child: const Text('A',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  ),

                  const SizedBox(width: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Асем',style: TextStyle(fontWeight: FontWeight.bold),),
                      const Text('Консультация калай алуға болады?',style: TextStyle(),),
                      const SizedBox(height: 5,),
                      Text(AppText.sendResponse,style: TextStyle(color: AppColors.greyColor,fontSize: 12)),
                    ],
                  )
                ],
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_rounded,color: Colors.black,),
                  SizedBox(height: 3,),
                  Text('14',style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),

          const SizedBox(height: 10,),
          GestureDetector(
            onTap: toggleOpened,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 45,),
                SizedBox(
                  width: 10,
                  child: Divider(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(width: 5,),
                Text('${AppText.seeResponse} (6)',style: TextStyle(color: AppColors.greyColor,fontSize: 12)),
                const SizedBox(width: 5,),
                AnimatedBuilder(
                  animation: _rotateAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotateAnimation.value * 2 * 3.1415926535,
                      child: Transform.rotate(
                        angle: 90 * 3.1415926535/180,
                        child: SvgPicture.asset(
                          'assets/icons/ic_arrow.svg',
                          colorFilter: ColorFilter.mode(
                            AppColors.greyColor,
                            BlendMode.srcIn,
                          ),
                          height: 11,
                          width: 5,
                        ),
                      )
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 15,),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: child,
                ),
              );
            },
            child: isOpened ? ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const SizedBox(
                          width: 45,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor.withOpacity(0.3),
                                  shape: BoxShape.circle
                              ),
                              padding: const EdgeInsets.all(13),
                              child: const Text('A',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                            ),

                            const SizedBox(width: 10,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Oquway',style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: const Text(
                                    'Консультация калай алуға болады?',
                                    style: TextStyle(),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(AppText.sendResponse,style: TextStyle(color: AppColors.greyColor,fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.favorite_rounded,color: Colors.black,),
                            SizedBox(height: 3,),
                            Text('14',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  );
                }
            ): const SizedBox(key: ValueKey<bool>(false)),
          ),





        ],
      ),
    );
  }
}
