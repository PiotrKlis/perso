import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/bloc/client_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/perso_client_exercise_list.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/perso_calendar.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';

class ClientPlanOverviewScreen extends StatelessWidget {
  const ClientPlanOverviewScreen({
    required String trainerId,
    super.key,
  }) : _trainerId = trainerId;

  final String _trainerId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClientExerciseListBloc()),
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
      ],
      child: _PlanOverviewScreenContent(_trainerId),
    );
  }
}

class _PlanOverviewScreenContent extends StatelessWidget {
  const _PlanOverviewScreenContent(this._trainerId);

  final String _trainerId;

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
            PersoCalendar(
              clientId: null,
              trainerId: _trainerId,
            ),
            _ExercisesOverview(
              trainerId: _trainerId,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExercisesOverview extends StatefulWidget {
  const _ExercisesOverview({required this.trainerId});

  final String trainerId;

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
            _ExercisesHeaderRow(clientId: widget.trainerId),
            PersoClientExerciseList(
              trainerId: widget.trainerId,
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
          markersData: (selectedDate) {},
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
                title: 'Start',
                onTap: (context) {
                  // context.pushNamed(
                  //   ScreenNavigationKey.exerciseLibrary,
                  //   queryParameters: {
                  //     'clientId': widget._clientId,
                  //     'date': _selectedDate,
                  //   },
                  // );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
