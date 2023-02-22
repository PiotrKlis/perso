import 'package:Perso/app/home/home_screen.dart';
import 'package:Perso/app/trainings/trainings_screen.dart';
import 'package:Perso/core/navigation/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'home_details',
          //     builder: (context, state) => const HomeDetailsScreen(),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/trainings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TrainingScreen(),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'training_details',
          //     builder: (context, state) => const TrainingDetailsScreen(),
          //   ),
          // ],
        ),
      ]
    )

  ],
);
