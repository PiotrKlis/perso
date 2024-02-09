import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/state/video_player_state.dart';
import 'package:video_player/video_player.dart';

class PersoVideoPlayer extends StatefulWidget {
  const PersoVideoPlayer({required this.videoId, super.key});

  final String videoId;

  @override
  State<PersoVideoPlayer> createState() => _PersoVideoPlayerState();
}

class _PersoVideoPlayerState extends State<PersoVideoPlayer> {
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      builder: (context, state) {
        return state.when(
          init: () => const SizedBox(
            height: Dimens.videoPlayerHeight,
          ),
          start: () {
            initVideoPlayerController();
            return SizedBox(
              height: Dimens.videoPlayerHeight,
              child: FutureBuilder(
                future: _videoPlayerController?.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        _videoPlayerController!.value.isPlaying
                            ? _videoPlayerController?.pause()
                            : _videoPlayerController?.play();
                      },
                      child: VideoPlayer(
                        _videoPlayerController!,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          },
          stop: () {
            _videoPlayerController?.dispose();
            return const SizedBox(
              height: Dimens.videoPlayerHeight,
            );
          },
        );
      },
    );
  }

  void initVideoPlayerController() {
    const muxStreamBaseUrl = 'https://stream.mux.com';
    const videoExtension = 'm3u8';
    final path = '$muxStreamBaseUrl/${widget.videoId}.$videoExtension';
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        path,
      ),
    );
    _videoPlayerController?.setLooping(true);
    _videoPlayerController?.play();
  }
}
