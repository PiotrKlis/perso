import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/trainer_details/bloc/training_request_bloc.dart';
import 'package:perso/app/screens/trainer_details/event/training_request_event.dart';
import 'package:perso/app/screens/trainer_details/state/training_request_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/perso_google_map.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/review_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

import '../../widgets/perso_text_field.dart';

part 'about_section.dart';

part 'reviews_section.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({required TrainerEntity trainerEntity, super.key})
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
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(),
      child: Scaffold(
        appBar: PersoAppBar(
          isTitleCentered: true,
          title: '@${widget._trainerEntity.nickname}',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.xmMargin,
                      left: Dimens.xxlMargin,
                      right: Dimens.xxlMargin,
                    ),
                    child: Row(
                      children: [Expanded(child: _segmentedButton())],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.xlMargin),
                    child: _image(widget._trainerEntity.imagePath),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.mMargin),
                    child: Text(
                      '${widget._trainerEntity.name} ${widget._trainerEntity.surname}',
                      style: ThemeText.mediumTitleBold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.sMargin,
                      bottom: Dimens.mMargin,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget._trainerEntity.rating.toString(),
                          style: ThemeText.subHeadingBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: Dimens.sMargin,
                            right: Dimens.sMargin,
                          ),
                          child: const Icon(Icons.star),
                        ),
                        Text(
                          '(${widget._trainerEntity.votesNumber})',
                          style: ThemeText.subHeadingRegular,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      _requestForTrainingButton(),
                      _contactButton(),
                    ],
                  ),
                  Visibility(
                    visible: _segmentSelected.contains(_Segments.about.name),
                    child: _AboutSection(trainerEntity: widget._trainerEntity),
                  ),
                  Visibility(
                    visible: _segmentSelected.contains(_Segments.reviews.name),
                    child: _ReviewsSection(
                      reviews: widget._trainerEntity.reviews,
                      rating: widget._trainerEntity.rating,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SegmentedButton<String> _segmentedButton() {
    return SegmentedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
          return ThemeText.bodyBoldBlackText;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            } else {
              return Colors.black;
            }
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.black;
            } else {
              return Colors.white;
            }
          },
        ),
      ),
      showSelectedIcon: false,
      selected: _segmentSelected,
      segments: [
        ButtonSegment<String>(
          value: _Segments.about.name,
          label: const Text('About'),
        ),
        ButtonSegment<String>(
          value: _Segments.reviews.name,
          label: const Text('Reviews'),
        ),
      ],
      onSelectionChanged: (selectedSet) {
        setState(() {
          _segmentSelected = selectedSet;
        });
      },
    );
  }

  Container _contactButton() {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.mMargin,
        bottom: Dimens.xlMargin,
      ),
      child: const PersoButton(
        title: 'Contact',
        width: Dimens.lButtonWidth,
        whiteBlackTheme: true,
      ),
    );
  }

  BlocProvider<TrainingRequestBloc> _requestForTrainingButton() {
    return BlocProvider(
      create: (context) =>
          TrainingRequestBloc(const TrainingRequestState.initial()),
      child: BlocConsumer<TrainingRequestBloc, TrainingRequestState>(
        builder: (context, state) {
          return state.whenOrNull(
                initial: () {
                  context.read<TrainingRequestBloc>().add(
                        TrainingRequestEvent
                            .checkIfUserHasAlreadyRequestTraining(
                          widget._trainerEntity.id,
                        ),
                      );
                  return _initialTrainingRequestButton();
                },
                hasUserAlreadyRequestedTraining: (bool hasRequested) {
                  if (hasRequested) {
                    return _trainingRequestSentButton();
                  } else {
                    return _initialTrainingRequestButton();
                  }
                },
                loadingTrainingRequest: _trainingRequestLoading,
                successTrainingRequest: _trainingRequestSentButton,
              ) ??
              Container();
        },
        listener: (context, state) {
          state.whenOrNull(
            navigateToSignUp: () {
              context.pushNamed(ScreenNavigationKey.signIn);
            },
          );
        },
      ),
    );
  }

  PersoButton _trainingRequestLoading() {
    return const PersoButton(
      isLoading: true,
      width: Dimens.lButtonWidth,
    );
  }

  PersoButton _trainingRequestSentButton() {
    return const PersoButton(
      width: Dimens.lButtonWidth,
      title: 'Request sent',
    );
  }

  PersoButton _initialTrainingRequestButton() {
    return PersoButton(
      title: 'Request for training',
      width: Dimens.lButtonWidth,
      onTap: (context) {
        context.read<TrainingRequestBloc>().add(
              TrainingRequestEvent.trainingRequest(widget._trainerEntity.id),
            );
      },
    );
  }

  Widget _image(String imagePath) {
    if (imagePath.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: Dimens.profileImageHeight,
          height: Dimens.profileImageWidth,
        ),
      );
    } else {
      return const Icon(
        Icons.account_circle,
        size: 88,
      );
    }
  }
}

enum _Segments { about, reviews }
