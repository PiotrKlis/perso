import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTimeBreakSection extends StatefulWidget {
  const PersoTimeBreakSection({
    required int timeBreak,
    required GlobalKey<FormState> formKey,
    super.key,
  })  : _formKey = formKey,
        _timeBreak = timeBreak;

  final int _timeBreak;
  final GlobalKey<FormState> _formKey;

  @override
  State<PersoTimeBreakSection> createState() => _PersoTimeBreakSectionState();
}

class _PersoTimeBreakSectionState extends State<PersoTimeBreakSection> {
  bool _shouldShowTimeBreak = true;
  String _localTimeBreak = '60';

  @override
  void initState() {
    super.initState();
    _localTimeBreak = widget._timeBreak.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textEditControllers = ExerciseInheritedWidget.of(context);
    textEditControllers.timeBreakController.text = _localTimeBreak;
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
              key: widget._formKey,
              child: PersoTextField(
                isEnabled: _shouldShowTimeBreak,
                textEditingController: textEditControllers.timeBreakController,
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
