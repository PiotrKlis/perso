import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_section_state.freezed.dart';

@freezed
class ActionSectionState with _$ActionSectionState {
  const factory ActionSectionState.initial() = Initial;

  const factory ActionSectionState.sectionVisibility(
    bool shouldSectionBeVisible,
  ) = SectionVisibility;
}
