import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTrainerNote extends StatelessWidget {
  const PersoTrainerNote({required this.trainerNote, super.key});

  final String trainerNote;

  @override
  Widget build(BuildContext context) {
    final textEditControllers = ExerciseInheritedWidget.of(context);
    textEditControllers.trainerNoteController.text = trainerNote;
    return Container(
      margin: const EdgeInsets.all(
        Dimens.mMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trainer note', style: ThemeText.smallTitleBold),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            height: 140,
            child: PersoTextField(
              title: 'Write a note for the client on the exercise...',
              isMultiLine: true,
              maxLength: 150,
              textEditingController: textEditControllers.trainerNoteController,
            ),
          ),
        ],
      ),
    );
  }
}
