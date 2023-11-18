import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';

class ClientTrainingsScreen extends StatelessWidget {
  const ClientTrainingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NoTrainersView();
  }
}

class _NoTrainersView extends StatelessWidget {
  const _NoTrainersView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _Image(),
            _Title(),
            _TrainerSearchCarousel(),
          ],
        ),
      ),
    );
  }
}

class _TrainerSearchCarousel extends StatelessWidget {
  const _TrainerSearchCarousel();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.normalMargin),
      color: PersoColors.lightBlue,
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimens.normalMargin,
          bottom: Dimens.normalMargin,
        ),
        child: const PersoTrainersSearchCarousel(),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.normalMargin,
        top: Dimens.bigMargin,
        right: Dimens.normalMargin,
      ),
      child: Text(
        "You have no trainers so far. Let's change that.",
        style: ThemeText.largeTitleBold,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.substantialMargin,
        left: Dimens.normalMargin,
        right: Dimens.normalMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
        child: const Image(
          image: AssetImage('assets/images/client_trainings_no_trainers.png'),
        ),
      ),
    );
  }
}
