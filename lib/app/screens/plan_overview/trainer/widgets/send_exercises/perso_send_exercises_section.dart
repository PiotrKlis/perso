import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/bloc/send_exercises_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/event/send_exercises_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/state/send_exercises_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/perso_button.dart';

class PersoSendExercisesSection extends StatelessWidget {
  const PersoSendExercisesSection({
    required String clientId,
    super.key,
  }) : _clientId = clientId;

  final String _clientId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendExerciseBloc(),
      child: _SendExerciseSectionContent(clientId: _clientId),
    );
  }
}

class _SendExerciseSectionContent extends StatefulWidget {
  const _SendExerciseSectionContent({required String clientId})
      : _clientId = clientId;

  final String _clientId;

  @override
  State<_SendExerciseSectionContent> createState() =>
      _SendExerciseSectionContentState();
}

class _SendExerciseSectionContentState
    extends State<_SendExerciseSectionContent> {
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.whenOrNull(
          selectedDate: (selectedDate) {
            context.read<SendExerciseBloc>().add(
                  SendExercisesEvent.getExercisesSentDate(
                    widget._clientId,
                    selectedDate,
                  ),
                );
            _selectedDate = selectedDate;
          },
        );
      },
      child: Column(
        children: [
          PersoButton(
            width: Dimens.smallButtonWidth,
            title: 'Send',
            onTap: (context) {
              context.read<SendExerciseBloc>().add(
                    SendExercisesEvent.sendExercises(
                      widget._clientId,
                      _selectedDate,
                    ),
                  );
            },
          ),
          BlocBuilder<SendExerciseBloc, SendExercisesState>(
            builder: (context, state) {
              return state.when(
                initial: Container.new,
                exerciseSentDate: (date) {
                  return Container(
                    margin: const EdgeInsets.only(top: Dimens.sMargin),
                    child: Text(
                      'Sent on $date',
                      style: ThemeText.footnoteRegular,
                    ),
                  );
                },
                error: Text.new,
              );
            },
          )
        ],
      ),
    );
  }
}
