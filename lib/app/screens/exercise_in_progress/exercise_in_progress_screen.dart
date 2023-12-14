import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
<<<<<<< HEAD:lib/app/screens/exercises/exercises_screen.dart
=======
import 'package:perso/app/utils/extension/context_extensions.dart';
>>>>>>> 395a771f2e8193c44e492f416bb9eae3f6059895:lib/app/screens/exercise_in_progress/exercise_in_progress_screen.dart
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class ExercisesInProgressScreen extends StatelessWidget {
  const ExercisesInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: context.strings.exercise_in_progress),
      body: Column(
        children: [
<<<<<<< HEAD:lib/app/screens/exercises/exercises_screen.dart
          const SizedBox(
            width: double.infinity,
            height: 350,
          ),
          PersoButton(
            title: 'BREAK',
            onTap: (context) {
              context.pushNamed(ScreenNavigationKey.exercisesBreakScreen);
            },
          ),
=======
          Container(
            color: Colors.grey,
            height: Dimens.xlPlaceholder,
          ),
>>>>>>> 395a771f2e8193c44e492f416bb9eae3f6059895:lib/app/screens/exercise_in_progress/exercise_in_progress_screen.dart
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xlMargin,
            ),
            child: Text(
              'Exercise name',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          PersoButton(
            onTap: (context) =>
                context.pushNamed(ScreenNavigationKey.exerciseBreak),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.sMargin,
            ),
            child: const Text('12 reps'),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.mMargin,
              right: Dimens.mMargin,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    'Start standing with legs slightly wider than shoulder-distance',
                style: ThemeText.bodyRegularBlackText,
                children: [
                  TextSpan(
                    text: 'Read More...',
<<<<<<< HEAD:lib/app/screens/exercises/exercises_screen.dart
                    style: TextStyle(color: Colors.blue),
=======
                    style: ThemeText.footnoteBoldBlue,
>>>>>>> 395a771f2e8193c44e492f416bb9eae3f6059895:lib/app/screens/exercise_in_progress/exercise_in_progress_screen.dart
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xxxxlMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: Dimens.xlMargin),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PersoColors.lighterGrey,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(Dimens.lMargin),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.xlMargin),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PersoColors.lighterGrey,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
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
