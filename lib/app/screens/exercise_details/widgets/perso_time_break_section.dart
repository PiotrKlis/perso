import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTimeBreakSection extends StatefulWidget {
  @override
  State<PersoTimeBreakSection> createState() => _PersoTimeBreakSectionState();
}

class _PersoTimeBreakSectionState extends State<PersoTimeBreakSection> {
  bool _shouldShowTimeBreak = true;
  String _localTimeBreak = '60';

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    exerciseInheritedWidget.timeBreakController.text = _localTimeBreak;
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breaks',
            style: ThemeText.smallTitleBold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add time breaks between sets',
                style: ThemeText.bodyRegularBlackText,
              ),
              Switch(
                value: _shouldShowTimeBreak,
                onChanged: (value) {
                  setState(() {
                    _shouldShowTimeBreak = value;
                    if (!value) {
                      _localTimeBreak = '0';
                    } else {
                      _localTimeBreak = '60';
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
                isEnabled: _shouldShowTimeBreak,
                textEditingController:
                    exerciseInheritedWidget.timeBreakController,
                textInputType: TextInputType.number,
                title: 'Time break (seconds)',
                customValidator: TextFieldValidator.validateDigits,
              ),
            ),
          )
        ],
      ),
    );
  }
}
