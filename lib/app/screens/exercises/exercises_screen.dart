import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
<<<<<<< HEAD
          const SizedBox(
            width: double.infinity,
            height: 350,
          ),
=======
 Container(
            height: 350,
            color: Colors.grey,
          ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
>>>>>>> bb722f1d4222808cb68f34a440179005585b57f4
          Container(
            margin: const EdgeInsets.only(
              top: 48,
            ),
            child: Text(
              'Exercise name',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 8,
            ),
            child: const Text('12 reps'),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 24,
              left: Dimens.normalMargin,
              right: Dimens.normalMargin,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text:
                    'Start standing with legs slightly wider than shoulder-distance',
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 40),
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
                    padding: const EdgeInsets.all(24),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
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
