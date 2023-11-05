import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/chat/chat_screen.dart';
import 'package:perso/app/screens/client_profile/client_profile_screen.dart';
import 'package:perso/app/screens/client_trainings/client_trainings_screen.dart';
import 'package:perso/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:perso/app/screens/home/home_screen.dart';
import 'package:perso/app/screens/logged_out_training/logged_out_trainings_screen.dart';
import 'package:perso/app/screens/plan_overview/plan_overview.dart';
import 'package:perso/app/screens/profile_creation/profile_creation_screen.dart';
import 'package:perso/app/screens/profile_creation_success/profile_creation_success_screen.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_screen.dart';
import 'package:perso/app/screens/search/search_screen.dart';
import 'package:perso/app/screens/search_filters/search_filter.dart';
import 'package:perso/app/screens/search_results/search_results.dart';
import 'package:perso/app/screens/sign_in/sign_in_screen.dart';
import 'package:perso/app/screens/sign_up/sign_up_screen.dart';
import 'package:perso/app/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:perso/app/screens/trainer_clients_list/trainer_clients_list_screen.dart';
import 'package:perso/app/screens/trainer_details/trainer_details_screen.dart';
import 'package:perso/app/screens/trainer_profile/trainer_profile_screen.dart';
import 'package:perso/app/screens/training_categories/training_categories_screen.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/bottom_nav_bar.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/user_type.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _userInfoProvider = getIt.get<UserInfoProvider>();

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
            return const NoTransitionPage(child: HomeScreen());
          },
          routes: [
            GoRoute(
              name: ScreenNavigationKey.trainerDetails,
              path: ScreenNavigationKey.trainerDetails,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: TrainerDetailsScreen(
                    trainerEntity: state.extra! as TrainerEntity,
                  ),
                );
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
              path: '${ScreenNavigationKey.searchResults}/:input',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: SearchResultsScreen(
                    input: state.pathParameters['input'],
                  ),
                );
              },
              routes: [
                GoRoute(
                  name: ScreenNavigationKey.searchFilter,
                  path: ScreenNavigationKey.searchFilter,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                      child: SearchFilterScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: ScreenNavigationKey.trainingCategories,
              path: ScreenNavigationKey.trainingCategories,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: TrainingCategoriesScreen(),
                );
              },
            ),
            GoRoute(
              name: ScreenNavigationKey.clientProfile,
              path: ScreenNavigationKey.clientProfile,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: ClientProfileScreen());
              },
            ),
            GoRoute(
              name: ScreenNavigationKey.trainerProfile,
              path: ScreenNavigationKey.trainerProfile,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: TrainerProfileScreen());
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
                      child: ForgotPasswordScreen(),
                    );
                  },
                ),
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
                          child: SignUpSuccessScreen(),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: ScreenNavigationKey.profileCreation,
                  name: ScreenNavigationKey.profileCreation,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ProfileCreationScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: ScreenNavigationKey.profileEdit,
                      name: ScreenNavigationKey.profileEdit,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ProfileEditScreen(
                          userType: state.extra! as UserType,
                        ),
                      ),
                      routes: [
                        GoRoute(
                          path: ScreenNavigationKey.profileCreationSuccess,
                          name: ScreenNavigationKey.profileCreationSuccess,
                          pageBuilder: (context, state) {
                            return const NoTransitionPage(
                              child: ProfileCreationSuccessScreen(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: ScreenNavigationKey.loggedOutTrainings,
          path: ScreenNavigationKey.loggedOutTrainings,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: LoggedOutTrainingScreen());
          },
          redirect: (context, state) async {
            final isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
            if (isUserLoggedIn) {
              final userType = await _userInfoProvider.getUserType();
              switch (userType) {
                case UserType.trainer:
                  return ScreenNavigationKey.trainerClientsList;
                case UserType.client:
                  return ScreenNavigationKey.clientTrainings;
                case null:
                  return null;
              }
            }
          },
        ),
        GoRoute(
          name: ScreenNavigationKey.clientTrainings,
          path: ScreenNavigationKey.clientTrainings,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: ClientTrainingsScreen());
          },
          routes: [
            GoRoute(
              name: ScreenNavigationKey.planOverview,
              path: '${ScreenNavigationKey.planOverview}/:clientId',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(
                  child: PlanOverviewScreen(
                    clientId: state.pathParameters['clientId']!,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: ScreenNavigationKey.trainerClientsList,
          path: ScreenNavigationKey.trainerClientsList,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: TrainerClientsScreen());
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
  ],
);
