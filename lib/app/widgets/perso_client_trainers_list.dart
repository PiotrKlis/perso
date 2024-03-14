import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/value/app_assets.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/core/models/trainer_identity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoClientTrainersList extends StatelessWidget {
  const PersoClientTrainersList(this.trainerIdentities, {super.key});

  final List<TrainerIdentity> trainerIdentities;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.xmMargin,
            right: Dimens.xmMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trainings', style: ThemeText.largerTitleBold),
              const Icon(Icons.notifications_off),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.xmMargin,
            top: Dimens.lMargin,
          ),
          child: Text(
            'My plans',
            style: ThemeText.mediumTitleBold,
          ),
        ),
        Container(
          color: PersoColors.lightBlue,
          margin: const EdgeInsets.only(
            top: Dimens.mMargin,
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 1,
            children: trainerIdentities
                .map(
                  (trainerIdentity) => GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        ScreenNavigationKey.clientPlanOverview,
                        queryParameters: {
                          'trainerId': trainerIdentity.id,
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(Dimens.xmMargin),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blue, // First color
                            Colors.greenAccent, // Second color
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              AppImages.trainer1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: Dimens.mMargin,
                              left: Dimens.mMargin,
                              right: Dimens.mMargin,
                            ),
                            child: Text(
                              '${trainerIdentity.name} ${trainerIdentity.surname}',
                              style: ThemeText.largeTitleBold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: Dimens.sMargin,
                            ),
                            child: Text(
                              '@${trainerIdentity.nickname}',
                              style: ThemeText.bodyBoldGreyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
