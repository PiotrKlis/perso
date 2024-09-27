import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_type.dart';

part 'confirm_profile_edit_state.freezed.dart';

@freezed
class ConfirmProfileEditState with _$ConfirmProfileEditState {
  const factory ConfirmProfileEditState.initial() = Initial;

  const factory ConfirmProfileEditState.sendData() = SendData;

  const factory ConfirmProfileEditState.aggregatedData(
    EditableClientData editableClientData,
  ) = AggregatedData;

  const factory ConfirmProfileEditState.preFillData(
    (
      UserType userType,
      ProfileEntity profileEntity,
    ) userTypeProfileEntityPair,
  ) = PreFillData;

  const factory ConfirmProfileEditState.loading() = Loading;
}
