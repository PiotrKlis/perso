import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';

class ExerciseBreakScreen extends StatelessWidget {
  const ExerciseBreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: context.strings.break_header),
      backgroundColor: PersoColors.lightBlue,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xxxxlMargin,
                  ),
                  child: Image.asset(
                    AppImages.restIcon,
                    width: Dimens.mRestIconWidth,
                    height: Dimens.mRestIconHeight,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xlMargin,
                  ),
                  child: Text(
                    context.strings.rest,
                    style: ThemeText.calloutRegularGrey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xmMargin),
                  child: Text(
                    '00:39',
                    style: ThemeText.largerTitle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xlMargin,
                    left: Dimens.xxlMargin,
                    right: Dimens.xxlMargin,
                  ),
                  child: const PersoButton(
                    title: '+20 sec',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xmMargin,
                    left: Dimens.xxlMargin,
                    right: Dimens.xxlMargin,
                  ),
                  child: const PersoButton(
                    title: 'Stop',
                    whiteBlackTheme: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: Dimens.whiteBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: Dimens.mMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next 4/12',
                        style: ThemeText.calloutBoldBlueText,
                      ),
                      Text(
                        'Jumping Jacks x30',
                        style: ThemeText.bodyBoldBlackText,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: Dimens.mMargin),
                  child: Image.asset(
                    AppImages.dummyPic1,
                    width: Dimens.mRestIconWidth,
                    height: Dimens.mRestIconHeight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
