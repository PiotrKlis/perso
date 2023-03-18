import 'package:Perso/app/home/widgets/perso_account_icon.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/constants.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_big_header.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_clickable_text.dart';
import 'package:Perso/app/widgets/perso_header.dart';
import 'package:Perso/app/widgets/perso_search.dart';
import 'package:Perso/app/widgets/perso_trainers_list.dart';
import 'package:Perso/app/widgets/perso_trainers_search_carousel.dart';
import 'package:Perso/app/widgets/perso_training_category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const PersoAccountIcon(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.normalMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersoBigHeader(
                    title: AppLocalizations.of(context)!.home_main_header,
                  ),
                  PersoButton(
                      title:
                          AppLocalizations.of(context)!.trainers_section_button,
                      width: Dimens.smallButtonWidth)
                ]),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: Dimens.normalMargin,
                  top: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: const PersoSearch()),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.bigMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PersoHeader(
                    title: AppLocalizations.of(context)!.category_header),
                PersoClickableText(
                    title: AppLocalizations.of(context)!.see_all_categories)
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: Dimens.normalMargin, top: Dimens.bigMargin),
              child: const PersoTrainingCategoryList(
                  rowNumber: Constants.trainingCategoryShortListNumber)),
          Container(
            color: PersoColors.light_blue,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: PersoTrainersSearchCarousel()),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.bigMargin,
                      left: Dimens.normalMargin,
                      right: Dimens.normalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PersoHeader(
                          title: AppLocalizations.of(context)!.near_you),
                      PersoClickableText(
                          title:
                              AppLocalizations.of(context)!.see_all_categories)
                    ],
                  ),
                ),
                const PersoTrainersList()
              ],
            ),
          )
        ]),
      ),
    );
  }
}
