import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_player_state.freezed.dart';

@freezed
class VideoPlayerState with _$VideoPlayerState {
  const factory VideoPlayerState.init() = Init;
  const factory VideoPlayerState.start() = Start;
  const factory VideoPlayerState.stop() = Stop;
}
