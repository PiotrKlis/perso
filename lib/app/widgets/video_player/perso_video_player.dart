import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:video_player/video_player.dart';

class PersoVideoPlayer extends StatefulWidget {
  const PersoVideoPlayer({required String videoId, super.key})
      : _videoId = videoId;

  final String _videoId;

  @override
  State<PersoVideoPlayer> createState() => _PersoVideoPlayerState();
}

class _PersoVideoPlayerState extends State<PersoVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    initVideoPlayerController(widget._videoId);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.videoPlayerHeight,
      child: FutureBuilder(
        future: _videoPlayerController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                _videoPlayerController.value.isPlaying
                    ? _videoPlayerController.pause()
                    : _videoPlayerController.play();
              },
              child: VideoPlayer(
                _videoPlayerController,
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
  }

  void initVideoPlayerController(String videoId) {
    const muxStreamBaseUrl = 'https://stream.mux.com';
    const videoExtension = 'm3u8';
    final path = '$muxStreamBaseUrl/$videoId.$videoExtension';
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        path,
      ),
    )
      ..setLooping(true)
      ..play();
  }
}
