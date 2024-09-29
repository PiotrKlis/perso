import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {
  const factory ImageState.initial() = Initial;

  const factory ImageState.imageFound(String url) = ImageFound;

  const factory ImageState.imageNotFound() = ImageNotFound;

  const factory ImageState.imageChosen(String path) = ImageChosen;
}
