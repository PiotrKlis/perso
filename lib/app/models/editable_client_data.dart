import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_client_data.freezed.dart';

@freezed
class EditableClientData with _$EditableClientData {

  const EditableClientData._();

  const factory EditableClientData({
    String? imagePath,
    String? name,
    String? surname,
    String? nickname,
  }) = _EditableClientData;

  bool isObjectComplete() =>
      name != null && surname != null && nickname != null && imagePath != null;
}
