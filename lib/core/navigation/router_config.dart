import 'package:Perso/app/screens/home/home_screen.dart';
import 'package:Perso/app/screens/sign_in/sign_in_screen.dart';
import 'package:Perso/app/screens/sign_up/trainer_sign_up_screen.dart';
import 'package:Perso/app/screens/trainings/trainings_screen.dart';
import 'package:Perso/core/navigation/bottom_nav_bar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ScreenNavigationKey.signUp,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: ScreenNavigationKey.signUp,
        builder: (context, state) => SignUpScreen(),
      )
      // ShellRoute(
      //     navigatorKey: _shellNavigatorKey,
      //     builder: (context, state, child) {
      //       return ScaffoldWithBottomNavBar(child: child);
      //     },
      //     routes: [
      //       GoRoute(
      //           path: ScreenNavigationKey.home,
      //           pageBuilder: (context, state) => const NoTransitionPage(
      //                 child: HomeScreen(),
      //               ),
      //           routes: [
      //             GoRoute(
      //               path: ScreenNavigationKey.signIn,
      //               pageBuilder: (context, state) => const NoTransitionPage(
      //                 child: SignInScreen(),
      //               ),
      //               routes: [
      //                 GoRoute(
      //                   path: ScreenNavigationKey.signUp,
      //                   pageBuilder: (context, state) => const NoTransitionPage(
      //                     child: SignUpScreen(),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ]),
      //       GoRoute(
      //         path: ScreenNavigationKey.trainings,
      //         pageBuilder: (context, state) => const NoTransitionPage(
      //           child: TrainingScreen(),
      //         ),
      //       ),
      //     ])
    ]);
