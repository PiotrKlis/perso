import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PersoVideoPlayer extends StatefulWidget {
  const PersoVideoPlayer({super.key});

  @override
  State<PersoVideoPlayer> createState() => _PersoVideoPlayerState();
}

class _PersoVideoPlayerState extends State<PersoVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    const muxStreamBaseUrl = 'https://stream.mux.com';
    const playbackId = 'sI4ql9Cvqt45UokrgoLMpiIOwyDkJ01f3gyMSNIKRvPI';
    const videoExtension = 'm3u8';
    const path = '$muxStreamBaseUrl/$playbackId.$videoExtension';
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        path,
      ),
    );
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
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
}
