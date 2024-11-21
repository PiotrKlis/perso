import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/trainer_details/event/action_section_event.dart';
import 'package:perso/app/screens/trainer_details/state/action_section_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';

class ActionSectionBloc extends Bloc<ActionSectionEvent, ActionSectionState> {

  ActionSectionBloc() : super(const ActionSectionState.initial()) {
    on<ShouldSectionBeVisible>((event, emitter) async {
      switch (_userSessionModel.profileEntity?.userType) {
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
  final _userSessionModel = getIt.get<UserSessionModel>();
}
