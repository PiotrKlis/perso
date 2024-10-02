import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'editable_trainer_data.freezed.dart';

@freezed
class EditableTrainerData with _$EditableTrainerData {
  const factory EditableTrainerData({
    required String imagePath,
    required List<String> languages,
    required String name,
    required String surname,
    required String nickname,
    required String address,
    required String shortBio,
    required String fullBio,
    required List<String> categories,
    required LatLng latLng,
  }) = _EditableTrainerData;
}
