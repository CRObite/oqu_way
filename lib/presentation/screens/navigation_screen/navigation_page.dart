import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/presentation/blocs/navigation_screen/navigation_page_cubit/navigation_page_cubit.dart';

import '../../../data/repository/auth_reg_repository/authorization_repository.dart';
import '../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../domain/app_user.dart';
import '../../../util/custom_exeption.dart';
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
  Uint8List? avatarData;

  Future<void> getUsername() async {

    try{
      String? token = await SharedPreferencesOperator.getAccessToken();
      AppUser? value = await AuthorizationRepository().userGetMe(token!);

      setState(() {
        username = value;
      });

      if (value!.avatar != null && value.avatar!.isNotEmpty) {
        Uint8List? data = await MediaFileRepository().downloadFile(value.avatar!.split('/').last);
        setState(() {
          avatarData = data;
        });
      }
    }catch(error){

      if(error is DioException){
        CustomException exception = CustomException.fromDioException(error);

        if(exception.statusCode == 401){

          String? refToken = await SharedPreferencesOperator.getRefreshToken();

          bool value = await AuthorizationRepository().refreshToken(refToken!);
          if(value){
            getUsername();
          }else{
            SharedPreferencesOperator.clearCurrentUser();
            SharedPreferencesOperator.clearAccessToken();
            SharedPreferencesOperator.clearRefreshToken();
            context.go('/loginPage');
          }
        }
      }
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
      appBar: CustomAppBar(
        onBellPressed: () {
          context.push('/notificationPage');
        },
        title: username!= null?  username!.login! : '?',
        setDot: false,
        avatarData: avatarData,
        moveTo: () async {
          Object? value = await context.push('/profilePage');

          if(value != null){
            getUsername();
          }
        },
      ),
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
