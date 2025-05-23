import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/trainers_search_carousel/bloc/trainer_search_carousel_bloc.dart';
import 'package:perso/app/widgets/trainers_search_carousel/event/trainer_search_carousel_event.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel_card.dart';
import 'package:perso/app/widgets/trainers_search_carousel/state/trainer_search_carousel_state.dart';
import 'package:perso/core/extensions/go_router_extensions.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoTrainersSearchCarousel extends StatelessWidget {
  const PersoTrainersSearchCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getCarousel({
      required List<TrainersSearchCarouselCardData> cardsData,
    }) {
      return SizedBox(
        height: Dimens.carouselCardHeight,
        child: PageView.builder(
          itemCount: cardsData.length,
          padEnds: false,
          controller: PageController(
            viewportFraction: Dimens.carouselViewportFraction,
          ),
          itemBuilder: (context, pagePosition) {
            final isLastCard = pagePosition == cardsData.length - 1;
            return GestureDetector(
              onTap: () => _navigateToScreen(context, cardsData, pagePosition),
              child: PersoTrainersSearchCarouselCard(
                position: pagePosition,
                cardData: cardsData[pagePosition],
                isLastCard: isLastCard,
              ),
            );
          },
        ),
      );
    }

    return BlocProvider(
      create: (context) =>
          TrainerSearchCarouselBloc(const TrainerSearchCarouselState.initial()),
      child: BlocBuilder<TrainerSearchCarouselBloc, TrainerSearchCarouselState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              context
                  .read<TrainerSearchCarouselBloc>()
                  .add(const TrainerSearchCarouselEvent.loadData());
              return Container();
            },
            content: (cardsData) {
              return getCarousel(cardsData: cardsData);
            },
            error: (error) {
              return Text(error);
            },
          );
        },
      ),
    );
  }

  void _navigateToScreen(
    BuildContext context,
    List<TrainersSearchCarouselCardData> cardsData,
    int pagePosition,
  ) {
    final currentLocation = GoRouter.of(context).location;
    if (currentLocation == ScreenNavigationKey.home) {
      context.pushNamed(
        ScreenNavigationKey.searchResults,
        pathParameters: {'input': cardsData[pagePosition].title},
      );
    } else {
      context.replaceNamed(
        ScreenNavigationKey.searchResults,
        pathParameters: {'input': cardsData[pagePosition].title},
      );
    }
  }
}
