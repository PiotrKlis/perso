import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/training_category_list/perso_training_category_list.dart';

class TrainingCategoriesScreen extends StatelessWidget {
  const TrainingCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PersoAppBar(title: context.strings.training_categories),
      body: Container(
        margin: const EdgeInsets.only(
          top: Dimens.xmMargin,
          left: Dimens.xmMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.strings.categories, style: ThemeText.largerTitleBold),
            Container(
              margin: const EdgeInsets.only(top: Dimens.lMargin),
              child: const PersoTrainingCategoryList(),
            ),
          ],
        ),
      ),
    );
  }
}
