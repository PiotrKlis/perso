import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_trainer_data.freezed.dart';

@freezed
class EditableTrainerData with _$EditableTrainerData {
  const factory EditableTrainerData({
    required final String imagePath,
    required final List<String> languages,
    required final String name,
    required final String surname,
    required final String nickname,
    required final String location,
    required final String phoneNumber,
    required final String shortBio,
    required final String fullBio,
    required final List<String> categories
  }) = _EditableTrainerData;
}
