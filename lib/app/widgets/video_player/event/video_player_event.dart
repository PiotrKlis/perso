import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_player_event.freezed.dart';

@freezed
class VideoPlayerEvent with _$VideoPlayerEvent {
  const factory VideoPlayerEvent.initialize() = Initialize;
  const factory VideoPlayerEvent.dispose() = Dispose;
}
