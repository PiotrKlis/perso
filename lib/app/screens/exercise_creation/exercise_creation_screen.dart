import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/category_chips/perso_selectable_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/extensions/context_extensions.dart';

class ExerciseCreationScreen extends StatelessWidget {
  const ExerciseCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(title: 'Create new exercise'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              height: Dimens.videoPlayerHeight,
              child: ColoredBox(
                color: Colors.grey,
                child: Center(
                  child: Icon(
                    Icons.cloud_upload,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin,
              ),
              child: const PersoTextField(
                hintText: 'Title',
              ),
            ),
            Container(
              height: 140,
              margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin,
              ),
              child: const PersoTextField(
                hintText: 'Instructions',
                customValidator: TextFieldValidator.validateIsEmpty,
                isMultiLine: true,
                maxLength: 150,
                // textEditingController: shortBioController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin,
              ),
              child: const Text(
                'Categories',
                style: ThemeText.smallTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin,
              ),
              child: const PersoSelectableCategoryChips(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(
                  Dimens.mMargin,
                ),
                child: PersoButton(
                  title: context.strings.confirm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
