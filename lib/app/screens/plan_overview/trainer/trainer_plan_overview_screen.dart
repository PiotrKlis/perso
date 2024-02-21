import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/perso_trainer_exercise_list.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/perso_send_exercises_section.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/perso_calendar.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class TrainerPlanOverviewScreen extends StatelessWidget {
  const TrainerPlanOverviewScreen({
    required String clientId,
    super.key,
  }) : _clientId = clientId;

  final String _clientId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
        BlocProvider(
          create: (context) => TrainerExerciseListBloc(),
        ),
      ],
      child: _TrainerPlanOverviewScreenContent(clientId: _clientId),
    );
  }
}

class _TrainerPlanOverviewScreenContent extends StatefulWidget {
  const _TrainerPlanOverviewScreenContent({
    required String clientId,
  }) : _clientId = clientId;

  final String _clientId;

  @override
  State<_TrainerPlanOverviewScreenContent> createState() =>
      _TrainerPlanOverviewScreenContentState();
}

class _TrainerPlanOverviewScreenContentState
    extends State<_TrainerPlanOverviewScreenContent> {
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Plan overview',
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            PersoCalendar(clientId: widget._clientId),
            _ExercisesOverview(clientId: widget._clientId),
          ],
        ),
      ),
      floatingActionButton: BlocListener<CalendarBloc, CalendarState>(
        listener: (BuildContext context, CalendarState state) {
          state.whenOrNull(
            selectedDate: (selectedDate) {
              _selectedDate = selectedDate;
            },
          );
        },
        child: FloatingActionButton(
          onPressed: () async {
            await context.pushNamed(
              ScreenNavigationKey.exerciseLibrary,
              queryParameters: {
                'clientId': widget._clientId,
                'date': _selectedDate,
              },
            ).then((_) {
              context.read<TrainerExerciseListBloc>().add(
                    TrainerExerciseListEvent.fetchExercises(
                      widget._clientId,
                      _selectedDate,
                    ),
                  );
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _ExercisesOverview extends StatefulWidget {
  const _ExercisesOverview({required String clientId}) : _clientId = clientId;

  final String _clientId;

  @override
  State<_ExercisesOverview> createState() => _ExercisesOverviewState();
}

class _ExercisesOverviewState extends State<_ExercisesOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: ColoredBox(
        color: PersoColors.lightBlue,
        child: Column(
          children: [
            _ExercisesHeaderRow(clientId: widget._clientId),
            Container(
              margin: const EdgeInsets.only(top: Dimens.mMargin),
              child: const PersoDivider(),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: Dimens.mMargin,
              ),
              child: PersoTrainerExerciseList(
                clientId: widget._clientId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExercisesHeaderRow extends StatefulWidget {
  const _ExercisesHeaderRow({required String clientId}) : _clientId = clientId;
  final String _clientId;

  @override
  State<_ExercisesHeaderRow> createState() => _ExercisesHeaderRowState();
}

class _ExercisesHeaderRowState extends State<_ExercisesHeaderRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.mMargin,
        right: Dimens.mMargin,
        top: Dimens.lMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Exercises',
            style: ThemeText.largeTitleBold,
          ),
          PersoSendExercisesSection(clientId: widget._clientId),
        ],
      ),
    );
  }
}
