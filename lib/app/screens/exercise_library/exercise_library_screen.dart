import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/bloc/library_exercise_list_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/event/library_exercise_list_event.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/perso_library_exercise_list.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/search/exercises/bloc/search_exercises_bloc.dart';
import 'package:perso/app/widgets/search/exercises/perso_exercises_search.dart';

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
    return MultiBlocProvider(providers: [
      BlocProvider<SearchExercisesBloc>(
        create: (BuildContext context) {
          return SearchExercisesBloc();
        },
      ),
      BlocProvider<LibraryExerciseListBloc>(
        create: (BuildContext context) {
          return LibraryExerciseListBloc();
        },
      ),
    ], child: _ExerciseLibraryScreenContent(_clientId, _selectedDate));
  }
}

class _ExerciseLibraryScreenContent extends StatefulWidget {
  const _ExerciseLibraryScreenContent(this._clientId, this._selectedDate);

  final String _clientId;
  final String _selectedDate;

  @override
  State<_ExerciseLibraryScreenContent> createState() =>
      _ExerciseLibraryScreenContentState();
}

class _ExerciseLibraryScreenContentState
    extends State<_ExerciseLibraryScreenContent> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LibraryExerciseListBloc>(context).add(
      LibraryExerciseListEvent.updateNumberOfAlreadyPresentExercises(
        widget._clientId,
        widget._selectedDate,
      ),
    );
  }

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
              margin: const EdgeInsets.all(Dimens.xmMargin),
              child: const PersoExercisesSearch(),
            ),
            ColoredBox(
              color: PersoColors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.sMargin,
                  bottom: Dimens.xsMargin,
                ),
                child: LibraryExerciseList(
                  clientId: widget._clientId,
                  selectedDate: widget._selectedDate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
