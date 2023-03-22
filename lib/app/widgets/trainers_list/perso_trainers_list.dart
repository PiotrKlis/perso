import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/app/utils/constants.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/trainers_list/bloc/trainers_list_bloc.dart';
import 'package:Perso/app/widgets/trainers_list/event/trainers_list_event.dart';
import 'package:Perso/app/widgets/trainers_list/state/trainers_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PersoTrainersList extends StatelessWidget {
  const PersoTrainersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TrainersListBloc(const TrainersListState.initial()),
        child: BlocBuilder<TrainersListBloc, TrainersListState>(
          builder: (context, state) {
            return state.when(initial: () {
              context
                  .read<TrainersListBloc>()
                  .add(const TrainersListEvent.loadData());
              return Container();
            }, content: (trainers) {
              return getTrainersList(trainers);
            }, error: (error) {
              return Text(error);
            });
          },
        ));
  }

  Widget getTrainersList(List<TrainerCard> trainers) {
    return Column(
      children: trainers
          .map((trainerData) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.smallMargin),
                    width: Dimens.trainerCardWidth,
                    height: Dimens.trainerCardHeight,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              Dimens.trainerCardBorderRadius)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin,
                                top: Dimens.normalMargin),
                            child: Column(
                              children: [
                                Image.asset(trainerData.icon,
                                    width: Dimens.trainerImageWidth,
                                    height: Dimens.trainerImageHeight),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: Dimens.normalMargin,
                                  left: Dimens.mediumMargin),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(trainerData.name,
                                        style: ThemeText.bodyBoldBlackText),
                                    Text(trainerData.nickname,
                                        style: ThemeText.subHeadingRegularBlue),
                                    Container(
                                      height: 40.0,
                                      margin: const EdgeInsets.only(
                                          top: Dimens.smallMargin),
                                      child: Text(
                                        trainerData.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ThemeText.subHeadingRegularGrey,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: Dimens.smallMargin),
                                      child: Row(children: [
                                        Text(trainerData.ratingScore.toString(),
                                            style:
                                                ThemeText.subHeadingBoldGrey),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: Dimens.smallerMargin),
                                          child: RatingBar(
                                            itemSize: Dimens.ratingBarSize,
                                            ignoreGestures: true,
                                            itemCount:
                                                Constants.ratingBarItemCount,
                                            ratingWidget: RatingWidget(
                                              full: const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              half: const Icon(Icons.star_half,
                                                  color: Colors.yellow),
                                              empty: const Icon(
                                                  Icons.star_rate_outlined,
                                                  color: Colors.yellow),
                                            ),
                                            initialRating:
                                                trainerData.ratingScore,
                                            onRatingUpdate: (double value) {
                                              //no-op
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: Dimens.smallerMargin),
                                          child: Text(
                                            "(${trainerData.votesNumber})",
                                            style:
                                                ThemeText.subHeadingRegularGrey,
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      ]),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
