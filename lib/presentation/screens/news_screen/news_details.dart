import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_image.dart';
import 'package:oqu_way/config/app_text.dart';

import '../../common/widgets/comment_view_check_row.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.displayBottomCommentsCallback});

  final Function(BuildContext) displayBottomCommentsCallback;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('< ${AppText.news}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    const Text('Как будет проходить ЕНТ в  2023 году?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),

              SizedBox(
                height: 250,
                child: Image.network(AppImage.newsImage, fit: BoxFit.cover,),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommentViewCheckRow(iconSize: 18, fontSize: 12,
                      onCommentsTap: () {
                        displayBottomCommentsCallback(context);
                      },
                    ),

                    const SizedBox(height: 10,),

                    const Text('Қаңтар ҰБТ-сы ақылы болғанын бәріміз білеміз. Ал Маусым ҰБТ-сы мектеп оқушыларына тегін болады. Айырмашылық неде? Қаңтар, Наурыз және Тамыз ҰБТ-сының сертификаттары университетке ақылы бөлімге түсуге мүмкіндік береді. Маусым ҰБТ-сының сертификаты грант конкурсына қатысуға мүмкіндік береді. Оқушылардың арасында жиі кездесетін қате пікір: «Мен Наурыз ҰБТ-ны тапсырсам Қаңтар ҰБТ-ның нәтижесі жойылып кетеді» Оқушы 4 ҰБТ-ны тапсырса, сол 4-еуінің де нәтижесі келесі оқу жылына дейін сақталады Сәйкесінше, оқуға түсерде өзі қалаған сертификатты қолдана алады ҰБТ-ның нәтижесін біздің приложениеден көруге болады. Ол үшін өз профиліңе кіріп, ЖСН (ИИН) енгізу керек.',
                     style: TextStyle(fontSize: 12),)

                  ],
                ),
              ),

              const SizedBox(height: 100,),

            ],
          ),
        ),
      ),
    );
  }


  Future _displayBottomComments(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
           return Column(
             children: [
               Container(
                 height: 300,
               )
             ],
           );
        }
    );
  }
}
