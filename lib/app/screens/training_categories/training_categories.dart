import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:flutter/material.dart';

class TrainingCategoriesScreen extends StatelessWidget {
  const TrainingCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PersoAppBar(title: "Training categories"),
        body: Container(
          margin: EdgeInsets.only(
              top: Dimens.normalMargin, left: Dimens.normalMargin),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Categories", style: ThemeText.largerTitleBold),
            Container(
                margin: EdgeInsets.only(top: Dimens.bigMargin),
                child: PersoTrainingCategoryList(isShortList: false))
          ]),
        ));
  }
}
