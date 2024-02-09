import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/perso_trainer_exercise_options.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_divider.dart';
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
        state.whenOrNull(
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
            context.read<TrainerExerciseListBloc>().add(
                  TrainerExerciseListEvent.fetchExercises(
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
                      exerciseInTrainingEntityList: _localExercises,
                      exerciseInTrainingEntity: exercise,
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
              return const Center(child: CircularProgressIndicator());
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
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required List<ExerciseInTrainingEntity> exerciseInTrainingEntityList,
    required String clientId,
    required String date,
  })  : _date = date,
        _clientId = clientId,
        _exerciseInTrainingEntityList = exerciseInTrainingEntityList,
        _exerciseInTrainingEntity = exerciseInTrainingEntity;

  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final List<ExerciseInTrainingEntity> _exerciseInTrainingEntityList;
  final String _clientId;
  final String _date;

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
                  context.read<VideoPlayerBloc>().add(
                        const VideoPlayerEvent.initialize(),
                      );
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
                  exercise: widget._exerciseInTrainingEntity.exerciseEntity,
                ),
                body: _ExerciseExpansionPanel(
                  clientId: widget._clientId,
                  date: widget._date,
                  exerciseInTrainingEntity: widget._exerciseInTrainingEntity,
                  exerciseInTrainingEntityList:
                      widget._exerciseInTrainingEntityList,
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
    required this.clientId,
    required this.date,
    required this.exerciseInTrainingEntity,
    required this.exerciseInTrainingEntityList,
  });

  final String clientId;
  final String date;
  final ExerciseInTrainingEntity exerciseInTrainingEntity;
  final List<ExerciseInTrainingEntity> exerciseInTrainingEntityList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        _DescriptionSection(
          description: exerciseInTrainingEntity.exerciseEntity.description,
          clientId: clientId,
          date: date,
          exerciseInTrainingEntity: exerciseInTrainingEntity,
          exerciseInTrainingEntityList: exerciseInTrainingEntityList,
        ),
        PersoTrainerExerciseOptionsSection(
          clientId,
          date,
          exerciseInTrainingEntity,
        ),
        Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: PersoVideoPlayer(
            videoId: exerciseInTrainingEntity.exerciseEntity.videoId,
          ),
        ),
        _Categories(
          exerciseInTrainingEntity.exerciseEntity.tags,
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
    required this.clientId,
    required this.date,
    required this.exerciseInTrainingEntity,
    required this.exerciseInTrainingEntityList,
  });

  final String description;
  final String clientId;
  final String date;
  final ExerciseInTrainingEntity exerciseInTrainingEntity;
  final List<ExerciseInTrainingEntity> exerciseInTrainingEntityList;

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
                  exerciseInTrainingEntity: exerciseInTrainingEntity,
                  exerciseInTrainingEntityList: exerciseInTrainingEntityList,
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
    required this.exerciseInTrainingEntity,
    required this.exerciseInTrainingEntityList,
  });

  final String clientId;
  final String date;
  final ExerciseInTrainingEntity exerciseInTrainingEntity;
  final List<ExerciseInTrainingEntity> exerciseInTrainingEntityList;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete_forever,
        size: 32,
      ),
      onPressed: () {
        context.read<TrainerExerciseListBloc>().add(
              TrainerExerciseListEvent.removeExercise(
                clientId,
                date,
                exerciseInTrainingEntity,
                exerciseInTrainingEntityList,
              ),
            );
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
        categories: _categories,
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
