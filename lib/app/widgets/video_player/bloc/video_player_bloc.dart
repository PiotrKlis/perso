import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/video_player/event/video_player_event.dart';
import 'package:perso/app/widgets/video_player/state/video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(const VideoPlayerState.init()) {
    on<Initialize>((event, emitter) async {
      emitter(const VideoPlayerState.start());
    });

    on<Dispose>((event, emitter) async {
      emitter(const VideoPlayerState.stop());
    });
  }
}
