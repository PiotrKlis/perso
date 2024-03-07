import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';

class PersoExerciseTimer extends StatelessWidget {
  const PersoExerciseTimer({
    required int time,
    super.key,
  }) : _time = time;

  final int _time;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //TODO: Do timer magic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(Dimens.lMargin),
      ),
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
      ),
    );
  }
}
