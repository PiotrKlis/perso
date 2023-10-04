import 'package:Perso/app/screens/trainer_details/bloc/trainer_details_bloc.dart';
import 'package:Perso/app/screens/trainer_details/bloc/training_request_bloc.dart';
import 'package:Perso/app/screens/trainer_details/event/trainer_details_event.dart';
import 'package:Perso/app/screens/trainer_details/event/training_request_event.dart';
import 'package:Perso/app/screens/trainer_details/state/trainer_details_state.dart';
import 'package:Perso/app/screens/trainer_details/state/training_request_state.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/category_chips/category_chips.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/string_extensions.dart';
import 'package:Perso/core/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key, required String trainerId})
      : _trainerId = trainerId,
        super();

  final String _trainerId;

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  Set<String> _segmentSelected = Set.from({_Segments.about.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TrainerDetailsBloc(),
        child: BlocBuilder<TrainerDetailsBloc, TrainerDetailsState>(
            builder: (context, state) {
          return state.when(initial: () {
                context
                    .read<TrainerDetailsBloc>()
                    .add(TrainerDetailsEvent.loadData(widget._trainerId));
                return const Center(child: CircularProgressIndicator());
              }, content: (trainerEntity, userType) {
                return _trainerDetailsContent(trainerEntity, userType);
              }, error: (error) {
                return Text(error);
              }) ??
              const Text("Something went wrong");
        }));
  }

  Widget _trainerDetailsContent(
      TrainerEntity trainerEntity, UserType? userType) {
    return Scaffold(
      appBar: PersoAppBar(
          isTitleCentered: true, title: "@${trainerEntity.nickname}"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin,
                      left: Dimens.hugeMargin,
                      right: Dimens.hugeMargin),
                  child: Row(
                    children: [Expanded(child: _segmentedButton())],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                    child: _image(trainerEntity.imagePath)),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.mediumMargin),
                  child: Text("${trainerEntity.name} ${trainerEntity.surname}",
                      style: ThemeText.mediumTitleBold),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.smallerMargin, bottom: Dimens.mediumMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(trainerEntity.rating.toString(),
                          style: ThemeText.subHeadingBold),
                      Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.smallerMargin,
                              right: Dimens.smallerMargin),
                          child: const Icon(Icons.star)),
                      Text("(${trainerEntity.votesNumber})",
                          style: ThemeText.subHeadingRegular)
                    ],
                  ),
                ),
                _requestForTrainingButton(userType),
                _contactButton(userType),
              ],
            ),
            Visibility(
              visible: _segmentSelected.contains(_Segments.about.name),
              child: _aboutSection(trainerEntity),
            ),
            Visibility(
              visible: _segmentSelected.contains(_Segments.reviews.name),
              child: _reviewsSection(trainerEntity),
            )
          ],
        ),
      ),
    );
  }

  SegmentedButton<String> _segmentedButton() {
    return SegmentedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.black;
              } else {
                return Colors.white;
              }
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return ThemeText.bodyBoldWhiteText;
              } else {
                return ThemeText.bodyBoldBlackText;
              }
            },
          ),
        ),
        showSelectedIcon: false,
        selected: _segmentSelected,
        segments: [
          ButtonSegment<String>(
              value: _Segments.about.name, label: const Text('About')),
          ButtonSegment<String>(
              value: _Segments.reviews.name, label: const Text('Reviews')),
        ],
        onSelectionChanged: (selectedSet) {
          setState(() {
            _segmentSelected = selectedSet;
          });
        });
  }

  Visibility _contactButton(UserType? userType) {
    return Visibility(
        visible: userType != UserType.trainer,
        child: Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin, bottom: Dimens.biggerMargin),
            child: const PersoButton(
              title: "Contact",
              width: Dimens.largeButtonWidth,
              whiteBlackTheme: true,
            )));
  }

  Visibility _requestForTrainingButton(UserType? userType) {
    return Visibility(
      visible: userType != UserType.trainer,
      child: BlocProvider(
        create: (context) =>
            TrainingRequestBloc(const TrainingRequestState.initial()),
        child: BlocConsumer<TrainingRequestBloc, TrainingRequestState>(
          builder: (context, state) {
            return state.whenOrNull(
                    initial: () {
                      context.read<TrainingRequestBloc>().add(
                          TrainingRequestEvent
                              .checkIfUserHasAlreadyRequestTraining(
                                  widget._trainerId));
                      return _initialTrainingRequestButton();
                    },
                    hasUserAlreadyRequestedTraining: (bool hasRequested) {
                      if (hasRequested) {
                        return _trainingRequestSentButton();
                      } else {
                        return _initialTrainingRequestButton();
                      }
                    },
                    loadingTrainingRequest: () => _trainingRequestLoading(),
                    successTrainingRequest: () =>
                        _trainingRequestSentButton()) ??
                Container();
          },
          listener: (context, state) {
            state.whenOrNull(navigateToSignUp: () {
              context.pushNamed(ScreenNavigationKey.signIn);
            });
          },
        ),
      ),
    );
  }

  PersoButton _trainingRequestLoading() {
    return const PersoButton(
      isLoading: true,
      width: Dimens.largeButtonWidth,
    );
  }

  PersoButton _trainingRequestSentButton() {
    return const PersoButton(
      width: Dimens.largeButtonWidth,
      title: "Request sent",
    );
  }

  PersoButton _initialTrainingRequestButton() {
    return PersoButton(
      title: "Request for training",
      width: Dimens.largeButtonWidth,
      onTap: (context) {
        context
            .read<TrainingRequestBloc>()
            .add(TrainingRequestEvent.trainingRequest(widget._trainerId));
      },
    );
  }

  Widget _image(String imagePath) {
    if (imagePath.isNotEmpty) {
      return Image.network(imagePath);
    } else {
      return const Icon(
        Icons.account_circle,
        size: 88.0,
      );
    }
  }

  Container _aboutSection(TrainerEntity trainerEntity) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin, left: Dimens.normalMargin),
              child: Text(
                "Biography",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.smallMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Text(
              trainerEntity.fullBio,
              style: ThemeText.subHeadingRegularGrey,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                "Location",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.normalMargin,
                top: Dimens.mediumMargin,
                right: Dimens.normalMargin),
            child: Row(
              children: [
                const Icon(Icons.pin_drop),
                Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: Dimens.normalMargin,
                          right: Dimens.normalMargin),
                      child: Text(
                        trainerEntity.location,
                        style: ThemeText.bodyRegularBlackText,
                        softWrap: true,
                      )),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.bigMargin, left: Dimens.normalMargin),
            child: Text(
              "Specialities",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: Dimens.smallMargin),
              child: PersoCategoryChips(
                areChipsSelectable: false,
              )),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.bigMargin, left: Dimens.normalMargin),
            child: Text(
              "Languages",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin,
                left: Dimens.smallMargin,
                right: Dimens.normalMargin,
                bottom: Dimens.normalMargin),
            child: _getLanguages(trainerEntity.languages),
          ),
        ],
      ),
    );
  }

  Row _getLanguages(List<String> languages) {
    List<Container> languageWidgets = languages.map((element) {
      String language = element.removeBrackets();
      return Container(
        margin: const EdgeInsets.only(left: Dimens.smallMargin),
        child: Text(
          language,
          style: const TextStyle(fontSize: 24.0),
        ),
      );
    }).toList();
    return Row(children: languageWidgets);
  }

  Container _reviewsSection(TrainerEntity trainerEntity) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mediumMargin, left: Dimens.mediumMargin),
              child: Text("Rating", style: ThemeText.bodyBoldBlackText)),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.mediumMargin, bottom: Dimens.mediumMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Based on 142 reviews",
                    style: ThemeText.bodyRegularBlackText),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 40.0,
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            left: Dimens.smallMargin,
                            right: Dimens.normalMargin),
                        child: Text(
                          "5.0",
                          style: ThemeText.largerTitleBold,
                        )),
                  ],
                )
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin,
                left: Dimens.mediumMargin,
                right: Dimens.mediumMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tap to rate",
                  style: ThemeText.bodyBoldBlackText,
                ),
                RatingBar(
                  allowHalfRating: true,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.yellow),
                      half: const Icon(Icons.star_half, color: Colors.yellow),
                      empty:
                          const Icon(Icons.star_border, color: Colors.yellow)),
                  onRatingUpdate: (value) {
                    //no-op
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.mediumMargin,
                right: Dimens.mediumMargin,
                bottom: Dimens.mediumMargin),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 48.0,
                ),
                Container(
                    margin: const EdgeInsets.only(left: Dimens.smallMargin),
                    child: Text("Write review",
                        style: ThemeText.calloutRegularGrey))
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin, left: Dimens.mediumMargin),
            child: Text(
              "Reviews",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          _review()
        ],
      ),
    );
  }

  Container _review() {
    return Container(
      margin: const EdgeInsets.all(Dimens.mediumMargin),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Icon(Icons.account_circle, size: 48.0),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.smallMargin),
                  child: Column(
                    children: [
                      Text("John Wick", style: ThemeText.bodyBoldBlackText),
                      RatingBar(
                        itemSize: 20.0,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.yellow),
                            half: const Icon(Icons.star_half,
                                color: Colors.yellow),
                            empty: const Icon(Icons.star_border,
                                color: Colors.yellow)),
                        onRatingUpdate: (value) {
                          //no-op
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text("1 month ago", style: ThemeText.bodyRegularBlackText)
          ]),
          Container(
              margin: const EdgeInsets.only(top: Dimens.smallMargin),
              child: Text(
                  "Let me put it this way! Andrew went out of his way to in our journey together. I wasn’t sure about things in the beginning, Lol.",
                  style: ThemeText.bodyRegularBlackText)),
        ],
      ),
    );
  }
}

enum _Segments { about, reviews }
