import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_client_data.freezed.dart';

@freezed
class EditableClientData with _$EditableClientData {
  const factory EditableClientData({
    String? imagePath,
    String? name,
    String? surname,
    String? nickname,
  }) = _EditableClientData;

  const EditableClientData._();

  bool isObjectComplete() =>
      name != null && surname != null && nickname != null && imagePath != null;
}
