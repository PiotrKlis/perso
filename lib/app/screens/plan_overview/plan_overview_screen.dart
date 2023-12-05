import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/plan_overview/calendar_widget.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:perso/app/widgets/exercise_list/perso_exercises_list.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseListBloc(),
      child: _PlanOverviewScreenContent(clientId: clientId),
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
            const CalendarWidget(clientId: 'clientId'),
            _ExercisesOverview(clientId: clientId),
          ],
        ),
      ),
    );
  }
}

class _ExercisesOverview extends StatelessWidget {
  const _ExercisesOverview({required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: ColoredBox(
        color: PersoColors.lightBlue,
        child: Column(
          children: [
            //TODO: Add "save" button, so then data is sent to the client
            _ExercisesHeaderRow(clientId: clientId),
            const PersoExercisesList(),
          ],
        ),
      ),
    );
  }
}

class _ExercisesHeaderRow extends StatelessWidget {
  const _ExercisesHeaderRow({required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
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
            onTap: (context) => context.pushNamed(
              ScreenNavigationKey.exerciseLibrary,
              queryParameters: {'clientId': clientId},
            ),
          ),
        ],
      ),
    );
  }
}
