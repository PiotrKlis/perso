import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';

class ExercisesBreakScreen extends StatelessWidget {
  const ExercisesBreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'break',
      ),
      backgroundColor: PersoColors.lightBlue,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 120,
            ),
            child: Image.asset(
              AppImages.restIcon,
              width: Dimens.restIconWidth,
              height: Dimens.restIconHeight,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 48,
            ),
            child: const Text(
              'Rest',
              style: TextStyle(
                color: Color.fromRGBO(60, 60, 67, 0.60),
                fontSize: 17,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: const Text(
              '00:39',
              style: TextStyle(color: Colors.black, fontSize: 34),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            width: 322,
            child: const PersoButton(
              title: '+20 sec',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: const PersoButton(
              title: 'Stop',
              width: 322,
              whiteBlackTheme: true,
            ),
          ),
          Container(
            color: Colors.white,
            height: 100,
            margin: const EdgeInsets.only(top: 100),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    children: [
                      const Text(
                        'Next 4/12',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Jumping Jacks x30',
                        style: ThemeText.bodyBoldBlackText,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 160),
                  child: Image.asset(
                    AppImages.dummyPic1,
                    width: 65,
                    height: 65,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
