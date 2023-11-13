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

class PlanOverviewScreen extends StatefulWidget {
  const PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  @override
  State<PlanOverviewScreen> createState() => _PlanOverviewScreenState();
}

class _PlanOverviewScreenState extends State<PlanOverviewScreen> {
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

  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(AppVideos.testVideo);
    _initializeVideoPlayerFuture = _videoPlayerController
        .initialize()
        .then((value) => _videoPlayerController.play());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Plan overview',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfDateRangePicker(
              showNavigationArrow: true,
              // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              //   print(args.value);
              // },
            ),
            ColoredBox(
              color: PersoColors.lightBlue,
              child: Column(
                children: [
                  Container(
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
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ReorderableListView(
                    physics: const NeverScrollableScrollPhysics(),
                    proxyDecorator: proxyDecorator,
                    shrinkWrap: true,
                    children: [
                      for (final exercise in exercises)
                        Container(
                          key: Key(exercise.name),
                          child: Column(
                            children: [
                              ExpansionPanelList(
                                expansionCallback:
                                    (int index, bool isExpanded) {
                                  setState(() {
                                    exercise.isExpanded = !exercise.isExpanded;
                                  });
                                },
                                children: [
                                  ExpansionPanel(
                                    canTapOnHeader: true,
                                    isExpanded: exercise.isExpanded,
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        key: Key(exercise.name),
                                        leading: Icon(exercise.icon),
                                        title: Text(exercise.name),
                                        subtitle: Text(exercise.description),
                                        trailing: const Icon(Icons.drag_handle),
                                      );
                                    },
                                    body: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Options',
                                            style:
                                                ThemeText.bodyRegularBlackText,
                                          ),
                                        ),
                                        RadioListTile(
                                          title:
                                              const Text('Reps based exercise'),
                                          value: 'Option 1',
                                          groupValue: true,
                                          onChanged: (value) {
                                            //no-op
                                          },
                                        ),
                                        RadioListTile(
                                          title:
                                              const Text('Time based exercise'),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: PersoTextField(
                                                  textInputType:
                                                      TextInputType.number,
                                                  title: 'Sets',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: PersoTextField(
                                                  textInputType:
                                                      TextInputType.number,
                                                  title: 'Repetitions',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 80,
                                                // width needs to be specified
                                                child: PersoTextField(
                                                  title: 'Minutes',
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Text(
                                                  ':',
                                                  style: ThemeText
                                                      .bodyBoldBlackText,
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
                                        FutureBuilder(
                                          future: _initializeVideoPlayerFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return AspectRatio(
                                                aspectRatio:
                                                    _videoPlayerController
                                                        .value.aspectRatio,
                                                child: VideoPlayer(
                                                  _videoPlayerController,
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                    ],
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
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
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
