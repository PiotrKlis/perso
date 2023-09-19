import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/screens/chat/chat_screen.dart';
import 'package:Perso/app/screens/client_profile/client_profile_screen.dart';
import 'package:Perso/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:Perso/app/screens/home/home_screen.dart';
import 'package:Perso/app/screens/profile_creation/profile_creation_screen.dart';
import 'package:Perso/app/screens/profile_creation_success/profile_creation_success_screen.dart';
import 'package:Perso/app/screens/profile_edit/profile_edit_screen.dart';
import 'package:Perso/app/screens/search/search_screen.dart';
import 'package:Perso/app/screens/search_filters/search_filter.dart';
import 'package:Perso/app/screens/search_results/search_results.dart';
import 'package:Perso/app/screens/sign_in/sign_in_screen.dart';
import 'package:Perso/app/screens/sign_up/sign_up_screen.dart';
import 'package:Perso/app/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:Perso/app/screens/trainer_details/trainer_details_screen.dart';
import 'package:Perso/app/screens/trainer_profile/trainer_profile_screen.dart';
import 'package:Perso/app/screens/training_categories/training_categories.dart';
import 'package:Perso/app/screens/trainings/trainings_screen.dart';
import 'package:Perso/core/navigation/bottom_nav_bar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/user_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
    initialLocation: ScreenNavigationKey.home,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            name: ScreenNavigationKey.home,
            path: ScreenNavigationKey.home,
            pageBuilder: (context, state) {
              return NoTransitionPage(child: HomeScreen());
            },
            routes: [
              GoRoute(
                name: ScreenNavigationKey.trainerDetails,
                path: ScreenNavigationKey.trainerDetails,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                      child: TrainerDetailsScreen(
                          trainerEntity: state.extra as TrainerEntity));
                },
              ),
              GoRoute(
                name: ScreenNavigationKey.search,
                path: ScreenNavigationKey.search,
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: SearchScreen());
                },
              ),
              GoRoute(
                  name: ScreenNavigationKey.searchResults,
                  path: "${ScreenNavigationKey.searchResults}/:input",
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: SearchResultsScreen(
                            input: state.pathParameters["input"]));
                  },
                  routes: [
                    GoRoute(
                      name: ScreenNavigationKey.searchFilter,
                      path: ScreenNavigationKey.searchFilter,
                      pageBuilder: (context, state) {
                        return const NoTransitionPage(
                            child: SearchFilterScreen());
                      },
                    ),
                  ]),
              GoRoute(
                name: ScreenNavigationKey.trainingCategories,
                path: ScreenNavigationKey.trainingCategories,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                      child: TrainingCategoriesScreen());
                },
              ),
              GoRoute(
                name: ScreenNavigationKey.clientProfile,
                path: ScreenNavigationKey.clientProfile,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ClientProfileScreen());
                },
              ),
              GoRoute(
                name: ScreenNavigationKey.trainerProfile,
                path: ScreenNavigationKey.trainerProfile,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: TrainerProfileScreen());
                },
              ),
              GoRoute(
                  name: ScreenNavigationKey.signIn,
                  path: ScreenNavigationKey.signIn,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: SignInScreen());
                  },
                  routes: [
                    GoRoute(
                        path: ScreenNavigationKey.passwordRecovery,
                        name: ScreenNavigationKey.passwordRecovery,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                              child: ForgotPasswordScreen());
                        }),
                    GoRoute(
                        name: ScreenNavigationKey.signUp,
                        path: ScreenNavigationKey.signUp,
                        pageBuilder: (context, state) =>
                            NoTransitionPage(child: SignUpScreen()),
                        routes: [
                          GoRoute(
                              name: ScreenNavigationKey.signUpSuccess,
                              path: ScreenNavigationKey.signUpSuccess,
                              pageBuilder: (context, state) {
                                return const NoTransitionPage(
                                    child: SignUpSuccessScreen());
                              })
                        ]),
                    GoRoute(
                        path: ScreenNavigationKey.profileCreation,
                        name: ScreenNavigationKey.profileCreation,
                        pageBuilder: (context, state) => const NoTransitionPage(
                            child: ProfileCreationScreen()),
                        routes: [
                          GoRoute(
                              path: ScreenNavigationKey.profileEdit,
                              name: ScreenNavigationKey.profileEdit,
                              pageBuilder: (context, state) => NoTransitionPage(
                                  child: ProfileEditScreen(
                                      userType: state.extra as UserType)),
                              routes: [
                                GoRoute(
                                    path: ScreenNavigationKey
                                        .profileCreationSuccess,
                                    name: ScreenNavigationKey
                                        .profileCreationSuccess,
                                    pageBuilder: (context, state) {
                                      return const NoTransitionPage(
                                          child:
                                              ProfileCreationSuccessScreen());
                                    }),
                              ])
                        ]),
                  ]),
            ],
          ),
          GoRoute(
            name: ScreenNavigationKey.trainings,
            path: ScreenNavigationKey.trainings,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: TrainingScreen());
            },
          ),
          GoRoute(
            name: ScreenNavigationKey.chat,
            path: ScreenNavigationKey.chat,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: ChatScreen());
            },
          ),
        ],
      ),
    ]);
