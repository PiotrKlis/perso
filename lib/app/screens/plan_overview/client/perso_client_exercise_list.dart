import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/bloc/client_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/event/client_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/client/state/client_exercise_list_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/event/video_player_event.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';

class PersoClientExerciseList extends StatefulWidget {
  const PersoClientExerciseList({
    required this.trainerId,
    super.key,
  });

  final String trainerId;

  @override
  State<PersoClientExerciseList> createState() =>
      _PersoClientExerciseListState();
}

class _PersoClientExerciseListState extends State<PersoClientExerciseList> {
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.whenOrNull(
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
            context.read<ClientExerciseListBloc>().add(
                  ClientExerciseListEvent.getExercises(
                    trainerId: widget.trainerId,
                    date: _selectedDate,
                  ),
                );
          },
        );
      },
      child: BlocBuilder<ClientExerciseListBloc, ClientExerciseListState>(
        builder: (context, state) {
          Container();
          return state.when(
            exercises: (exercises) {
              //TODO: Sliverlist? remove shrinkwrap
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: exercises.map((exercise) {
                  return BlocProvider(
                    key: UniqueKey(),
                    create: (context) => VideoPlayerBloc(),
                    child: _Exercise(
                      exerciseEntity: exercise,
                      clientId: widget.trainerId,
                      date: _selectedDate,
                    ),
                  );
                }).toList(),
              );
            },
            error: (error) {
              return Center(
                child: Text(error),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}

class _Exercise extends StatefulWidget {
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
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = isExpanded;
                if (_isExpanded) {
                  context.read<VideoPlayerBloc>().add(
                        const VideoPlayerEvent.initialize(),
                      );
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
                  exercise: widget._exerciseEntity,
                ),
                body: _ExerciseExpansionPanel(
                  clientId: widget._clientId,
                  date: widget._date,
                  exerciseEntity: widget._exerciseEntity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExerciseExpansionPanel extends StatelessWidget {
  const _ExerciseExpansionPanel({
    required String clientId,
    required String date,
    required ExerciseEntity exerciseEntity,
  })  : _date = date,
        _clientId = clientId,
        _exerciseEntity = exerciseEntity;

  final String _clientId;
  final String _date;
  final ExerciseEntity _exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PersoDivider(),
        _DescriptionSection(
          description: _exerciseEntity.description,
          clientId: _clientId,
          date: _date,
        ),
        Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: PersoVideoPlayer(
            videoId: _exerciseEntity.videoId,
          ),
        ),
        _Categories(
          _exerciseEntity.tags,
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
    required this.clientId,
    required this.date,
  });

  final String description;
  final String clientId;
  final String date;

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
              ],
            ),
          ),
          Text(description),
        ],
      ),
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
        categories: _categories,
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
  });

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getIconForTags(exercise.tags),
      title: Text(exercise.title, style: ThemeText.bodyBoldBlackText),
      trailing: const Icon(Icons.reorder),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }
}
