import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/trainer_details/bloc/action_section_bloc.dart';
import 'package:perso/app/screens/trainer_details/bloc/training_request_bloc.dart';
import 'package:perso/app/screens/trainer_details/event/action_section_event.dart';
import 'package:perso/app/screens/trainer_details/event/training_request_event.dart';
import 'package:perso/app/screens/trainer_details/state/action_section_state.dart';
import 'package:perso/app/screens/trainer_details/state/training_request_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/category_chips/category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/string_extensions.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key, required TrainerEntity trainerEntity})
      : _trainerEntity = trainerEntity,
        super();

  final TrainerEntity _trainerEntity;

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  Set<String> _segmentSelected = Set.from({_Segments.about.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(
          isTitleCentered: true, title: "@${widget._trainerEntity.nickname}"),
      body: SingleChildScrollView(
          child: Column(children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mMargin,
                  left: Dimens.xxlMargin,
                  right: Dimens.xxlMargin),
              child: Row(
                children: [Expanded(child: _segmentedButton())],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: Dimens.xlMargin),
                child: _image(widget._trainerEntity.imagePath)),
            Container(
              margin: const EdgeInsets.only(top: Dimens.sMargin),
              child: Text(
                  "${widget._trainerEntity.name} ${widget._trainerEntity.surname}",
                  style: ThemeText.mediumTitleBold),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.xxsMargin, bottom: Dimens.sMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget._trainerEntity.rating.toString(),
                      style: ThemeText.subHeadingBold),
                  Container(
                      margin: const EdgeInsets.only(
                          left: Dimens.xxsMargin,
                          right: Dimens.xxsMargin),
                      child: const Icon(Icons.star)),
                  Text("(${widget._trainerEntity.votesNumber})",
                      style: ThemeText.subHeadingRegular)
                ],
              ),
            ),
            BlocProvider(
                create: (context) => ActionSectionBloc(),
                child: BlocBuilder<ActionSectionBloc, ActionSectionState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () {
                        context.read<ActionSectionBloc>().add(
                            const ActionSectionEvent.shouldSectionBeVisible());
                        return Container();
                      },
                      sectionVisibility: (shouldSectionBeVisible) {
                        if (shouldSectionBeVisible) {
                          return Column(
                            children: [
                              _requestForTrainingButton(),
                              _contactButton(),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                )),
            Visibility(
              visible: _segmentSelected.contains(_Segments.about.name),
              child: _aboutSection(widget._trainerEntity),
            ),
            Visibility(
              visible: _segmentSelected.contains(_Segments.reviews.name),
              child: _reviewsSection(widget._trainerEntity),
            )
          ],
        ),
      ])),
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

  Container _contactButton() {
    return Container(
        margin: const EdgeInsets.only(
            top: Dimens.sMargin, bottom: Dimens.xlMargin),
        child: const PersoButton(
          title: "Contact",
          width: Dimens.largeButtonWidth,
          whiteBlackTheme: true,
        ));
  }

  BlocProvider<TrainingRequestBloc> _requestForTrainingButton() {
    return BlocProvider(
      create: (context) =>
          TrainingRequestBloc(const TrainingRequestState.initial()),
      child: BlocConsumer<TrainingRequestBloc, TrainingRequestState>(
        builder: (context, state) {
          return state.whenOrNull(
                  initial: () {
                    context.read<TrainingRequestBloc>().add(TrainingRequestEvent
                        .checkIfUserHasAlreadyRequestTraining(
                            widget._trainerEntity.id));
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
                  successTrainingRequest: () => _trainingRequestSentButton()) ??
              Container();
        },
        listener: (context, state) {
          state.whenOrNull(navigateToSignUp: () {
            context.pushNamed(ScreenNavigationKey.signIn);
          });
        },
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
        context.read<TrainingRequestBloc>().add(
            TrainingRequestEvent.trainingRequest(widget._trainerEntity.id));
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
                  top: Dimens.lMargin, left: Dimens.mMargin),
              child: Text(
                "Biography",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.xsMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin),
            child: Text(
              trainerEntity.fullBio,
              style: ThemeText.subHeadingRegularGrey,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.lMargin,
                  left: Dimens.mMargin,
                  right: Dimens.mMargin),
              child: Text(
                "Location",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.mMargin,
                top: Dimens.sMargin,
                right: Dimens.mMargin),
            child: Row(
              children: [
                const Icon(Icons.pin_drop),
                Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: Dimens.mMargin,
                          right: Dimens.mMargin),
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
                top: Dimens.lMargin, left: Dimens.mMargin),
            child: Text(
              "Specialities",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: Dimens.xsMargin),
              child: PersoCategoryChips(
                areChipsSelectable: false,
                trainerId: trainerEntity.id,
              )),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.lMargin, left: Dimens.mMargin),
            child: Text(
              "Languages",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.sMargin,
                left: Dimens.xsMargin,
                right: Dimens.mMargin,
                bottom: Dimens.mMargin),
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
        margin: const EdgeInsets.only(left: Dimens.xsMargin),
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
                  top: Dimens.sMargin, left: Dimens.sMargin),
              child: Text("Rating", style: ThemeText.bodyBoldBlackText)),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.sMargin, bottom: Dimens.sMargin),
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
                            left: Dimens.xsMargin,
                            right: Dimens.mMargin),
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
                top: Dimens.sMargin,
                left: Dimens.sMargin,
                right: Dimens.sMargin),
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
                left: Dimens.sMargin,
                right: Dimens.sMargin,
                bottom: Dimens.sMargin),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 48.0,
                ),
                Container(
                    margin: const EdgeInsets.only(left: Dimens.xsMargin),
                    child: Text("Write review",
                        style: ThemeText.calloutRegularGrey))
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.sMargin, left: Dimens.sMargin),
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
      margin: const EdgeInsets.all(Dimens.sMargin),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Icon(Icons.account_circle, size: 48.0),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.xsMargin),
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
              margin: const EdgeInsets.only(top: Dimens.xsMargin),
              child: Text(
                  "Let me put it this way! Andrew went out of his way to in our journey together. I wasn’t sure about things in the beginning, Lol.",
                  style: ThemeText.bodyRegularBlackText)),
        ],
      ),
    );
  }
}

enum _Segments { about, reviews }
