import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/superset_section/bloc/superset_bloc.dart';
import 'package:perso/app/screens/exercise_details/superset_section/event/superset_event.dart';
import 'package:perso/app/screens/exercise_details/superset_section/state/superset_state.dart';

class PersoSupersetCheckbox extends StatefulWidget {
  const PersoSupersetCheckbox({
    required String exerciseInTrainingId,
    super.key,
  }) : _exerciseInTrainingId = exerciseInTrainingId;

  final String _exerciseInTrainingId;

  @override
  State<PersoSupersetCheckbox> createState() => _PersoSupersetCheckboxState();
}

class _PersoSupersetCheckboxState extends State<PersoSupersetCheckbox> {
  final _exercisesSelectedForSuperset = <String>[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupersetBloc, SupersetState>(
      builder: (BuildContext context, SupersetState state) {
        return state.whenOrNull(
          sendSuccess: (supersetData) {
            _exercisesSelectedForSuperset.clear();
            return Container();
          },
              updateCheckboxesVisibility: (shouldShowCheckbox) {
                return Visibility(
                  visible: shouldShowCheckbox,
                  child: Checkbox(
                    value: _exercisesSelectedForSuperset
                        .contains(widget._exerciseInTrainingId),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _exercisesSelectedForSuperset.add(
                            widget._exerciseInTrainingId,
                          );
                          context.read<SupersetBloc>().add(
                                SupersetEvent.addExercise(
                                  exerciseId: widget._exerciseInTrainingId,
                                ),
                              );
                        } else {
                          _exercisesSelectedForSuperset
                              .remove(widget._exerciseInTrainingId);
                          context.read<SupersetBloc>().add(
                                SupersetEvent.removeExercise(
                                  exerciseId: widget._exerciseInTrainingId,
                                ),
                              );
                        }
                      });
                    },
                  ),
                );
              },
            ) ??
            Container();
      },
    );
  }
}
