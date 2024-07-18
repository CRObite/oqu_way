import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/domain/app_user.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/domain/post.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';
import '../../../data/local/shared_preferences_operator.dart';
import '../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../domain/comment.dart';
import '../../screens/news_screen/widgets/comments_row.dart';
import '../../screens/news_screen/widgets/news_card.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({Key? key,  required this.newsId}) : super(key: key);

  final int newsId;

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    getComments();
    getUsername();
  }

  Future<void> getComments() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Comment> value = await CommentRepository().getAllNewsComments(token!, widget.newsId);

    setState(() {
      comments = value;
    });
  }

  Future<void> addComment() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    bool value = await CommentRepository().createComments(
        token!,
        commentController.text,
        CommentType.Post,
        post:  widget.newsId
    );


    getComments();

    commentController.clear();
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

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 54,
              child: Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            Divider(color: AppColors.greyColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: comments.isEmpty ? const Center(
                  child: Text('Пікірлер Жоқ'),
                ) : ListView.builder(
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
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          width: 1,
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              onTap: () {
                                if (commentController.text.isNotEmpty) {
                                  addComment();
                                }
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
