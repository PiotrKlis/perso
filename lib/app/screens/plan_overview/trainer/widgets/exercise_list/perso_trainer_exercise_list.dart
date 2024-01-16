import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/event/video_player_event.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class PersoTrainerExerciseList extends StatefulWidget {
  const PersoTrainerExerciseList({
    required this.clientId,
    super.key,
  });

  final String clientId;

  @override
  State<PersoTrainerExerciseList> createState() =>
      _PersoTrainerExerciseListState();
}

class _PersoTrainerExerciseListState extends State<PersoTrainerExerciseList> {
  //Needed for reordering
  final _localExercises = <ExerciseInTrainingEntity>[];
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
            context.read<TrainerExerciseListBloc>().add(
                  TrainerExerciseListEvent.activateExercisesStream(
                    widget.clientId,
                    _selectedDate,
                  ),
                );
          },
        );
      },
      child: BlocBuilder<TrainerExerciseListBloc, TrainerExerciseListState>(
        builder: (context, state) {
          Container();
          return state.when(
            exercises: (exercises) {
              _localExercises
                ..clear()
                ..addAll(exercises);
              return ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                proxyDecorator: (child, index, animation) =>
                    _ExercisesListDecorator(animation: animation, child: child),
                children: _localExercises.map((exercise) {
                  return BlocProvider(
                    key: UniqueKey(),
                    create: (context) => VideoPlayerBloc(),
                    child: _Exercise(
                      exercise: exercise.exerciseEntity,
                      clientId: widget.clientId,
                      date: _selectedDate,
                    ),
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = _localExercises.removeAt(oldIndex);
                    _localExercises.insert(newIndex, item);
                    context.read<TrainerExerciseListBloc>().add(
                          TrainerExerciseListEvent.reorder(
                            widget.clientId,
                            _selectedDate,
                            _localExercises,
                          ),
                        );
                  });
                },
              );
            },
            error: (error) {
              return Center(
                child: Text(error),
              );
            },
            loading: () {
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
  const _Exercise({
    required this.exercise,
    required this.clientId,
    required this.date,
    super.key,
  });

  final ExerciseEntity exercise;
  final String clientId;
  final String date;

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.sMargin),
      //ExpansionPanelList needs to be wrapped in Column as it fixes
      //avoid RenderListBody must have unlimited space along its main axis error
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = isExpanded;
                if (_isExpanded) {
                  context
                      .read<VideoPlayerBloc>()
                      .add(const VideoPlayerEvent.initialize());
                } else {
                  context
                      .read<VideoPlayerBloc>()
                      .add(const VideoPlayerEvent.dispose());
                }
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isExpanded,
                headerBuilder: (context, isExpanded) => _ExerciseHeader(
                  exercise: widget.exercise,
                ),
                body: _ExerciseExpansionPanel(
                  videoId: widget.exercise.videoId,
                  description: widget.exercise.description,
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
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final String videoId;
  final String description;
  final String? clientId;
  final String? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        _DescriptionSection(
          description: description,
          clientId: clientId,
          date: date,
          exerciseEntity: exerciseEntity,
        ),
        const _OptionsSection(),
        Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: PersoVideoPlayer(
            videoId: videoId,
          ),
        ),
        _Categories(exerciseEntity.tags),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final String description;
  final String? clientId;
  final String? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.sMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: ThemeText.smallTitleBold,
                ),
                _ActionableIcon(
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
    required this.clientId,
    required this.date,
    required this.exerciseEntity,
  });

  final String? clientId;
  final String? date;
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete_forever,
        size: 32,
      ),
      onPressed: () {
        //Add bloc logic to add exercise
      },
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories(this._categories);

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.sMargin),
      child: PersoCategoryChips(
        areChipsSelectable: false,
        selectedCategories: _categories,
        shouldHideNotSelectedChips: true,
      ),
    );
  }
}

enum _ExerciseType { repsBased, timeBased }

class _OptionsSection extends StatefulWidget {
  const _OptionsSection();

  @override
  State<_OptionsSection> createState() => _OptionsSectionState();
}

class _OptionsSectionState extends State<_OptionsSection> {
  var _exerciseType = _ExerciseType.repsBased;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.sMargin,
            right: Dimens.sMargin,
            top: Dimens.mMargin,
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
    );
  }
}

class _RepsBasedExerciseOptions extends StatelessWidget {
  const _RepsBasedExerciseOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.sMargin,
        left: Dimens.sMargin,
        right: Dimens.sMargin,
        bottom: Dimens.mMargin,
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
        top: Dimens.sMargin,
        left: Dimens.sMargin,
        right: Dimens.sMargin,
        bottom: Dimens.mMargin,
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

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
  });

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getIconForTags(exercise.tags),
      title: Text(exercise.title, style: ThemeText.bodyBoldBlackText),
      trailing: const Icon(Icons.reorder),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }
}
