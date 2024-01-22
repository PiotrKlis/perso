import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/bloc/library_exercise_list_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/event/library_exercise_list_event.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/state/library_exercise_list_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/event/video_player_event.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';

class PersoLibraryExerciseList extends StatefulWidget {
  const PersoLibraryExerciseList({
    required String clientId,
    required String selectedDate,
    super.key,
  })  : _clientId = clientId,
        _selectedDate = selectedDate;

  final String _clientId;
  final String _selectedDate;

  @override
  State<PersoLibraryExerciseList> createState() =>
      _PersoLibraryExerciseListState();
}

class _PersoLibraryExerciseListState extends State<PersoLibraryExerciseList> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryExerciseListBloc>().add(
          LibraryExerciseListEvent.updateNumberOfAlreadyPresentExercises(
            widget._clientId,
            widget._selectedDate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryExerciseListBloc, LibraryExerciseListState>(
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
                return BlocProvider(
                  create: (context) => VideoPlayerBloc(),
                  child: _Exercise(
                    exercise: exercises[index],
                    clientId: widget._clientId,
                    date: widget._selectedDate,
                  ),
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
  }
}

class _Exercise extends StatefulWidget {
  const _Exercise({
    required ExerciseEntity exercise,
    required String? clientId,
    required String? date,
  })  : _exercise = exercise,
        _clientId = clientId,
        _date = date;

  final ExerciseEntity _exercise;
  final String? _clientId;
  final String? _date;

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.sMargin),
      //ExpansionPanelList needs to be wrapped in Column as it fixes
      //avoid RenderListBody must have unlimited space along its main axis error
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
            if (_isExpanded) {
              context
                  .read<VideoPlayerBloc>()
                  .add(const VideoPlayerEvent.initialize());
            } else {
              context
                  .read<VideoPlayerBloc>()
                  .add(const VideoPlayerEvent.dispose());
            }
          });
        },
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _isExpanded,
            headerBuilder: (context, isExpanded) => _ExerciseHeader(
              exercise: widget._exercise,
            ),
            body: _ExerciseExpansionPanel(
              videoId: widget._exercise.videoId,
              description: widget._exercise.description,
              clientId: widget._clientId,
              date: widget._date,
              exerciseEntity: widget._exercise,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseExpansionPanel extends StatelessWidget {
  const _ExerciseExpansionPanel({
    required String videoId,
    required String description,
    required String? clientId,
    required String? date,
    required ExerciseEntity exerciseEntity,
  })  : _videoId = videoId,
        _description = description,
        _clientId = clientId,
        _date = date,
        _exerciseEntity = exerciseEntity;

  final String _videoId;
  final String _description;
  final String? _clientId;
  final String? _date;
  final ExerciseEntity _exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        _DescriptionSection(
          description: _description,
          clientId: _clientId,
          date: _date,
          exerciseEntity: _exerciseEntity,
        ),
        Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: PersoVideoPlayer(
            videoId: _videoId,
          ),
        ),
        _Categories(_exerciseEntity.tags),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required String description,
    required String? clientId,
    required String? date,
    required ExerciseEntity exerciseEntity,
  })  : _description = description,
        _clientId = clientId,
        _date = date,
        _exerciseEntity = exerciseEntity;

  final String _description;
  final String? _clientId;
  final String? _date;
  final ExerciseEntity _exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.sMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: ThemeText.smallTitleBold,
                ),
                _ActionableIcon(
                  clientId: _clientId,
                  date: _date,
                  exerciseEntity: _exerciseEntity,
                ),
              ],
            ),
          ),
          Text(_description),
        ],
      ),
    );
  }
}

class _ActionableIcon extends StatelessWidget {
  const _ActionableIcon({
    required String? clientId,
    required String? date,
    required ExerciseEntity exerciseEntity,
  })  : _exerciseEntity = exerciseEntity,
        _date = date,
        _clientId = clientId;

  final String? _clientId;
  final String? _date;
  final ExerciseEntity _exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add_circle,
        size: 42,
      ),
      onPressed: () {
        context.read<LibraryExerciseListBloc>().add(
              LibraryExerciseListEvent.add(
                _clientId!,
                _date!,
                _exerciseEntity,
              ),
            );
        context.showSnackBar('Exercise "${_exerciseEntity.title}" added!');
      },
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories(this._categories);

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.sMargin),
      child: PersoCategoryChips(
        areChipsSelectable: false,
        selectedCategories: _categories,
        shouldHideNotSelectedChips: true,
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required ExerciseEntity exercise,
  }) : _exercise = exercise;

  final ExerciseEntity _exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getIconForTags(_exercise.tags),
      title: Text(_exercise.title, style: ThemeText.bodyBoldBlackText),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }
}
