import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../news_screen/widgets/comments_row.dart';

class ProfileComments extends StatefulWidget {
  const ProfileComments({super.key});

  @override
  State<ProfileComments> createState() => _ProfileCommentsState();
}

class _ProfileCommentsState extends State<ProfileComments> {

  TextEditingController commentController = TextEditingController();

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
  }
}
