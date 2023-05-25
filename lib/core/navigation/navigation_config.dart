import 'package:Perso/app/screens/client_in_up/client_sign_up_screen.dart';
import 'package:Perso/app/screens/home/home_screen.dart';
import 'package:Perso/app/screens/sign_in/sign_in_screen.dart';
import 'package:Perso/app/screens/trainer_sign_up/trainer_sign_up_screen.dart';
import 'package:Perso/app/screens/trainings/trainings_screen.dart';
import 'package:Perso/core/navigation/bottom_nav_bar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
    initialLocation: "${ScreenNavigationKey.home}/${ScreenNavigationKey.signIn}",
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
                  path: ScreenNavigationKey.signIn,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(child: SignInScreen());
                  },
                  routes: [
                    GoRoute(
                      path: ScreenNavigationKey.clientSignUp,
                      pageBuilder: (context, state) {
                        return const NoTransitionPage(child: ClientSignUpScreen());
                      },
                    ),
                    GoRoute(
                      path: ScreenNavigationKey.trainerSignUp,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(child: TrainerSignUpScreen());
                      },
                    ),
                  ])
            ]
          ),
          GoRoute(
            path: ScreenNavigationKey.trainings,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: TrainingScreen());
            },
          ),

        ],
      ),
    ]);
