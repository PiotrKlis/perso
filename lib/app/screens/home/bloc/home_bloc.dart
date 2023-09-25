import 'package:Perso/app/screens/home/event/home_event.dart';
import 'package:Perso/app/screens/home/state/home_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  HomeBloc(HomeState initialState) : super(initialState) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<AccountNavigation>((state, emit) async {
      UserType userType = await _userInfoProvider.getUserType();
      bool isUserLoggedIn = _userInfoProvider.isUserLoggedIn();
      if (isUserLoggedIn) {
        _navigateLoggedIn(userType, emit);
      } else {
        emit.call(const HomeState.navigateToSignIn());
      }
    });
  }

  void _navigateLoggedIn(UserType userType, Emitter<HomeState> emit) {
    if (userType == UserType.trainer) {
      emit.call(const HomeState.navigateToTrainerDetails());
    } else {
      emit.call(const HomeState.navigateToClientDetails());
    }
  }
}
