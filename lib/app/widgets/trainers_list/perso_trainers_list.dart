import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/search/trainers/bloc/search_trainers_bloc.dart';
import 'package:perso/app/widgets/search/trainers/state/search_trainers_state.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoTrainersList extends StatelessWidget {
  const PersoTrainersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTrainersBloc, SearchTrainersState>(
      builder: (context, state) {
        return state.when(
          trainers: (trainers) {
            if (trainers.isNotEmpty) {
              return _TrainersList(trainers: trainers);
            } else {
              return const Center(
                child: Text('No trainers found for input'),
              );
            }
          },
          empty: () {
            //TODO: Add empty list
            return const _TrainersList(trainers: []);
          },
          error: (error) {
            return const Center(
              child: Text(
                'Something went wrong :(',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}

class _TrainersList extends StatelessWidget {
  const _TrainersList({required List<TrainerEntity> trainers})
      : _trainers = trainers;

  final List<TrainerEntity> _trainers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _trainers
          .map(
            (trainerData) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimens.trainerCardWidth,
                  height: Dimens.trainerCardHeight,
                  child: GestureDetector(
                    onTap: () => {
                      context.pushNamed(
                        ScreenNavigationKey.trainerDetails,
                        extra: trainerData,
                      ),
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimens.trainerCardBorderRadius,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: Dimens.mMargin,
                              top: Dimens.mMargin,
                            ),
                            child: Column(
                              children: [
                                _getImage(trainerData.imagePath),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: Dimens.mMargin,
                                left: Dimens.mMargin,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trainerData.name,
                                    style: ThemeText.bodyBoldBlackText,
                                  ),
                                  Text(
                                    trainerData.nickname,
                                    style: ThemeText.subHeadingRegularBlue,
                                  ),
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                      top: Dimens.xsMargin,
                                    ),
                                    child: Text(
                                      trainerData.shortBio,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ThemeText.subHeadingRegularGrey,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: Dimens.xsMargin,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          trainerData.rating.toString(),
                                          style: ThemeText.subHeadingBoldGrey,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: Dimens.sMargin,
                                          ),
                                          child: RatingBar(
                                            itemSize: Dimens.ratingBarSize,
                                            ignoreGestures: true,
                                            ratingWidget: RatingWidget(
                                              full: const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              half: const Icon(
                                                Icons.star_half,
                                                color: Colors.yellow,
                                              ),
                                              empty: const Icon(
                                                Icons.star_rate_outlined,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                            initialRating: trainerData.rating,
                                            onRatingUpdate: (double value) {
                                              //no-op
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: Dimens.sMargin,
                                          ),
                                          child: Text(
                                            '(${trainerData.votesNumber})',
                                            style:
                                                ThemeText.subHeadingRegularGrey,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _getImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
      );
    } else {
      return const Icon(
        Icons.account_circle_rounded,
        size: 80,
      );
    }
  }
}
