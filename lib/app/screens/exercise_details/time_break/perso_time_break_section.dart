import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTimeBreakSection extends StatefulWidget {
  const PersoTimeBreakSection({
    required int? timeBreak,
    super.key,
  }) : _timeBreak = timeBreak;

  final int? _timeBreak;

  @override
  State<PersoTimeBreakSection> createState() => _PersoTimeBreakSectionState();
}

class _PersoTimeBreakSectionState extends State<PersoTimeBreakSection> {
  bool _shouldShowTimeBreak = true;
  final _timeBreakController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timeBreakController.text = widget._timeBreak.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.mMargin,
        top: Dimens.mMargin,
        right: Dimens.mMargin,
      ),
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
                  if (!value) {
                    _timeBreakController.text = '0';
                  }
                  setState(() {
                    _shouldShowTimeBreak = value;
                  });
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin),
            child: PersoTextField(
              textEditingController: _timeBreakController,
              textInputType: TextInputType.number,
              title: 'Time break (seconds)',
              customValidator: TextFieldValidator.validateDigits,
            ),
          )
        ],
      ),
    );
  }
}
