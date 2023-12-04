import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class ExercisesInProgressScreen extends StatelessWidget {
  const ExercisesInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(title: 'exercises'),
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 350,
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
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text:
                    'Start standing with legs slightly wider than shoulder-distance ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: 'Read More...',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
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
                      Icons.arrow_back_ios_new,
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
                      Icons.arrow_forward_ios,
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
