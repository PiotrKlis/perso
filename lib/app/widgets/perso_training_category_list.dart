import 'package:Perso/app/model/training_category/training_category.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoTrainingCategoryList extends StatelessWidget {
  const PersoTrainingCategoryList({Key? key, required this.rowNumber})
      : super(key: key);
  final int rowNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: dummyTrainingCategories
            .take(rowNumber)
            .map((category) {
              var shouldDividerBeVisible = dummyTrainingCategories.indexOf(category) != rowNumber - 1;
              return SizedBox(
                  height: Dimens.trainingCategoryRowHeight,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          category.persoCategoryIcon,
                          Container(
                              margin: const EdgeInsets.only(
                                  left: Dimens.normalMargin),
                              child: category.text)
                        ],
                      ),
                      Visibility(
                        visible: shouldDividerBeVisible,
                        child: Container(
                            margin: const EdgeInsets.only(left: Dimens.hugeMargin),
                            child: const Divider()),
                      )
                    ],
                  ),
                );
            })
            .toList());
  }
}
