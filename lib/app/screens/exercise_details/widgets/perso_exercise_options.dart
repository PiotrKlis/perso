import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_options_data.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoExerciseOptionsSection extends StatefulWidget {
  const PersoExerciseOptionsSection({super.key});

  @override
  State<PersoExerciseOptionsSection> createState() =>
      PersoExerciseOptionsSectionState();
}

class PersoExerciseOptionsSectionState
    extends State<PersoExerciseOptionsSection> {
  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    final selectedExerciseType = exerciseInheritedWidget
        .exerciseInTrainingEntity
        .exerciseEntity
        .exerciseOptionsData
        .exerciseType;
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Options',
            style: ThemeText.smallTitleBold,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: ExerciseType.values
                .map(
                  (exerciseType) => RadioListTile(
                    title: Text(exerciseType.value),
                    value: exerciseType,
                    groupValue: selectedExerciseType,
                    onChanged: (newExerciseType) {
                      if (exerciseInheritedWidget.exerciseDetailScreenType ==
                          ExerciseDetailsScreenType.client) {
                        return;
                      }
                      if (newExerciseType != selectedExerciseType) {
                        setState(() {
                          exerciseInheritedWidget
                              .updateExerciseType(newExerciseType!);
                        });
                      }
                    },
                  ),
                )
                .toList(),
          ),
          Form(
            key: exerciseInheritedWidget.optionsFormKey,
            child: _ExerciseOptionsFields(
              exerciseOptionsData: exerciseInheritedWidget
                  .exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseOptionsFields extends StatelessWidget {
  const _ExerciseOptionsFields({
    required ExerciseOptionsData exerciseOptionsData,
  }) : _exerciseOptionsData = exerciseOptionsData;

  final ExerciseOptionsData _exerciseOptionsData;

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    _updateTextControllers(_exerciseOptionsData, exerciseInheritedWidget);
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: Row(
        children: [
          Expanded(
            child: PersoTextField(
              isEnabled: exerciseInheritedWidget.exerciseDetailScreenType !=
                  ExerciseDetailsScreenType.client,
              textEditingController: exerciseInheritedWidget.setsController,
              textInputType: TextInputType.number,
              hintText: 'Sets',
              customValidator: TextFieldValidator.validateDigits,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: PersoTextField(
              isEnabled: exerciseInheritedWidget.exerciseDetailScreenType !=
                  ExerciseDetailsScreenType.client,
              textEditingController: exerciseInheritedWidget.secondController,
              textInputType: TextInputType.number,
              hintText: _getSecondFieldTitle(
                _exerciseOptionsData.exerciseType,
              ),
              customValidator: TextFieldValidator.validateDigits,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Visibility(
            visible:
                _exerciseOptionsData.exerciseType != ExerciseType.repsInReserve,
            child: Expanded(
              child: PersoTextField(
                isEnabled: exerciseInheritedWidget.exerciseDetailScreenType !=
                    ExerciseDetailsScreenType.client,
                textEditingController: exerciseInheritedWidget.thirdController,
                textInputType: TextInputType.number,
                hintText: _getThirdFieldTitle(
                  _exerciseOptionsData.exerciseType,
                ),
                customValidator: TextFieldValidator.validateDigits,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateTextControllers(
    ExerciseOptionsData optionsData,
    ExerciseInheritedWidget textEditControllers,
  ) {
    textEditControllers.setsController.text = optionsData.sets.toString();
    switch (optionsData.exerciseType) {
      case ExerciseType.timeBased:
        textEditControllers.secondController.text = optionsData.time.toString();
        textEditControllers.thirdController.text =
            optionsData.weight.toString();
        break;
      case ExerciseType.repsInReserve:
        textEditControllers.secondController.text =
            optionsData.repsInReserve.toString();
        break;
      case ExerciseType.rateOfPerceivedExertion:
        textEditControllers.secondController.text =
            optionsData.rateOfPerceivedExertion.toString();
        textEditControllers.thirdController.text =
            optionsData.weight.toString();
        break;
      case ExerciseType.maxPercentage:
        textEditControllers.secondController.text = optionsData.reps.toString();
        textEditControllers.thirdController.text =
            optionsData.maxPercentage.toString();
        break;
      case ExerciseType.repsBased:
        textEditControllers.secondController.text = optionsData.reps.toString();
        textEditControllers.thirdController.text =
            optionsData.weight.toString();
        break;
    }
  }

  String _getSecondFieldTitle(ExerciseType? exerciseType) {
    switch (exerciseType) {
      case ExerciseType.timeBased:
        return 'Time (seconds)';
      case ExerciseType.repsInReserve:
        return 'Reps in reserve';
      case ExerciseType.rateOfPerceivedExertion:
        return 'Rate of perceived exertion';
      case ExerciseType.maxPercentage:
      case ExerciseType.repsBased:
      case null:
        return 'Reps';
    }
  }

  String _getThirdFieldTitle(ExerciseType? exerciseType) {
    switch (exerciseType) {
      case ExerciseType.maxPercentage:
        return 'Max %';
      case ExerciseType.timeBased:
      case ExerciseType.repsInReserve:
      case ExerciseType.rateOfPerceivedExertion:
      case ExerciseType.repsBased:
      case null:
        return 'Weight (kg)';
    }
  }
}
