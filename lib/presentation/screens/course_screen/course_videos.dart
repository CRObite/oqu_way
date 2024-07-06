import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:video_player/video_player.dart';

class CourseVideos extends StatefulWidget {
  const CourseVideos({super.key});

  @override
  State<CourseVideos> createState() => _CourseVideosState();
}

class _CourseVideosState extends State<CourseVideos> {
  
  late FlickManager flickManager;
  
  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.asset('assets/icons/video.mp4')
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: (){context.pop();},
                    child: Text(AppText.video, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),

                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: FlickVideoPlayer(flickManager: flickManager)
                ),

                const SizedBox(height: 36),
                Text(AppText.description, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20),
                const Text('Біз көрсететін Грант саны - ЖАЛПЫ ГРАНТ конкурсында ойнатылатын грант саны. Бұл жерде «педагогикалық квота», «медициналық квота», «серпін» секілді квоталық гранттар көрсетілмеген. IT маман – компьютерлік жүйелерді әзірлейді. Бағдарлама жасайды, компьютерге қатысты жұмыстарды істейді. Олар – электроника инженерлері, байланыс және аспап жасаушы инженерлер, өнеркәсіптік роботтарға техникалық қызмет көрсетуші. Жұмысы жайлы: IT маманы әлемдегі ең керекті және перспективті мамандықтардың бірі. IT мамандығына түсу арқылы сіз JAVA, C++, PYTHON, HTML жүйесінде код жазып үйрене аласыз. Осы білімді алдағы уақытта жаңа программалар және веб-сайттар жасау үшін қолдана аласыз. Кез-келген компанияға осындай қызметтер қажет болғандықтан, жұмыс табу қиын болмайды. Сондай-ақ егер сіз бөгде адамға бағынғыңыз келмей, еркін жұмыс жасағыңыз келсе, онда фрилансерлік жұмыс атқара аласыз. Фрилансер дегеніміз интернеттегі түрлі тапсырыстарды белгілі бір уақытқа қабылдап, орындайтын жұмысшыларды айтамыз. Осындай тапсырыстардың қатарына веб-сайттар мен программалар жасау жатады. Басты қасиеттері: - Компьютердің нағыз маманы; - Ағылшын тілінде еркін сөйлеу; - JAVA, C++, PYTHON және т.б. программаларда еркін код жаза алу; - Логикалық өй-өрісі дамыған болу; - Күні бойы компьютер алдында отыруға дайын болу.',
                  style: TextStyle(fontSize: 12),),


                const SizedBox(height: 96,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
