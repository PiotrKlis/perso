import 'package:Perso/app/models/account_type.dart';
import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:Perso/app/screens/home/home_screen.dart';
import 'package:Perso/app/screens/search/search_screen.dart';
import 'package:Perso/app/screens/search_results/search_results.dart';
import 'package:Perso/app/screens/sign_in/sign_in_screen.dart';
import 'package:Perso/app/screens/sign_up/sign_up_screen.dart';
import 'package:Perso/app/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:Perso/app/screens/trainer_details/trainer_details_screen.dart';
import 'package:Perso/app/screens/training_categories/training_categories.dart';
import 'package:Perso/app/screens/trainings/trainings_screen.dart';
import 'package:Perso/core/navigation/bottom_nav_bar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
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
              path: ScreenNavigationKey.home,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: HomeScreen());
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
                ),
                GoRoute(
                  name: ScreenNavigationKey.trainingCategories,
                  path: ScreenNavigationKey.trainingCategories,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                        child: TrainingCategoriesScreen());
                  },
                ),
                GoRoute(
                    name: ScreenNavigationKey.signIn,
                    path: ScreenNavigationKey.signIn,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: SignInScreen());
                    },
                    routes: [
                      GoRoute(
                          path: ScreenNavigationKey.passwordRecovery,
                          name: ScreenNavigationKey.passwordRecovery,
                          pageBuilder: (context, state) {
                            return const NoTransitionPage(
                                child: PasswordRecoveryScreen());
                          }),
                      GoRoute(
                          name: ScreenNavigationKey.signUp,
                          path: ScreenNavigationKey.signUp,
                          pageBuilder: (context, state) {
                            AccountType accountType =
                                state.extra as AccountType;
                            return NoTransitionPage(
                                child: SignUpScreen(accountType: accountType));
                          },
                          routes: [
                            GoRoute(
                                name: ScreenNavigationKey.signUpSuccess,
                                path: ScreenNavigationKey.signUpSuccess,
                                pageBuilder: (context, state) {
                                  return const NoTransitionPage(
                                      child: SignUpSuccessScreen());
                                })
                          ]),
                    ])
              ]),
          GoRoute(
            path: ScreenNavigationKey.trainings,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: TrainingScreen());
            },
          ),
        ],
      ),
    ]);
