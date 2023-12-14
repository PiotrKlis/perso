import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class ExercisesInProgressScreen extends StatelessWidget {
  const ExercisesInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: context.strings.exercise_in_progress),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.grey,
                  height: Dimens.xlPlaceholder,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xlMargin,
                  ),
                  child: Text(
                    'Exercise name',
                    style: ThemeText.bodyBoldBlackText,
                  ),
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
                  child:
                   Text(
                     'Start standing with legs slightly wider than shoulder-distance',
                     overflow: TextOverflow.ellipsis,
                     maxLines: 1,
                   )
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: Dimens.mMargin),
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
