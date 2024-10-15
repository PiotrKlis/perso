import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/bloc/library_exercise_list_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/perso_library_exercise_list.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/search/exercises/bloc/search_exercises_bloc.dart';
import 'package:perso/app/widgets/search/exercises/perso_exercises_search.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({
    required String clientId,
    required String selectedDate,
    super.key,
  })  : _selectedDate = selectedDate,
        _clientId = clientId;

  final String _clientId;
  final String _selectedDate;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return SearchExercisesBloc();
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return LibraryExerciseListBloc();
          },
        ),
      ],
      child: _ExerciseLibraryScreenContent(_clientId, _selectedDate),
    );
  }
}

class _ExerciseLibraryScreenContent extends StatelessWidget {
  const _ExerciseLibraryScreenContent(this._clientId, this._selectedDate);

  final String _clientId;
  final String _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Exercise library',
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.pushNamed(ScreenNavigationKey.exerciseCreation);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Search(),
            _SearchResults(clientId: _clientId, selectedDate: _selectedDate),
          ],
        ),
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.xmMargin),
      child: const PersoExercisesSearch(),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required String clientId,
    required String selectedDate,
  })  : _clientId = clientId,
        _selectedDate = selectedDate;

  final String _clientId;
  final String _selectedDate;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: PersoColors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimens.sMargin,
          bottom: Dimens.xsMargin,
        ),
        child: LibraryExerciseList(
          clientId: _clientId,
          selectedDate: _selectedDate,
        ),
      ),
    );
  }
}
