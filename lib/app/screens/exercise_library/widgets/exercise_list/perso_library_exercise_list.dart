import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/bloc/library_exercise_list_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/event/library_exercise_list_event.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/state/library_exercise_list_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/uuid_generator.dart';
import 'package:perso/app/widgets/search/exercises/bloc/search_exercises_bloc.dart';
import 'package:perso/app/widgets/search/exercises/state/search_exercises_state.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/navigation/navigation_config.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:uuid/uuid.dart';

class LibraryExerciseList extends StatelessWidget {
  const LibraryExerciseList({
    required String clientId,
    required String selectedDate,
    super.key,
  })  : _clientId = clientId,
        _selectedDate = selectedDate;

  final String _clientId;
  final String _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchExercisesBloc, SearchExercisesState>(
      builder: (context, state) {
        return state.when(
          exercises: (List<ExerciseEntity> exercises) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return _Exercise(
                  exerciseEntity: exercises[index],
                  clientId: _clientId,
                  date: _selectedDate,
                );
              },
            );
          },
          error: (String error) {
            return Center(
              child: Text(error),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          empty: () {
            context
                .read<LibraryExerciseListBloc>()
                .add(const LibraryExerciseListEvent.getAllLibraryExercises());
            return BlocBuilder<LibraryExerciseListBloc,
                LibraryExerciseListState>(
              builder: (context, state) {
                return state.when(
                  init: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  exercises: (List<ExerciseEntity> exercises) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        return _Exercise(
                          exerciseEntity: exercises[index],
                          clientId: _clientId,
                          date: _selectedDate,
                        );
                      },
                    );
                  },
                  error: (String error) {
                    return Center(
                      child: Text(error),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _Exercise extends StatelessWidget {
  const _Exercise({
    required ExerciseEntity exerciseEntity,
    required String clientId,
    required String date,
  })  : _date = date,
        _clientId = clientId,
        _exerciseEntity = exerciseEntity;

  final ExerciseEntity _exerciseEntity;
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
            leading: _getIconForTags(_exerciseEntity.tags),
            title: Text(
              _exerciseEntity.title,
              style: ThemeText.bodyBoldBlackText,
            ),
            subtitle: getSubtitle(
              _exerciseEntity.exerciseOptionsData.supersetName,
            ),
            trailing: const Icon(Icons.reorder),
            onTap: () {
              context.pushNamed(
                ScreenNavigationKey.exerciseDetails,
                queryParameters: {
                  NavigationConstants.clientId: _clientId,
                  NavigationConstants.date: _date,
                  NavigationConstants.exerciseDetailsScreenType:
                  ExerciseDetailsScreenType.library.name,
                },
                extra: ExerciseInTrainingEntity(
                  id: UuidGenerator.generateShortUuid(),
                  exerciseEntity: _exerciseEntity,
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
