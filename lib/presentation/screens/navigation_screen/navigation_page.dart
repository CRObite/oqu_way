import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/blocs/navigation_screen/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/comments_row.dart';

import '../../../config/app_colors.dart';
import '../../common/widgets/custom_app_bar.dart';
import '../../common/widgets/custom_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  TextEditingController commentController = TextEditingController();
  NavigationPageCubit navigationPageCubit = NavigationPageCubit();


  void _goToBranch( int index) {
    widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex
    );
  }



  void _displayBottomComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 54),
                Divider(color: AppColors.greyColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const CommentsRow();
                      },
                    ),
                  ),
                ),
                Divider(color: AppColors.greyColor),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                              width: 1,
                              color: AppColors.greyColor.withOpacity(0.5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: commentController,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppText.yourQuestion,
                                      hintStyle: TextStyle(color: AppColors.greyColor.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.blueColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.white,
                                      size: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }






  @override
  void dispose() {
    commentController.dispose();
    navigationPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onBellPressed: (){},
        title: 'Алуа Алпысбаева',
        imageId: '',
        setDot: true,
      ),
      body: BlocProvider(
        create: (context) => navigationPageCubit,
        child: BlocListener<NavigationPageCubit,NavigationPageState>(
          listener: (context,state){
            if(state is NavigationPageComments){
              _displayBottomComments();
            }
          },
          child: Stack(
              children:[

                widget.navigationShell,

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomNavBar(
                    onNavigation: (int value) {
                      _goToBranch(value);
                    },
                  ),
                ),
              ]
          ),
        ),

      )
    );
  }
}
