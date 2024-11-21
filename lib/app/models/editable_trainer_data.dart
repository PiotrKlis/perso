import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'editable_trainer_data.freezed.dart';

@freezed
class EditableTrainerData with _$EditableTrainerData {
  const factory EditableTrainerData({
    String? imagePath,
    List<String>? languages,
    String? name,
    String? surname,
    String? nickname,
    String? address,
    String? shortBio,
    String? longBio,
    List<String>? categories,
    LatLng? latLng,
  }) = _EditableTrainerData;

  const EditableTrainerData._();

  bool isObjectComplete() =>
      imagePath != null &&
      languages != null &&
      name != null &&
      surname != null &&
      nickname != null &&
      address != null &&
      shortBio != null &&
      longBio != null &&
      categories != null &&
      latLng != null;
}
