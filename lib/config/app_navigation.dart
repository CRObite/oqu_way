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
import '../presentation/screens/login_page.dart';
import '../presentation/screens/navigation_screen/navigation_page.dart';
import '../presentation/screens/registration_page.dart';
import '../presentation/screens/test_screen/test_page.dart';
class AppNavigation{

  static String initR = '/news';

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
                                displayBottomCommentsCallback: (context) { _displayBottomComments(context); },
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

void _displayBottomComments(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 54,),
          Divider(color: AppColors.greyColor,),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
            child: Column(
              children: [

              ],
            ),
          )

        ],
      );
    },
  );
}
