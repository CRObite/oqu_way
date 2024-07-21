import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/domain/comment.dart';
import 'package:oqu_way/domain/ent_test.dart';
import 'package:oqu_way/domain/specialization.dart';
import 'package:oqu_way/domain/subject.dart';
import 'package:oqu_way/presentation/screens/course_screen/course_page.dart';
import 'package:oqu_way/presentation/screens/course_screen/course_test/course_test_page.dart';
import 'package:oqu_way/presentation/screens/course_screen/course_test/course_test_result.dart';
import 'package:oqu_way/presentation/screens/game_screen/game_page.dart';
import 'package:oqu_way/presentation/screens/news_screen/news_details.dart';
import 'package:oqu_way/presentation/screens/news_screen/news_page.dart';
import 'package:oqu_way/presentation/screens/shop_screen/shop_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../presentation/screens/course_screen/course_details.dart';
import '../presentation/screens/course_screen/course_details_cubit/course_details_cubit.dart';
import '../presentation/screens/course_screen/course_homework.dart';
import '../presentation/screens/course_screen/course_homework_score.dart';
import '../presentation/screens/course_screen/course_videos.dart';
import '../presentation/screens/game_screen/game_friend_list.dart';
import '../presentation/screens/game_screen/game_result.dart';
import '../presentation/screens/game_screen/game_start_screen.dart';
import '../presentation/screens/game_screen/game_test_screen.dart';
import '../presentation/screens/login_page.dart';
import '../presentation/screens/navigation_screen/navigation_page.dart';
import '../presentation/screens/notification_page.dart';
import '../presentation/screens/on_board_screens/onboard_page.dart';
import '../presentation/screens/password_recovery_screens/password_recovery.dart';
import '../presentation/screens/profile_screen/inner_pages/profession_details.dart';
import '../presentation/screens/profile_screen/inner_pages/profession_in_universities.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_analysis.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_analysis_result.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_attends.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_comments.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_details.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_questions.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_rating.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_university.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_university_details.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_university_profession.dart';
import '../presentation/screens/profile_screen/profile_page.dart';
import '../presentation/screens/registration_page.dart';
import '../presentation/screens/test_screen/test_page.dart';
import '../presentation/screens/test_screen/test_passing_screens/test_mistake_work.dart';
import '../presentation/screens/test_screen/test_passing_screens/test_passing_page.dart';
import '../presentation/screens/test_screen/test_passing_screens/test_results.dart';
import '../presentation/screens/test_screen/test_subject_select_page.dart';
class AppNavigation{

  static bool onBoardPassed = false;

  static Future<bool> getStatus() async {
    if(await SharedPreferencesOperator.containsOnBoardStatus()){
      bool? value  = await SharedPreferencesOperator.getOnBoardStatus();
      onBoardPassed = value ?? false;
    }

    return onBoardPassed;
  }



  static String initR =  onBoardPassed ? '/loginPage' : '/onboardPage';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorNews = GlobalKey<NavigatorState>(debugLabel: 'shellNews');
  static final _rootNavigatorCourse = GlobalKey<NavigatorState>(debugLabel: 'shellCourse');
  static final _rootNavigatorTest = GlobalKey<NavigatorState>(debugLabel: 'shellTest');
  static final _rootNavigatorGame = GlobalKey<NavigatorState>(debugLabel: 'shellGame');
  static final _rootNavigatorUniversity = GlobalKey<NavigatorState>(debugLabel: 'shellUniversity');

  BuildContext? navigationContext;

  static final GoRouter router = GoRouter(
      initialLocation: initR,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[

        GoRoute(
          path: '/onboardPage',
          name: 'onboardPage',
          builder: (context,state){
            return OnboardPage(
              key: state.pageKey,
            );
          },
        ),


        GoRoute(
          path: '/loginPage',
          name: 'loginPage',
          builder: (context,state){
            return LoginPage(
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: 'passwordRecovery',
              name: 'passwordRecovery',
              builder: (context,state){
                return PasswordRecovery(
                  key: state.pageKey,
                );
              },
            ),

          ]
        ),
        GoRoute(
          path: '/registrationPage',
          name: 'registrationPage',
          builder: (context,state){
            return RegistrationPage(
              key: state.pageKey,
            );
          },
        ),

        GoRoute(
          path: '/gameStartScreen',
          name: 'gameStartScreen',
          builder: (context,state){
            return GameStartScreen(
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: 'gameTestScreen',
              name: 'gameTestScreen',
              builder: (context,state){
                return GameTestScreen(
                  key: state.pageKey,
                );
              },
            ),

            GoRoute(
              path: 'gameResult',
              name: 'gameResult',
              builder: (context,state){
                return GameResult(
                  key: state.pageKey,
                );
              },
            ),



          ]
        ),


        GoRoute(
          path: '/notificationPage',
          name: 'notificationPage',

          pageBuilder: (context, state) => SwipeablePage(
            builder: (context){
              return NotificationPage(
                key: state.pageKey,
              );
            },
          ),

        ),

        GoRoute(
          path: '/profilePage',
          name: 'profilePage',
          builder: (context,state){
            return ProfilePage(
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: 'profileDetails',
              name: 'profileDetails',

              pageBuilder: (context, state) => SwipeablePage(
                builder: (context){
                  return ProfileDetails(
                    key: state.pageKey,
                  );
                },
              ),
            ),
            GoRoute(
              path: 'profileRating',
              name: 'profileRating',
              pageBuilder: (context, state) => SwipeablePage(
                builder: (context){
                  return ProfileRating(
                    key: state.pageKey,
                  );
                },
              ),

            ),

            GoRoute(
              path: 'profileAttends',
              name: 'profileAttends',
              pageBuilder: (context, state) => SwipeablePage(
                builder: (context){
                  return ProfileAttends(
                    key: state.pageKey,
                  );
                },
              ),
            ),



            GoRoute(
              path: 'profileQuestions',
              name: 'profileQuestions',
              pageBuilder: (context, state) => SwipeablePage(
                builder: (context){
                  return ProfileQuestions(
                    key: state.pageKey,
                  );
                },
              ),

            ),

          ]
        ),

        GoRoute(
          path: '/testPassingPage',
          name: 'testPassingPage',
          builder: (context,state){

            AppTest? test;
            EntTest? entTest;
            BuildContext? context;

            if(state.extra != null){
              final extras = state.extra as Map<String, dynamic>;

              if(extras.containsKey('app_test')){
                test = extras['app_test'] as AppTest;
              }
              if(extras.containsKey('ent_test')){
                entTest = extras['ent_test'] as EntTest;
              }
              if(extras.containsKey('context')){
                context = extras['context'] as BuildContext;
              }

              if(extras.containsKey('oneSubjectPage')){
                return TestPassingPage(
                  key: state.pageKey,
                  oneSubjectPage: extras['oneSubjectPage'] as bool,
                  test: test,
                  ent: null,
                  context: context,
                );
              }else {
                return TestPassingPage(
                  key: state.pageKey,
                  test: null,
                  ent: entTest,
                  context: context,
                );
              }
            }else{
              return TestPassingPage(
                key: state.pageKey,
                test: test,
                 ent: entTest,
                context: context,
              );
            }
          },
          routes: [
            GoRoute(
              path: 'courseTestResult',
              name: 'courseTestResult',
              builder: (context,state){

                BuildContext? context;
                int? appTestId;

                if(state.extra != null){
                  final extras = state.extra as Map<String, dynamic>;
                  if(extras.containsKey('appTestId')){
                    appTestId = extras['appTestId'] as int;
                  }
                  if(extras.containsKey('context')){
                    context = extras['context'] as BuildContext;
                  }
                }

                return CourseTestResult(
                  key: state.pageKey,
                  appTestId: appTestId,
                  onClose: () {
                  },
                  context: context,
                );
              },
            ),


          ]
        ),

        GoRoute(
          path: '/testResults',
          name: 'testResults',
          builder: (context,state){

            String? testId;

            if(state.extra != null){
              final extras = state.extra as Map<String, dynamic>;
              if(extras.containsKey('testId')){
                testId = extras['testId'] as String;
              }
            }


            return TestResults(
              key: state.pageKey,
              testId: testId,
            );
          },
          routes: [

            GoRoute(
              path: 'testMistakeWork',
              name: 'testMistakeWork',
              builder: (context,state){

                EntTest? entTest;
                if(state.extra != null){
                  final extras = state.extra as Map<String, dynamic>;
                  if(extras.containsKey('test_mistake')){
                    entTest = extras['test_mistake'] as EntTest;
                  }
                }

                return TestMistakeWork(
                  key: state.pageKey,
                  ent: entTest,
                );
              },
            ),

          ]
        ),


        GoRoute(
            path: '/courseHomework',
            name: 'courseHomework',
            builder: (context,state){
              int? taskId;
              BuildContext? context;

              if(state.extra != null){
                final extras = state.extra as Map<String, dynamic>;
                if(extras.containsKey('taskId')){
                  taskId = extras['taskId'] as int;
                }
                if(extras.containsKey('context')){
                  context = extras['context'] as BuildContext;
                }
              }

              return CourseHomework(
                key: state.pageKey, taskId: taskId,
                context: context,
              );
            },
          routes: [

            GoRoute(
              path: 'courseHomeworkScore',
              name: 'courseHomeworkScore',
              builder: (context,state){
                int? taskId;

                if(state.extra != null){
                  final extras = state.extra as Map<String, dynamic>;
                  if(extras.containsKey('taskId')){
                    taskId = extras['taskId'] as int;
                  }
                }

                return CourseHomeworkScore(
                  key: state.pageKey,
                  taskId: taskId,
                );
              },
            ),

          ]
        ),

        GoRoute(
          path: '/courseTestPage',
          name: 'courseTestPage',
          builder: (context,state){

            String subjectName = '';
            int? testId;
            BuildContext? context;

            if(state.extra != null){
              final extras = state.extra as Map<String, dynamic>;
              if(extras.containsKey('subjectName')){
                subjectName = extras['subjectName'] as String;
              }
              if(extras.containsKey('testId')){
                testId = extras['testId'] as int;
              }
              if(extras.containsKey('context')){
                context = extras['context'] as BuildContext;
              }
            }

            return CourseTestPage(
              key: state.pageKey,
              subjectName: subjectName,
              testId: testId,
              context: context,
            );
          },
        ),



        GoRoute(
          path: '/gameFriendList',
          name: 'gameFriendList',
          pageBuilder: (context, state) => SwipeablePage(
            builder: (context){
              return GameFriendList(
                key: state.pageKey,
              );
            },
          ),


        ),

        GoRoute(
          path: '/profileComments',
          name: 'profileComments',
          pageBuilder: (context, state) => SwipeablePage(
            builder: (context){

              int? id;
              String? type;

              if(state.extra != null){
                final extras = state.extra as Map<String, dynamic>;
                if(extras.containsKey('id')){
                  id = extras['id'] as int;
                }
                if(extras.containsKey('type')){
                  type = extras['type'] as String;
                }
              }

              return ProfileComments(
                key: state.pageKey,
                type: type!,
                id: id!,
              );
            },
          ),

        ),

        GoRoute(
            path: '/profileUniversityDetails',
            name: 'profileUniversityDetails',
            pageBuilder: (context, state) => SwipeablePage(
              builder: (context){

                int? universityId;
                if(state.extra != null){
                  final extras = state.extra as Map<String, int>;
                  if(extras.containsKey('universityId')){
                    universityId = extras['universityId'];
                  }
                }

                return ProfileUniversityDetails(
                  key: state.pageKey,
                  universityId: universityId,
                );
              },
            ),

            routes: [
              GoRoute(
                  path: 'profileUniversityProfession',
                  name: 'profileUniversityProfession',
                  pageBuilder: (context, state) => SwipeablePage(
                    builder: (context){

                      int? universityId;
                      if(state.extra != null){
                        final extras = state.extra as Map<String, int>;
                        if(extras.containsKey('universityId')){
                          universityId = extras['universityId'];
                        }
                      }

                      return ProfileUniversityProfession(
                        key: state.pageKey,
                        universityId: universityId,
                      );
                    },
                  ),

                  routes: [
                    GoRoute(
                        path: 'professionDetails',
                        name: 'professionDetails',
                        pageBuilder: (context, state) => SwipeablePage(
                          builder: (context){
                            int? specializationId;
                            if(state.extra != null){
                              final extras = state.extra as Map<String, int>;
                              if(extras.containsKey('specializationId')){
                                specializationId = extras['specializationId'];
                              }
                            }

                            return ProfessionDetails(
                              key: state.pageKey,
                              specializationId: specializationId,
                            );
                          },
                        ),

                        routes: [
                          GoRoute(
                            path: 'professionInUniversities',
                            name: 'professionInUniversities',
                            pageBuilder: (context, state) => SwipeablePage(

                              builder: (context){

                                int? specializationId;
                                String specializationName = '';
                                List<Subject> listOfSubject = [];
                                if(state.extra != null){
                                  final extras = state.extra as Map<String, dynamic>;
                                  if(extras.containsKey('specializationId')){
                                    specializationId = extras['specializationId'] as int;
                                  }
                                  if(extras.containsKey('specializationName')){
                                    specializationName = extras['specializationName'] as String;
                                  }

                                  if(extras.containsKey('listOfSubject')){
                                    listOfSubject = extras['listOfSubject'];
                                  }
                                }

                                return ProfessionInUniversities(
                                  key: state.pageKey,
                                  specializationId: specializationId,
                                  specializationName: specializationName,
                                  listOfSubject: listOfSubject,
                                );
                              },
                            ),

                          ),

                        ]
                    ),


                  ]
              ),


            ]
        ),



        StatefulShellRoute.indexedStack(
            builder: (context,state,navigationShell){

              return NavigationPage(
                navigationShell: navigationShell,
              );
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                navigatorKey: _rootNavigatorNews,
                routes: [
                  GoRoute(
                      path: '/news',
                      name: 'News',
                      builder: (context,state){
                        return NewsPage(
                          key: state.pageKey,

                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'newsDetails',
                          name: 'newsDetails',
                          pageBuilder: (context, state) => SwipeablePage(
                            builder: (context){

                              int? newsId;
                              if(state.extra != null){
                                final extras = state.extra as Map<String, int>;
                                if(extras.containsKey('newsId')){
                                  newsId = extras['newsId'];
                                }
                              }

                              return NewsDetails(
                                key: state.pageKey,
                                newsId: newsId,
                              );
                            },
                          ),
                        )

                      ]
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorCourse,
                routes: [
                  GoRoute(
                    path: '/course',
                    name: 'Course',
                    builder: (context,state){
                      return CoursePage(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'courseDetails',
                        name: 'courseDetails',

                        pageBuilder: (context, state) => SwipeablePage(
                          builder: (context){

                            int? courseId;
                            if(state.extra != null){
                              final extras = state.extra as Map<String, int>;
                              if(extras.containsKey('courseId')){
                                courseId = extras['courseId'];
                              }
                            }

                            return CourseDetails(
                              key: state.pageKey,
                              courseId: courseId,
                            );
                          },

                        ),
                        routes: [
                          GoRoute(
                              path: 'courseVideos',
                              name: 'courseVideos',
                              pageBuilder: (context, state) => SwipeablePage(
                                builder: (context){
                                  return CourseVideos(
                                    key: state.pageKey,
                                  );
                                },

                              ),
                          )
                        ]
                      )
                    ]
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorGame,
                routes: [
                  GoRoute(
                      path: '/profileAnalysis',
                      name: 'profileAnalysis',
                      builder: (context,state){
                        return ProfileAnalysis(
                          key: state.pageKey,
                        );
                      },

                      routes: [
                        GoRoute(
                          path: 'profileAnalysisResult',
                          name: 'profileAnalysisResult',
                          pageBuilder: (context, state) => SwipeablePage(
                            builder: (context){

                              List<Specialization> listOfSpecialization = [];
                              if(state.extra != null){
                                final extras = state.extra as Map<String, dynamic>;
                                if(extras.containsKey('listOfSpecialization')){
                                  listOfSpecialization = extras['listOfSpecialization'] as List<Specialization>;
                                }
                              }

                              return ProfileAnalysisResult(
                                key: state.pageKey,
                                listOfSpecialization: listOfSpecialization,
                              );
                            },
                          ),

                        ),
                      ]
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorTest,
                routes: [
                  GoRoute(
                    path: '/testSubjectSelectPage',
                    name: 'testSubjectSelectPage',
                    builder: (context,state){
                      return TestSubjectSelectPage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorUniversity,
                routes: [
                  GoRoute(
                      path: '/profileUniversity',
                      name: 'profileUniversity',
                      builder: (context,state){
                        return ProfileUniversity(
                          key: state.pageKey,
                        );
                      },
                  ),
                ],
              ),
            ]
        )
      ]
  );
}


