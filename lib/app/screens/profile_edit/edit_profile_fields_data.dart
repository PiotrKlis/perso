import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_fields_data.freezed.dart';

@freezed
class EditProfileFieldsData with _$EditProfileFieldsData {
  const factory EditProfileFieldsData({
    String? name,
    String? surname,
    String? nickname,
    // String? imagePath,
  }) = _EditProfileFieldsData;

  bool isObjectComplete() =>
      name != null && surname != null && nickname != null;
}
