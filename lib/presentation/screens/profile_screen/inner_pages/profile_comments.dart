import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/domain/app_user.dart';
import 'package:oqu_way/domain/comment.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../../domain/face_subject.dart';
import '../../news_screen/widgets/comments_row.dart';
import '../../news_screen/widgets/news_card.dart';

class ProfileComments extends StatefulWidget {
  const ProfileComments({super.key, required this.type, required this.id});

  final String type;
  final int id;

  @override
  State<ProfileComments> createState() => _ProfileCommentsState();
}

class _ProfileCommentsState extends State<ProfileComments> {

  TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];

  @override
  void initState() {
    getComments();
    getUsername();
    super.initState();
  }

  AppUser? user;

  Future<void> getUsername() async {
    String? userJson = await SharedPreferencesOperator.getCurrentUser();
    if(userJson!=null){
      Map<String, dynamic> userMap = jsonDecode(userJson);
      AppUser value = AppUser.fromJson(userMap);

      setState(() {
        user = value;
      });
    }
  }
  Future<void> getComments() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    if(widget.type == 'University'){
      List<Comment> value = await CommentRepository().getAllUniversityComments(token!, widget.id);

      setState(() {
        comments = value;
      });
    }else if(widget.type == 'Specialization'){
      List<Comment> value = await CommentRepository().getAllSpecializationComments(token!, widget.id);

      setState(() {
        comments = value;
      });
    }

  }

  Future<void> addComment() async {
    String? token = await SharedPreferencesOperator.getAccessToken();
    if(widget.type == 'University'){


      bool value = await CommentRepository().createComments(
          token!,
          commentController.text,
          CommentType.University,
          university: widget.id
      );
    }else if(widget.type == 'Specialization'){
      bool value = await CommentRepository().createComments(
          token!,
          commentController.text,
          CommentType.Specialization,
          specialization: widget.id
      );
    }


    getComments();

    commentController.clear();
  }


  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: Text(AppText.questions, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: comments.isEmpty ?  const Center(child: Text('Пікірлер Жоқ')) :ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return CommentsRow(comment: comments[index]);
                  },
                ),
              ),
            ),
            Divider(color: AppColors.greyColor),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 30),
              child: Row(
                children: [
                  user!= null && user!.avatar!=null ?  SizedBox(
                    height: 45,
                    width: 45,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: FutureBuilder<Uint8List?>(
                        future: MediaFileRepository().downloadFile(user!.avatar!.split('/').last),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox(
                                height: 70, width: double.infinity,
                                child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                          } else if (snapshot.hasError) {
                            return const NoImagePhoto(width: 35, height: 35,);
                          } else if (!snapshot.hasData) {
                            return const NoImagePhoto(width: 35, height: 35);
                          } else {
                            return Image.memory(snapshot.data!, fit: BoxFit.cover,width: 35,);
                          }
                        },
                      ),
                    ),
                  ):
                  user!= null && user!.login!=null ? Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        user!.login![0] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ): const SizedBox(),
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
                            InkWell(
                              onTap: (){
                                addComment();

                              },
                              child: Container(
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
  }
}
