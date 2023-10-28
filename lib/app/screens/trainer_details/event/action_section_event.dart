import 'package:freezed_annotation/freezed_annotation.dart';
part 'action_section_event.freezed.dart';

@freezed
class ActionSectionEvent with _$ActionSectionEvent {
  const factory ActionSectionEvent.shouldSectionBeVisible() =
      ShouldSectionBeVisible;
}
