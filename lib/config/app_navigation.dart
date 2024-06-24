import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/presentation/screens/course_screen/course_page.dart';
import 'package:oqu_way/presentation/screens/game_screen/gmae_page.dart';
import 'package:oqu_way/presentation/screens/news_screen/news_details.dart';
import 'package:oqu_way/presentation/screens/news_screen/news_page.dart';
import 'package:oqu_way/presentation/screens/shop_screen/shop_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../presentation/screens/course_screen/course_details.dart';
import '../presentation/screens/game_screen/game_result.dart';
import '../presentation/screens/game_screen/game_start_screen.dart';
import '../presentation/screens/game_screen/game_test_screen.dart';
import '../presentation/screens/login_page.dart';
import '../presentation/screens/navigation_screen/navigation_page.dart';
import '../presentation/screens/on_board_screens/onboard_page.dart';
import '../presentation/screens/profile_screen/inner_pages/profession_details.dart';
import '../presentation/screens/profile_screen/inner_pages/profession_in_universities.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_analysis.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_analysis_result.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_attends.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_comments.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_details.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_rating.dart';
import '../presentation/screens/profile_screen/inner_pages/profile_schedule.dart';
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

  static String initR = '/onboardPage';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorNews = GlobalKey<NavigatorState>(debugLabel: 'shellNews');
  static final _rootNavigatorCourse = GlobalKey<NavigatorState>(debugLabel: 'shellCourse');
  static final _rootNavigatorTest = GlobalKey<NavigatorState>(debugLabel: 'shellTest');
  static final _rootNavigatorGame = GlobalKey<NavigatorState>(debugLabel: 'shellGame');
  static final _rootNavigatorShop = GlobalKey<NavigatorState>(debugLabel: 'shellShop');

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
              builder: (context,state){
                return ProfileDetails(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: 'profileRating',
              name: 'profileRating',
              builder: (context,state){
                return ProfileRating(
                  key: state.pageKey,
                );
              },
            ),

            GoRoute(
              path: 'profileAttends',
              name: 'profileAttends',
              builder: (context,state){
                return ProfileAttends(
                  key: state.pageKey,
                );
              },
            ),

            GoRoute(
              path: 'profileUniversity',
              name: 'profileUniversity',
              builder: (context,state){
                return ProfileUniversity(
                  key: state.pageKey,
                );
              },
              routes: [

                GoRoute(
                  path: 'profileComments',
                  name: 'profileComments',
                  builder: (context,state){
                    return ProfileComments(
                      key: state.pageKey,
                    );
                  },
                ),

                GoRoute(
                  path: 'profileUniversityDetails',
                  name: 'profileUniversityDetails',
                  builder: (context,state){
                    return ProfileUniversityDetails(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'profileUniversityProfession',
                      name: 'profileUniversityProfession',
                      builder: (context,state){
                        return ProfileUniversityProfession(
                          key: state.pageKey,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'professionDetails',
                          name: 'professionDetails',
                          builder: (context,state){
                            return ProfessionDetails(
                              key: state.pageKey,
                            );
                          },
                          routes: [
                            GoRoute(
                              path: 'professionInUniversities',
                              name: 'professionInUniversities',
                              builder: (context,state){
                                return ProfessionInUniversities(
                                  key: state.pageKey,
                                );
                              },
                            ),

                          ]
                        ),


                      ]
                    ),


                  ]
                ),

              ]
            ),

            GoRoute(
              path: 'profileAnalysis',
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
                  builder: (context,state){
                    return ProfileAnalysisResult(
                      key: state.pageKey,
                    );
                  },
                ),


              ]
            ),

            GoRoute(
                path: 'profileSchedule',
                name: 'profileSchedule',
                builder: (context,state){
                  return ProfileSchedule(
                    key: state.pageKey,
                  );
                },
            ),






          ]
        ),

        GoRoute(
          path: '/testPassingPage',
          name: 'testPassingPage',
          builder: (context,state){
            return TestPassingPage(
              key: state.pageKey,
            );
          },
        ),

        GoRoute(
          path: '/testResults',
          name: 'testResults',
          builder: (context,state){
            return TestResults(
              key: state.pageKey,
            );
          },
          routes: [

            GoRoute(
              path: 'testMistakeWork',
              name: 'testMistakeWork',
              builder: (context,state){
                return TestMistakeWork(
                  key: state.pageKey,
                );
              },
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
                              return NewsDetails(
                                key: state.pageKey,
                                displayBottomCommentsCallback: (context) {  },
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
                            return CourseDetails(
                              key: state.pageKey,
                            );
                          },
                        ),
                      )
                    ]
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorGame,
                routes: [
                  GoRoute(
                    path: '/game',
                    name: 'Game',
                    builder: (context,state){
                      return GamePage(
                        key: state.pageKey,
                      );

                    },
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorTest,
                routes: [
                  GoRoute(
                    path: '/test',
                    name: 'Test',
                    builder: (context,state){
                      return TestPage(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'testSubjectSelectPage',
                        name: 'testSubjectSelectPage',
                        pageBuilder: (context, state) => SwipeablePage(
                          builder: (context){
                            return TestSubjectSelectPage(
                              key: state.pageKey,
                            );
                          },
                        ),
                      )

                    ]
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorShop,
                routes: [
                  GoRoute(
                    path: '/shop',
                    name: 'Shop',
                    builder: (context,state){
                      return ShopPage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
            ]
        )
      ]
  );
}


