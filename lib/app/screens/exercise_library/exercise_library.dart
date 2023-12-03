import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:perso/app/widgets/exercise_list/event/exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/exercise_list_widget.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_search.dart';

class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseListBloc>(
      create: (BuildContext context) {
        return ExerciseListBloc()
          ..add(
            const ExerciseListEvent.getAllExercises(),
          );
      },
      child: const _ExerciseLibraryScreenContent(),
    );
  }
}

class _ExerciseLibraryScreenContent extends StatelessWidget {
  const _ExerciseLibraryScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Exercise library',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: Dimens.normalMargin,
                right: Dimens.normalMargin,
              ),
              child: const PersoSearch(),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              color: PersoColors.lightBlue,
              child: const ExercisesList(),
            ),
          ],
        ),
      ),
    );
  }
}
