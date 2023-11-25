import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';


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
      ),
      PersoButton(
        title: 'BREAK',
        onTap: (context)=>
        context.pushNamed(ScreenNavigationKey.exercisesBreakScreen),
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
          child: RichText(textAlign: TextAlign.center,
            text: TextSpan(
                text:
                "Start standing with legs slightly wider than shoulder-distance ",
                style: TextStyle(color: Colors.grey, fontSize: 15,),
                children: [
                  TextSpan(
                    text: "Read More...",
                    style: TextStyle(color: Colors.blue),
                  )
                ]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
      Container(
        margin: EdgeInsets.only(top: 70),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              margin: EdgeInsets.only(right: 40),
              child: RawMaterialButton(
              onPressed: () {},
        elevation: 2.0,
        fillColor: PersoColors.lighterGrey,
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
            ),
      RawMaterialButton(
        onPressed: () {},
        elevation: 2.0,
        fillColor: Colors.black,
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 40,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      Container(
        margin: EdgeInsets.only(left: 40),
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: PersoColors.lighterGrey,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
      ),
    ]),
    )
    ,
    ]));
  }
}
