import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/category_chips/category_chips.dart';
import 'package:perso/app/widgets/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:perso/app/widgets/exercise_list/event/exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/state/exercise_list_state.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';

class PersoExercisesList extends StatefulWidget {
  const PersoExercisesList({
    super.key,
    this.isReorderable = false,
    this.isEditable = false,
    this.isRemovable = false,
    this.isAddable = false,
    this.clientId,
    this.date,
  });

  final bool isReorderable;
  final bool isEditable;
  final bool isRemovable;
  final bool isAddable;
  final String? clientId;
  final DateTime? date;

  @override
  State<PersoExercisesList> createState() => _PersoExercisesListState();
}

class _PersoExercisesListState extends State<PersoExercisesList> {
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
                buildDefaultDragHandles: widget.isReorderable,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                proxyDecorator: (child, index, animation) =>
                    _ExercisesListDecorator(animation: animation, child: child),
                children: exercises.map<Widget>((exercise) {
                  return _Exercise(
                    key: UniqueKey(),
                    exercise: exercise,
                    isReorderable: widget.isReorderable,
                    isAddable: widget.isAddable,
                    isRemovable: widget.isRemovable,
                    isEditable: widget.isEditable,
                    clientId: widget.clientId,
                    date: widget.date,
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
  _Exercise({
    required this.exercise,
    required this.isReorderable,
    required this.isAddable,
    required this.isRemovable,
    required this.isEditable,
    required this.clientId,
    required this.date,
    super.key,
  });

  final ExerciseEntity exercise;
  final bool isReorderable;
  final bool isAddable;
  final bool isRemovable;
  final bool isEditable;
  final String? clientId;
  final DateTime? date;
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
                headerBuilder: (context, isExpanded) => _ExerciseHeader(
                  exercise: widget.exercise,
                  isReorderable: widget.isReorderable,
                ),
                body: _ExerciseExpansionPanel(
                  videoId: widget.exercise.videoId,
                  description: widget.exercise.description,
                  isRemovable: widget.isRemovable,
                  isAddable: widget.isAddable,
                  isEditable: widget.isEditable,
                  clientId: widget.clientId,
                  date: widget.date,
                  exerciseEntity: widget.exercise,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExerciseExpansionPanel extends StatelessWidget {
  const _ExerciseExpansionPanel({
    required this.videoId,
    required this.description,
    required this.isRemovable,
    required this.isAddable,
    required this.isEditable,
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final String videoId;
  final String description;
  final bool isRemovable;
  final bool isAddable;
  final bool isEditable;
  final String? clientId;
  final DateTime? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        _DescriptionSection(
          description: description,
          isRemovable: isRemovable,
          isAddable: isAddable,
          clientId: clientId,
          date: date,
          exerciseEntity: exerciseEntity,
        ),
        _OptionsSection(isEditable: isEditable),
        Container(
          margin: const EdgeInsets.only(top: Dimens.smallMargin),
          child: PersoVideoPlayer(
            videoId: videoId,
          ),
        ),
        const _Categories(),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
    required this.isRemovable,
    required this.isAddable,
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final String description;
  final bool isRemovable;
  final bool isAddable;
  final String? clientId;
  final DateTime? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.smallMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.smallMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: ThemeText.smallTitleBold,
                ),
                _ActionableIcon(
                  isRemovable: isRemovable,
                  isAddable: isAddable,
                  clientId: clientId,
                  date: date,
                  exerciseEntity: exerciseEntity,
                ),
              ],
            ),
          ),
          Text(description),
        ],
      ),
    );
  }
}

class _ActionableIcon extends StatelessWidget {
  const _ActionableIcon({
    required this.isRemovable,
    required this.isAddable,
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final bool isRemovable;
  final bool isAddable;
  final String? clientId;
  final DateTime? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    if (isRemovable) {
      return IconButton(
        icon: const Icon(
          Icons.delete_forever,
          size: 32,
        ),
        onPressed: () {
          //Add bloc logic to add exercise
        },
      );
    } else if (isAddable) {
      return IconButton(
        icon: const Icon(
          Icons.add_circle,
          size: 32,
        ),
        onPressed: () {
          //TODO: Add bloc logic to add exercise
          context.read<ExerciseListBloc>().add(
                ExerciseListEvent.addExercise(
                  clientId!,
                  date!,
                  exerciseEntity,
                ),
              );
        },
      );
    } else {
      return Container();
    }
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

class _OptionsSection extends StatefulWidget {
  const _OptionsSection({required this.isEditable});

  final bool isEditable;

  @override
  State<_OptionsSection> createState() => _OptionsSectionState();
}

class _OptionsSectionState extends State<_OptionsSection> {
  var _exerciseType = _ExerciseType.repsBased;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isEditable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.smallMargin,
              right: Dimens.smallMargin,
              top: Dimens.normalMargin,
            ),
            child: Text(
              'Options',
              style: ThemeText.smallTitleBold,
            ),
          ),
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
      ),
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
      margin: const EdgeInsets.only(
        left: Dimens.smallMargin,
        right: Dimens.smallMargin,
        top: Dimens.normalMargin,
      ),
      child: Text(
        'Options',
        style: ThemeText.smallTitleBold,
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
    required this.isReorderable,
  });

  final ExerciseEntity exercise;
  final bool isReorderable;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getIconForTags(exercise.tags),
      title: Text(exercise.title),
      trailing: _getIconForReorder(isReorderable),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }

  Icon? _getIconForReorder(bool isReorderable) {
    if (isReorderable) {
      return const Icon(Icons.reorder);
    } else {
      return null;
    }
  }
}
