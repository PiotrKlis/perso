import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: "exercises"),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Card(child: Text("Exercises")),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 48,
            ),
            child: Text(
              "Exercise name",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8,
            ),
            child: Text("12 reps"),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 24,
              left: 48,
              right: 48,
            ),
            child: Text(
                "Start standing with legs slightly wider than shoulder-distance Read More..."),
          ),
        ],
      ),
    );
  }
}
