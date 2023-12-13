import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/chat/chat_channel_screen.dart';
import 'package:perso/app/screens/chat/chat_screen.dart';
import 'package:perso/app/screens/client_profile/client_profile_screen.dart';
import 'package:perso/app/screens/client_trainings/client_trainings_screen.dart';
import 'package:perso/app/screens/exercises/exercises_break_screen.dart';
import 'package:perso/app/screens/exercise_in_progress/exercise_in_progress_screen.dart';
import 'package:perso/app/screens/exercise_library/exercise_library_screen.dart';
import 'package:perso/app/screens/forgot_password/forgot_password_screen.dart';
import 'package:perso/app/screens/home/home_screen.dart';
import 'package:perso/app/screens/logged_out_training/logged_out_trainings_screen.dart';
import 'package:perso/app/screens/plan_overview/plan_overview_screen.dart';
import 'package:perso/app/screens/profile_creation/profile_creation_screen.dart';
import 'package:perso/app/screens/profile_creation_success/profile_creation_success_screen.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_screen.dart';
import 'package:perso/app/screens/search_filters/search_filter_screen.dart';
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
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/navigation/bottom_nav_bar.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/user_type.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey = GlobalKey<NavigatorState>();
final _trainingShellNavigatorKey = GlobalKey<NavigatorState>();
final _chatShellNavigatorKey = GlobalKey<NavigatorState>();
final _userSessionModel = getIt.get<UserSessionModel>();
const _clientId = 'clientId';
const _input = 'input';

final GoRouter goRouter = GoRouter(
  initialLocation: ScreenNavigationKey.home,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeShellNavigatorKey,
          routes: [
            GoRoute(
              name: ScreenNavigationKey.home,
              path: ScreenNavigationKey.home,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: HomeScreen());
              },
              routes: [
                GoRoute(
                  name: ScreenNavigationKey.clientProfile,
                  path: ScreenNavigationKey.clientProfile,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: ClientProfileScreen());
                  },
                  routes: [

                  ]
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
                    return NoTransitionPage(
                      child: TrainerProfileScreen(),
                    );
                  },
                ),
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
                  name: ScreenNavigationKey.searchResults,
                  path: '${ScreenNavigationKey.searchResults}/:$_input',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      child: SearchResultsScreen(
                        input: state.pathParameters[_input],
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
                  name: ScreenNavigationKey.signIn,
                  path: ScreenNavigationKey.signIn,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: SignInScreen());
                  },
                  redirect: (context, state) {
                    if (_userSessionModel.isUserLoggedIn) {
                      switch (_userSessionModel.userType) {
                        case UserType.trainer:
                          return '${ScreenNavigationKey.home}/${ScreenNavigationKey.trainerProfile}';
                        case UserType.client:
                          return '${ScreenNavigationKey.home}/${ScreenNavigationKey.clientProfile}';
                        case null:
                          return null;
                      }
                    }
                    return null;
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
                        ),
                      ],
                    ),
                  ],
                ),
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
        StatefulShellBranch(
          navigatorKey: _trainingShellNavigatorKey,
          routes: [
            GoRoute(
              name: ScreenNavigationKey.loggedOutTrainings,
              path: ScreenNavigationKey.loggedOutTrainings,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: LoggedOutTrainingScreen());
              },
              redirect: (context, state) {
                if (_userSessionModel.isUserLoggedIn) {
                  switch (_userSessionModel.userType) {
                    case UserType.trainer:
                      return ScreenNavigationKey.trainerClientsList;
                    case UserType.client:
                      return ScreenNavigationKey.clientTrainings;
                    case null:
                      return null;
                  }
                }
                return null;
              },
            ),
            GoRoute(
              name: ScreenNavigationKey.clientTrainings,
              path: ScreenNavigationKey.clientTrainings,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: ClientTrainingsScreen());
              },
              redirect: (context, state) {
                if (!_userSessionModel.isUserLoggedIn) {
                  return ScreenNavigationKey.loggedOutTrainings;
                }
                return null;
              },
            ),
            GoRoute(
              name: ScreenNavigationKey.trainerClientsList,
              path: ScreenNavigationKey.trainerClientsList,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: TrainerClientsScreen());
              },
              redirect: (context, state) {
                if (!_userSessionModel.isUserLoggedIn) {
                  return ScreenNavigationKey.loggedOutTrainings;
                }
                return null;
              },
              routes: [
                GoRoute(
                  name: ScreenNavigationKey.planOverview,
                  path: ScreenNavigationKey.planOverview,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(
                      child: PlanOverviewScreen(
                        clientId: state.uri.queryParameters[_clientId]!,
                      ),
                    );
                  },
                  redirect: (context, state) {
                    if (!_userSessionModel.isUserLoggedIn) {
                      return ScreenNavigationKey.loggedOutTrainings;
                    }
                    return null;
                  },
                  routes: [
                    GoRoute(
                      name: ScreenNavigationKey.exerciseLibrary,
                      path: ScreenNavigationKey.exerciseLibrary,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return NoTransitionPage(
                          child: ExerciseLibraryScreen(
                            clientId: state.uri.queryParameters['clientId']!,
                            selectedDate: state.uri.queryParameters['date']!,
                          ),
                        );
                      },
                      redirect: (context, state) {
                        if (!_userSessionModel.isUserLoggedIn) {
                          return ScreenNavigationKey.loggedOutTrainings;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _chatShellNavigatorKey,
          routes: [
            GoRoute(
              name: ScreenNavigationKey.chat,
              path: ScreenNavigationKey.chat,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: ChatScreen());
              },
              routes: [
                GoRoute(
                  name: ScreenNavigationKey.chatChannel,
                  path: ScreenNavigationKey.chatChannel,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(
                      child: ChatChannelScreen(
                        channel: state.extra! as Channel,
                      ),
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
);
