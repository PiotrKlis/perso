import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/perso_calendar.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:perso/app/widgets/exercise_list/event/exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/perso_exercises_list.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen(
      {required String clientId, required String trainerId, super.key})
      : _trainerId = trainerId,
        _clientId = clientId;

  final String _clientId;
  final String _trainerId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExerciseListBloc()
            ..add(
              ExerciseListEvent.getExercises(
                _clientId,
                _trainerId,
                DateTime.now().yearMonthDayFormat,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
      ],
      child: _PlanOverviewScreenContent(clientId: _clientId),
    );
  }
}

class _PlanOverviewScreenContent extends StatelessWidget {
  const _PlanOverviewScreenContent({required this.clientId});

  final String clientId;

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
            PersoCalendar(clientId: clientId),
            _ExercisesOverview(clientId: clientId),
          ],
        ),
      ),
    );
  }
}

class _ExercisesOverview extends StatefulWidget {
  const _ExercisesOverview({required this.clientId});

  final String clientId;

  @override
  State<_ExercisesOverview> createState() => _ExercisesOverviewState();
}

class _ExercisesOverviewState extends State<_ExercisesOverview> {
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: ColoredBox(
        color: PersoColors.lightBlue,
        child: Column(
          children: [
            //TODO: Add "save" button, so then data is sent to the client
            _ExercisesHeaderRow(clientId: widget.clientId),
            BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                state.when(
                  initial: () {},
                  selectedDate: (selectedDate) {
                    _selectedDate = selectedDate;
                  },
                );
                return PersoExercisesList(
                  isReorderable: true,
                  isEditable: true,
                  isRemovable: true,
                  clientId: widget.clientId,
                  date: _selectedDate,
                );
              },
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
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (BuildContext context, CalendarState state) {
        state.when(
          initial: () {},
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
          },
        );
        return Container(
          margin: const EdgeInsets.only(
            left: Dimens.mMargin,
            right: Dimens.sMargin,
            top: Dimens.mMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercises',
                style: ThemeText.largeTitleBold,
              ),
              PersoButton(
                width: Dimens.smallButtonWidth,
                title: 'Add',
                onTap: (context) {
                  context.pushNamed(
                    ScreenNavigationKey.exerciseLibrary,
                    queryParameters: {
                      'clientId': widget._clientId,
                      'date': _selectedDate,
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
