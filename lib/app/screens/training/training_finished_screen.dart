import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_button.dart';

class TrainingFinishedScreen extends StatelessWidget {
  const TrainingFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Congratulations on finishing your training!',
          style: ThemeText.largerTitleBold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Good job! Keep up the good work!',
          style: ThemeText.largeTitleRegular,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: PersoButton(
            onTap: (context) {
              context.pop();
            },
            title: 'Finish',
          ),
        ),
      ],
    );
  }
}
