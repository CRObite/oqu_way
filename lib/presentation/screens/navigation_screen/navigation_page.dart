import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/presentation/blocs/navigation_screen/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/comments_row.dart';

import '../../../config/app_colors.dart';
import '../../../domain/app_user.dart';
import '../../../domain/comment.dart';
import '../../common/widgets/comments_bottom_sheet.dart';
import '../../common/widgets/custom_app_bar.dart';
import '../../common/widgets/custom_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final TextEditingController commentController = TextEditingController();
  final NavigationPageCubit navigationPageCubit = NavigationPageCubit();



  int currentPage = 0;

  AppUser? username;

  Future<void> getUsername() async {
    String? userJson = await SharedPreferencesOperator.getCurrentUser();
    if(userJson!=null){
      Map<String, dynamic> userMap = jsonDecode(userJson);
      AppUser user = AppUser.fromJson(userMap);

      setState(() {
        username = user;
      });
    }
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }


  void _goToBranch(int index) {
    setState(() {
      currentPage = index;
    });

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _displayBottomComments(int newsId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CommentsBottomSheet(newsId: newsId);
      },
    ).whenComplete(() {
      if (Navigator.canPop(context)) {
        Future.delayed(const Duration(milliseconds: 100), () {
          navigationPageCubit.closeComments();
        });
      }
    });
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
      appBar: currentPage != 2
          ? CustomAppBar(
        onBellPressed: () {
          context.push('/notificationPage');
        },
        title: username!= null?  username!.login! : '?',
        imageId: username!= null?  username!.avatar!= null ? username!.avatar!.split('/').last : '' : '',
        setDot: false,
      )
          : null,
      body: BlocProvider(
        create: (context) => navigationPageCubit,
        child: BlocListener<NavigationPageCubit, NavigationPageState>(
          listener: (context, state) {
            if (state is NavigationPageComments) {
              _displayBottomComments(state.newsId);
            } else if (state is NavigationPageCommentsClose) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          },
          child: Stack(
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
