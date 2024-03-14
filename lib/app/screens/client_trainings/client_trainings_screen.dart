import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/client_trainings/bloc/client_trainings_bloc.dart';
import 'package:perso/app/screens/client_trainings/event/client_trainings_event.dart';
import 'package:perso/app/screens/client_trainings/state/client_trainings_state.dart';
import 'package:perso/app/styleguide/value/app_assets.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:perso/core/models/trainer_identity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class ClientTrainingsScreen extends StatelessWidget {
  const ClientTrainingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientTrainingBloc()..add(const LoadTrainings()),
      child: const _ClientTrainingsContent(),
    );
  }
}

class _ClientTrainingsContent extends StatelessWidget {
  const _ClientTrainingsContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.lMargin),
        child: BlocBuilder<ClientTrainingBloc, ClientTrainingState>(
          builder: (context, state) {
            return state.when(
              initial: Container.new,
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              trainings: (trainingIdentities) {
                if (trainingIdentities.isEmpty) {
                  return const _NoTrainersView();
                } else {
                  return _TrainersView(trainingIdentities);
                }
              },
              error: (error) => Center(
                child: Text(
                  error,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TrainersView extends StatelessWidget {
  const _TrainersView(this.trainerIdentities);

  final List<TrainerIdentity> trainerIdentities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: Dimens.mMargin,
            right: Dimens.mMargin,
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
            left: Dimens.mMargin,
            top: Dimens.lMargin,
          ),
          child: Text(
            'My trainers',
            style: ThemeText.mediumTitleBold,
          ),
        ),
        Expanded(
          child: Container(
            color: PersoColors.lightBlue,
            margin: const EdgeInsets.only(
              top: Dimens.mMargin,
            ),
            child: GridView.count(
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
        ),
      ],
    );
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
      margin: const EdgeInsets.only(top: Dimens.xmMargin),
      color: PersoColors.lightBlue,
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimens.xmMargin,
          bottom: Dimens.xmMargin,
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
        left: Dimens.xmMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
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
        top: Dimens.xxxlMargin,
        left: Dimens.xmMargin,
        right: Dimens.xmMargin,
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
