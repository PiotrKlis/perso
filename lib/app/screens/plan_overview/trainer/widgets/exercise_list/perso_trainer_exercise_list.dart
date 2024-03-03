import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/navigation/navigation_config.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoTrainerExerciseList extends StatefulWidget
    with WidgetsBindingObserver {
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
          return state.when(
            exercises: (exercises) {
              if (exercises.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.xlMargin,
                    ),
                    child: Text(
                      'No exercises for this date',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ),
                );
              } else {
                _localExercises
                  ..clear()
                  ..addAll(exercises);
                return Column(
                  children: [
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      proxyDecorator: (child, index, animation) =>
                          _ExercisesListDecorator(
                        animation: animation,
                        child: child,
                      ),
                      children: _localExercises.map((exerciseInTraining) {
                        return _Exercise(
                          key: UniqueKey(),
                          exerciseInTraining: exerciseInTraining,
                          clientId: widget.clientId,
                          date: _selectedDate,
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
                    ),
                  ],
                );
              }
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

class _Exercise extends StatelessWidget {
  const _Exercise({
    required Key key,
    required ExerciseInTrainingEntity exerciseInTraining,
    required String clientId,
    required String date,
  })  : _date = date,
        _clientId = clientId,
        _exerciseInTraining = exerciseInTraining,
        super(key: key);

  final ExerciseInTrainingEntity _exerciseInTraining;
  final String _clientId;
  final String _date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.sMargin,
        right: Dimens.sMargin,
        top: Dimens.sMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.trainerCardBorderRadius),
        child: ColoredBox(
          color: Colors.white,
          child: ListTile(
            leading: _getIconForTags(_exerciseInTraining.exerciseEntity.tags),
            title: Text(
              _exerciseInTraining.exerciseEntity.title,
              style: ThemeText.bodyBoldBlackText,
            ),
            subtitle: getSubtitle(
              _exerciseInTraining
                  .exerciseEntity.exerciseOptionsData.supersetName,
            ),
            trailing: const Icon(Icons.reorder),
            onTap: () async {
              final bloc = context.read<TrainerExerciseListBloc>();
              await context
                  .pushNamed(
                    ScreenNavigationKey.exerciseDetails,
                    queryParameters: {
                      NavigationConstants.clientId: _clientId,
                      NavigationConstants.date: _date,
                      NavigationConstants.exerciseDetailsScreenType:
                          ExerciseDetailsScreenType.trainer.name,
                    },
                    extra: _exerciseInTraining,
                  )
                  .then(
                    (value) => bloc.add(
                      TrainerExerciseListEvent.fetchExercises(
                        _clientId,
                        _date,
                      ),
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }

  Widget? getSubtitle(String? supersetName) {
    if (supersetName != null && supersetName.isNotEmpty) {
      return Text(
        supersetName,
        style: ThemeText.footnoteRegular,
      );
    } else {
      return null;
    }
  }
}
