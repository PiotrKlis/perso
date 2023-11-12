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
            child: Card(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 16, top: 26,
                  ),
                    child: Text(
              "Stop",
              style: TextStyle(color: Colors.blue),
            ))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 48,
                ),
                child: Text(
                  "Exercise name",
                  style: ThemeText.bodyBoldBlackText,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 8,
                ),
                child: Text("12 reps"),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 24,
              left: Dimens.biggerMargin,
              right: Dimens.biggerMargin,
            ),
            child: Text(
                "Start standing with legs slightly wider than shoulder-distance Read More...", ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Text("<", style: TextStyle(color: Colors.black54),),
                ),
                Container(
                  margin: EdgeInsets.only(left:40, right: 40),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 40,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Text(">", style: TextStyle(color: Colors.black54),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
