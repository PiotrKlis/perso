import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/plan_overview/client/bloc/client_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/event/client_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/client/state/client_exercise_list_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/core/extensions/date_time_extensions.dart';
import 'package:perso/core/extensions/go_router_extensions.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/navigation/navigation_config.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PersoClientExerciseList extends StatefulWidget {
  const PersoClientExerciseList({
    required this.trainerId,
    super.key,
  });

  final String trainerId;

  @override
  State<PersoClientExerciseList> createState() =>
      _PersoClientExerciseListState();
}

class _PersoClientExerciseListState extends State<PersoClientExerciseList> {
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.whenOrNull(
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
            context.read<ClientExerciseListBloc>().add(
                  ClientExerciseListEvent.getExercises(
                    trainerId: widget.trainerId,
                    date: _selectedDate,
                  ),
                );
          },
        );
      },
      child: BlocBuilder<ClientExerciseListBloc, ClientExerciseListState>(
        builder: (context, state) {
          return state.when(
            exercises: (exercises) {
              return Container(
                margin: const EdgeInsets.all(Dimens.sMargin),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: exercises.map((exercise) {
                    return _Exercise(
                      exerciseEntity: exercise,
                      clientId: widget.trainerId,
                      date: _selectedDate,
                    );
                  }).toList(),
                ),
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

class _Exercise extends StatelessWidget {
  const _Exercise({
    required ExerciseInTrainingEntity exerciseEntity,
    required String clientId,
    required String date,
  })  : _date = date,
        _clientId = clientId,
        _exerciseInTrainingEntity = exerciseEntity;

  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final String _clientId;
  final String _date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.sMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.trainerCardBorderRadius),
        child: ColoredBox(
          color: Colors.white,
          child: ListTile(
            leading:
                _getIconForTags(_exerciseInTrainingEntity.exerciseEntity.tags),
            title: Text(
              _exerciseInTrainingEntity.exerciseEntity.title,
              style: ThemeText.bodyBoldBlackText,
            ),
            subtitle: getSubtitle(
              _exerciseInTrainingEntity
                  .exerciseEntity.exerciseOptionsData.supersetName,
            ),
            onTap: () {
              context.push(
                '${goRouter.location}/${ScreenNavigationKey.exerciseDetails}/$_clientId/$_date/${ExerciseDetailsScreenType.client.name}',
                extra: _exerciseInTrainingEntity,
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

  String generateShortUuid() {
    return const Uuid().v4().replaceAll('-', '').substring(0, 20);
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
