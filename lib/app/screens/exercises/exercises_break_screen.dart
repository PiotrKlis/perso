import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';

class ExercisesBreakScreen extends StatelessWidget {
  const ExercisesBreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(
        title: 'break',
      ),
      backgroundColor: PersoColors.lightBlue,
      body: SizedBox(
        width: double.infinity,
        height: 550,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 176),
              child: Image.asset(
                AppImages.restIcon,
                width: Dimens.resetIconWidth,
                height: Dimens.resetIconHeight,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 48),
              child: Text(
                'Rest',
                style: TextStyle(
                  color: Color.fromRGBO(60, 60, 67, 0.60),
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                '00:39',
                style: TextStyle(color: Colors.black, fontSize: 34),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: PersoButton(
                title: '+20 sec',
              ), width: 322,
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: PersoButton(
                title: 'Stop',
                width: 322,
                whiteBlackTheme: true,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
