import 'package:perso/app/screens/home/event/home_event.dart';
import 'package:perso/app/screens/home/state/home_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/user_type.dart';
import 'package:perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(const HomeState.initial()) {
    on<AccountNavigation>((state, emit) async {
      final isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
      if (isUserLoggedIn) {
        await _navigateLoggedIn(emit);
      } else {
        emit(const HomeState.navigateToSignIn());
        emit(const HomeState.initial());
      }
    });
  }
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<void> _navigateLoggedIn(Emitter<HomeState> emit) async {
    final userType = await _userInfoProvider.getUserType();
    switch (userType) {
      case UserType.trainer:
        emit(const HomeState.navigateToTrainerProfile());
        emit(const HomeState.initial());
        break;
      case UserType.client:
        emit(const HomeState.navigateToClientProfile());
        emit(const HomeState.initial());
        break;
      case null:
        emit(const HomeState.navigateToSignIn());
        emit(const HomeState.initial());
    }
  }
}
