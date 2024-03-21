import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/bloc/training_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/break_entity.dart';

class ExerciseBreakScreen extends StatefulWidget {
  const ExerciseBreakScreen({required this.breakEntity, super.key});

  final BreakEntity breakEntity;

  @override
  State<ExerciseBreakScreen> createState() => _ExerciseBreakScreenState();
}

class _ExerciseBreakScreenState extends State<ExerciseBreakScreen> {
  late Timer _timer;
  late Duration _breakTime;

  @override
  void initState() {
    super.initState();
    _breakTime = Duration(seconds: widget.breakEntity.breakTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_breakTime.inSeconds == 0) {
        timer.cancel();
        context
            .read<TrainingBloc>()
            .add(const TrainingEvent.nextExercise());
      } else {
        setState(() {
          _breakTime = Duration(seconds: _breakTime.inSeconds - 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: Dimens.xxxxlMargin,
                ),
                child: Image.asset(
                  AppImages.restIcon,
                  width: Dimens.mRestIconWidth,
                  height: Dimens.mRestIconHeight,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimens.xlMargin,
                ),
                child: Text(
                  context.strings.rest,
                  style: ThemeText.calloutRegularGrey,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: Dimens.xmMargin),
                child: Text(
                  '${_breakTime.inMinutes.toString().padLeft(2, '0')}:${(_breakTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: ThemeText.largerTitle,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimens.xlMargin,
                  left: Dimens.xxlMargin,
                  right: Dimens.xxlMargin,
                ),
                child: PersoButton(
                  title: '+20 sec',
                  onTap: (context) {
                    setState(() {
                      _breakTime = Duration(seconds: _breakTime.inSeconds + 20);
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimens.xmMargin,
                  left: Dimens.xxlMargin,
                  right: Dimens.xxlMargin,
                ),
                child: PersoButton(
                  title: 'Skip',
                  whiteBlackTheme: true,
                  onTap: (context) {
                    context
                        .read<TrainingBloc>()
                        .add(const TrainingEvent.nextExercise());
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: Dimens.whiteBackground,
          child: Text(
            widget.breakEntity.nextExerciseTitle,
            style: ThemeText.bodyBoldBlackText,
          ),
        ),
      ],
    );
  }
}
