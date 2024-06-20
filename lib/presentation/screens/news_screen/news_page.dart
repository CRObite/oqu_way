import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/news_card.dart';


class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(AppText.news, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) {
                    return GestureDetector(
                        onTap: (){
                          context.goNamed('newsDetails');
                        },
                        child: const NewsCard()
                    );
                  }
              ),


              const SizedBox(height: 69,),
            ],
          ),
        ),
      ),
    );
  }
}
