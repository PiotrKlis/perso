import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingCategoriesScreen extends StatelessWidget {
  const TrainingCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PersoAppBar(title: AppLocalizations.of(context)!.training_categories),
        body: Container(
          margin: EdgeInsets.only(
              top: Dimens.normalMargin, left: Dimens.normalMargin),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppLocalizations.of(context)!.categories, style: ThemeText.largerTitleBold),
            Container(
                margin: EdgeInsets.only(top: Dimens.bigMargin),
                child: PersoTrainingCategoryList(isShortList: false))
          ]),
        ));
  }
}
