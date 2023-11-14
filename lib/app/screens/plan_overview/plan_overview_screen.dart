import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:video_player/video_player.dart';

class TestExercise {
  TestExercise({
    required this.icon,
    required this.name,
    required this.description,
  });

  final IconData icon;
  final String name;
  final String description;
  bool isExpanded = false;
}

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  // @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PersoAppBar(
        title: 'Plan overview',
      ),
      body: _PlanOverviewScreenContent(),
    );
  }
}

class _PlanOverviewScreenContent extends StatelessWidget {
  const _PlanOverviewScreenContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _Calendar(),
          _ExercisesOverview(),
        ],
      ),
    );
  }
}

class _ExercisesOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: PersoColors.lightBlue,
      child: Column(
        children: [
          const _ExercisesHeaderRow(),
          Expanded(child: _ExercisesList()),
        ],
      ),
    );
  }
}

class _ExercisesList extends StatefulWidget {
  @override
  State<_ExercisesList> createState() => _ExercisesListState();
}

class _ExercisesListState extends State<_ExercisesList> {
  final List<TestExercise> exercises = [
    TestExercise(
      icon: Icons.fitness_center,
      name: 'Exercise name 1',
      description: 'Exercise description',
    ),
    TestExercise(
      icon: Icons.fitness_center,
      name: 'Exercise name 2',
      description: 'Exercise description',
    ),
    TestExercise(
      icon: Icons.fitness_center,
      name: 'Exercise name 3',
      description: 'Exercise description 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.mediumMargin),
      child: ReorderableListView(
        physics: const NeverScrollableScrollPhysics(),
        proxyDecorator: (child, index, animation) =>
            _ExercisesListDecorator(animation: animation, child: child),
        children: exercises.map<Widget>((exercise) {
          return _Exercise(
              key: PageStorageKey(UniqueKey()), exercise: exercise);
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final items = exercises.removeAt(oldIndex);
            exercises.insert(newIndex, items);
          });
        },
      ),
    );
  }
}

class _ExercisesListDecorator extends StatelessWidget {
  const _ExercisesListDecorator({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _Exercise extends StatefulWidget {
  _Exercise({required this.exercise, super.key});

  final TestExercise exercise;

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                widget.exercise.isExpanded = !widget.exercise.isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: widget.exercise.isExpanded,
                headerBuilder: (context, isExpanded) =>
                    _ExerciseHeader(exercise: widget.exercise),
                body: _ExerciseExpansionPanel(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExerciseExpansionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            'Options',
            style: ThemeText.bodyRegularBlackText,
          ),
        ),
        RadioListTile(
          title: const Text('Reps based exercise'),
          value: 'Option 1',
          groupValue: true,
          onChanged: (value) {
            //no-op
          },
        ),
        RadioListTile(
          title: const Text('Time based exercise'),
          value: 'Option 2',
          groupValue: true,
          onChanged: (value) {
            //no-op
          },
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PersoTextField(
                  textInputType: TextInputType.number,
                  title: 'Sets',
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: PersoTextField(
                  textInputType: TextInputType.number,
                  title: 'Repetitions',
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
                // width needs to be specified
                child: PersoTextField(
                  title: 'Minutes',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  ':',
                  style: ThemeText.bodyBoldBlackText,
                ),
              ),
              const SizedBox(
                width: 80,
                child: PersoTextField(
                  title: 'Seconds',
                ),
              ),
            ],
          ),
        ),
        _VideoPlayer(),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    print("Init state!!!!");
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"));

    _initializeVideoPlayerFuture = _videoPlayerController
        .initialize()
        .then((value) => _videoPlayerController.play());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height: 360,
            width: double.infinity,
            child: VideoPlayer(
              _videoPlayerController,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.exercise,
  });

  final TestExercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(exercise.icon),
      title: Text(exercise.name),
      subtitle: Text(exercise.description),
      trailing: const Icon(Icons.drag_handle),
    );
  }
}

class _ExercisesHeaderRow extends StatelessWidget {
  const _ExercisesHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.smallMargin,
        right: Dimens.smallMargin,
        top: Dimens.mediumMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Exercises',
            style: ThemeText.largeTitleBold,
          ),
          const PersoButton(
            title: 'Add',
          ),
        ],
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar();

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      showNavigationArrow: true,
      // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
      //   print(args.value);
      // },
    );
  }
}
