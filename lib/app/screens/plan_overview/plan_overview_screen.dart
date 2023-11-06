import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TestExercise {
  TestExercise(
      {required this.icon, required this.name, required this.description});

  final IconData icon;
  final String name;
  final String description;
}

class PlanOverviewScreen extends StatefulWidget {
  PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  @override
  State<PlanOverviewScreen> createState() => _PlanOverviewScreenState();
}

class _PlanOverviewScreenState extends State<PlanOverviewScreen> {
  final List<TestExercise> exercises = [
    TestExercise(
        icon: Icons.fitness_center,
        name: 'Exercise name 1',
        description: 'Exercise description'),
    TestExercise(
        icon: Icons.fitness_center,
        name: 'Exercise name 2',
        description: 'Exercise description'),
    TestExercise(
        icon: Icons.fitness_center,
        name: 'Exercise name 3',
        description: 'Exercise description 3'),
  ];

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
                    proxyDecorator: proxyDecorator,
                    shrinkWrap: true,
                    children: [
                      for (final exercise in exercises)
                        Container(
                          key: Key(exercise.name),
                          // margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              key: Key(exercise.name),
                              leading: Icon(exercise.icon),
                              title: Text(exercise.name),
                              subtitle: Text(exercise.description),
                              trailing: const Icon(Icons.drag_handle),
                            ),
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
