import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_client_data.freezed.dart';

@freezed
class EditableClientData with _$EditableClientData {
  const factory EditableClientData({
    required String imagePath,
    required String name,
    required String surname,
    required String nickname,
    required List<String> languages,
  }) = _EditableClientData;
}
