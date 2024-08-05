import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_image.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/data/repository/post_repository/post_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/presentation/blocs/navigation_screen/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/news_card.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_image_loading.dart';
import '../../../data/local/shared_preferences_operator.dart';
import '../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../domain/comment.dart';
import '../../../domain/post.dart';
import '../../common/widgets/comment_view_check_row.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.newsId});

  final int? newsId;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  Post? post;
  bool isLoading = true;


  @override
  void initState() {
    print(widget.newsId);
    if(widget.newsId!= null){
      getPostById();
    }
    super.initState();
  }



  Future<void> getPostById() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    Post? value = await PostRepository().getPostById(token!, widget.newsId!);
    setState(() {
      post = value;
      isLoading =false;
    });
  }


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);


    return PopScope(
      onPopInvoked : (didPop){
        navigationPageCubit.closeComments();
      },
      child: Container(
        color: Colors.white,
        child: isLoading? const Center(child: CircularProgressIndicator(),):
            post!= null?
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                            context.pop();
                          },
                          child: Text('< ${AppText.news}',
                            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                      ),
                      const SizedBox(height: 10,),
                      Text(post!.title ?? '???',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                SizedBox(
                  height: 250,
                  child: FutureBuilder<Uint8List?>(
                    future: MediaFileRepository().downloadFile(post!.mediaFiles!.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 250, width: double.infinity,
                            child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                      } else if (snapshot.hasError) {
                        return const NoImagePhoto(height: 250, width: double.infinity);
                      } else if (!snapshot.hasData) {
                        return const NoImagePhoto(height: 250, width: double.infinity);
                      } else {
                        return Image.memory(snapshot.data!, width: double.infinity,fit: BoxFit.cover,);
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CommentViewCheckRow(iconSize: 18, fontSize: 12,
                      //   onCommentsTap: () {
                      //     if(widget.newsId!= null){
                      //       navigationPageCubit.openComments(widget.newsId!);
                      //     }
                      //   },
                      // ),

                      GestureDetector(
                        onTap: (){
                          if(widget.newsId!= null){
                            navigationPageCubit.openComments(widget.newsId!);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_comments.svg',
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),

                              const SizedBox(width: 10,),

                              const Text('пікірлерді ашу',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),

                      Html(data: post!.description ?? '???',)
                    ],
                  ),
                ),

                const SizedBox(height: 100,),

              ],
            ),
          ),
        ): const Center(child: Text('ErrorText')),
      ),
    );
  }
}
