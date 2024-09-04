import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTimeBreakSection extends StatefulWidget {
  const PersoTimeBreakSection({super.key});

  @override
  State<PersoTimeBreakSection> createState() => _PersoTimeBreakSectionState();
}

class _PersoTimeBreakSectionState extends State<PersoTimeBreakSection> {
  bool _shouldShowTimeBreak = true;

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    final timeBreakValue = exerciseInheritedWidget
        .exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData.timeBreak;
    exerciseInheritedWidget.timeBreakController.text =
        timeBreakValue.toString();
    if (timeBreakValue == 0) {
      _shouldShowTimeBreak = false;
    }
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Breaks',
            style: ThemeText.smallTitleBold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add time breaks between sets',
                style: ThemeText.bodyRegularBlackText,
              ),
              Switch(
                value: _shouldShowTimeBreak,
                onChanged: (value) {
                  if (exerciseInheritedWidget.exerciseDetailScreenType ==
                      ExerciseDetailsScreenType.client) {
                    return;
                  }
                  setState(() {
                    _shouldShowTimeBreak = value;
                    if (!value) {
                      exerciseInheritedWidget.updateTimeBreak(0);
                    } else {
                      exerciseInheritedWidget.updateTimeBreak(60);
                    }
                  });
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.mMargin,
            ),
            child: Form(
              key: exerciseInheritedWidget.breakFormKey,
              child: PersoTextField(
                isEnabled: exerciseInheritedWidget.exerciseDetailScreenType !=
                        ExerciseDetailsScreenType.client &&
                    _shouldShowTimeBreak,
                textEditingController:
                    exerciseInheritedWidget.timeBreakController,
                textInputType: TextInputType.number,
                hintText: 'Time break (seconds)',
                customValidator: TextFieldValidator.validateDigits,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
