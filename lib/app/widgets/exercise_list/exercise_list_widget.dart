import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/category_chips/category_chips.dart';
import 'package:perso/app/widgets/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:perso/app/widgets/exercise_list/state/exercise_list_state.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';

class ExercisesList extends StatefulWidget {
  const ExercisesList({super.key});

  @override
  State<ExercisesList> createState() => _ExercisesListState();
}

class _ExercisesListState extends State<ExercisesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.smallMargin,
        bottom: Dimens.normalMargin,
      ),
      child: BlocBuilder<ExerciseListBloc, ExerciseListState>(
        builder: (context, state) {
          return state.when(
            exercises: (exercises) {
              return ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                proxyDecorator: (child, index, animation) =>
                    _ExercisesListDecorator(animation: animation, child: child),
                children: exercises.map<Widget>((exercise) {
                  return _Exercise(
                    key: UniqueKey(),
                    exercise: exercise,
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final items = exercises.removeAt(oldIndex);
                    exercises.insert(newIndex, items);
                    //TODO: update exercise order in database
                  });
                },
              );
            },
            error: (error) {
              return Center(
                child: Text(error),
              );
            },
            init: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}

class _ExercisesListDecorator extends StatelessWidget {
  const _ExercisesListDecorator({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _Exercise extends StatefulWidget {
  _Exercise({required this.exercise, super.key});

  final ExerciseEntity exercise;
  bool isExpanded = false;

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.smallMargin),
      //ExpansionPanelList needs to be wrapped in Column as it fixes
      //avoid RenderListBody must have unlimited space along its main axis error
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                widget.isExpanded = !widget.isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: widget.isExpanded,
                headerBuilder: (context, isExpanded) =>
                    _ExerciseHeader(exercise: widget.exercise),
                body: _ExerciseExpansionPanel(widget.exercise.videoId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExerciseExpansionPanel extends StatelessWidget {
  const _ExerciseExpansionPanel(this.videoId);

  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        const _OptionsHeader(),
        const _Options(),
        PersoVideoPlayer(
          videoId: videoId,
        ),
        const _Categories(),
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
      child: PersoCategoryChips(
        areChipsSelectable: false,
      ),
    );
  }
}

enum _ExerciseType { repsBased, timeBased }

class _Options extends StatefulWidget {
  const _Options();

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
  var _exerciseType = _ExerciseType.repsBased;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Reps based exercise'),
          value: _ExerciseType.repsBased,
          groupValue: _exerciseType,
          onChanged: (value) {
            setState(() {
              _exerciseType = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Time based exercise'),
          value: _ExerciseType.timeBased,
          groupValue: _exerciseType,
          onChanged: (value) {
            setState(() {
              _exerciseType = value!;
            });
          },
        ),
        Visibility(
          visible: _exerciseType == _ExerciseType.repsBased,
          child: const _RepsBasedExerciseOptions(),
        ),
        Visibility(
          visible: _exerciseType == _ExerciseType.timeBased,
          child: const _TimeBasedExerciseOptions(),
        ),
      ],
    );
  }
}

class _RepsBasedExerciseOptions extends StatelessWidget {
  const _RepsBasedExerciseOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.smallMargin,
        left: Dimens.smallMargin,
        right: Dimens.smallMargin,
        bottom: Dimens.normalMargin,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PersoTextField(
              textInputType: TextInputType.number,
              title: 'Sets',
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: PersoTextField(
              textInputType: TextInputType.number,
              title: 'Repetitions',
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeBasedExerciseOptions extends StatelessWidget {
  const _TimeBasedExerciseOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.smallMargin,
        left: Dimens.smallMargin,
        right: Dimens.smallMargin,
        bottom: Dimens.normalMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: PersoTextField(
              title: 'Minutes',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              ':',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          const Expanded(
            child: PersoTextField(
              title: 'Seconds',
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionsHeader extends StatelessWidget {
  const _OptionsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.smallMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Options',
            style: ThemeText.smallTitleBold,
          ),
          IconButton(
            onPressed: () {
              //remove this exercise
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
  });

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getIconForTags(exercise.tags),
      title: Text(exercise.title),
      subtitle: Text(exercise.description),
      trailing: const Icon(Icons.drag_handle),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }
}
