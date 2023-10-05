import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_client_data.freezed.dart';

@freezed
class EditableClientData with _$EditableClientData {
  const factory EditableClientData(
      {required final String imagePath,
      required final String name,
      required final String surname,
      required final String nickname,
      required final String location,
      required final String phoneNumber}) = _EditableClientData;
}
