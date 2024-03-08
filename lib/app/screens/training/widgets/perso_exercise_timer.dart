import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoExerciseTimer extends StatefulWidget {
  const PersoExerciseTimer({
    required this.time,
    super.key,
  });

  final int time;

  @override
  State<PersoExerciseTimer> createState() => _PersoExerciseTimerState();
}

class _PersoExerciseTimerState extends State<PersoExerciseTimer> {
  Timer? _timer;
  bool _isPlaying = false;
  int _currentTime = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.time;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _toggleTimer,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(Dimens.lMargin),
            ),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: Dimens.mMargin),
          Text(
            _getParsedTime(),
            style: ThemeText.largerTitle,
          ),
        ],
      ),
    );
  }

  String _getParsedTime() {
    return '${Duration(seconds: _currentTime).inMinutes.toString().padLeft(2, '0')}:${(Duration(seconds: _currentTime).inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _toggleTimer() {
    if (_isPlaying) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_currentTime > 0) {
          setState(() {
            _currentTime--;
          });
        } else {
          timer.cancel();
        }
      });
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }
}
