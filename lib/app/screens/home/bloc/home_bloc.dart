import 'package:Perso/app/screens/home/event/home_event.dart';
import 'package:Perso/app/screens/home/state/home_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  HomeBloc() : super(const HomeState.initial()) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<AccountNavigation>((state, emit) async {
      bool isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
      if (isUserLoggedIn) {
        await _navigateLoggedIn(emit);
      } else {
        emit(const HomeState.navigateToSignIn());
        emit.call(const HomeState.initial());
      }
    });
  }

  Future<void> _navigateLoggedIn(Emitter<HomeState> emit) async {
    UserType userType = await _userInfoProvider.getUserType();
    if (userType == UserType.trainer) {
      emit(const HomeState.navigateToTrainerProfile());
      emit.call(const HomeState.initial());
    } else {
      emit(const HomeState.navigateToClientProfile());
      emit.call(const HomeState.initial());
    }
  }
}
