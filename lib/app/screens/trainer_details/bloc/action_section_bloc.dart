import 'package:Perso/app/screens/trainer_details/event/action_section_event.dart';
import 'package:Perso/app/screens/trainer_details/state/action_section_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionSectionBloc extends Bloc<ActionSectionEvent, ActionSectionState> {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  ActionSectionBloc() : super(const ActionSectionState.initial()) {
    on<ShouldSectionBeVisible>((event, emitter) async {
      final UserType? userType = await _userInfoProvider.getUserType();
      switch (userType) {
        case UserType.trainer:
          emitter(const ActionSectionState.sectionVisibility(false));
          break;
        case UserType.client:
          emitter(const ActionSectionState.sectionVisibility(true));
          break;
        case null:
          emitter(const ActionSectionState.sectionVisibility(true));
      }
    });
  }
}
