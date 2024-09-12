import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile/bloc/profile_bloc.dart';
import 'package:perso/app/screens/profile/event/profile_event.dart';
import 'package:perso/app/screens/profile/state/profile_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/profile_image.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class TrainerProfileScreen extends StatelessWidget {
  TrainerProfileScreen({super.key});

  final userProfile = getIt.get<UserInfoProvider>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileBloc()..add(const ProfileEvent.loadData()),
        ),
        BlocProvider(
          create: (context) => ImageCubit()..getImageUrl(),
        )
      ],
      child: const _TrainerProfileScreenBuilder(),
    );
  }
}

class _TrainerProfileScreenBuilder extends StatelessWidget {
  const _TrainerProfileScreenBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          data: (profileEntity) {
            return _TrainerProfileScreenContent(
              trainerEntity: profileEntity as TrainerEntity,
            );
          },
        );
      },
    );
  }
}

class _TrainerProfileScreenContent extends StatefulWidget {
  const _TrainerProfileScreenContent({required TrainerEntity trainerEntity})
      : _trainerEntity = trainerEntity;

  final TrainerEntity _trainerEntity;

  @override
  State<_TrainerProfileScreenContent> createState() =>
      _TrainerProfileScreenContentState();
}

class _TrainerProfileScreenContentState
    extends State<_TrainerProfileScreenContent> {
  Set<String> _segmentSelected = Set.from({_Segments.about.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: const ProfileImage(),
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
                Visibility(
                  visible: _segmentSelected.contains(_Segments.about.name),
                  child: _aboutSection(widget._trainerEntity),
                ),
                Visibility(
                  visible: _segmentSelected.contains(_Segments.reviews.name),
                  child: _reviewsSection(widget._trainerEntity),
                ),
              ],
            ),
          ],
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

  Container _aboutSection(TrainerEntity trainerEntity) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.xmMargin,
            ),
            child: const Text(
              'Biography',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xsMargin,
              left: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: Text(
              trainerEntity.fullBio,
              style: ThemeText.subHeadingRegularGrey,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: const Text(
              'Location',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.xmMargin,
              top: Dimens.mMargin,
              right: Dimens.xmMargin,
            ),
            child: Row(
              children: [
                const Icon(Icons.pin_drop),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: Dimens.xmMargin,
                      right: Dimens.xmMargin,
                    ),
                    child: Text(
                      trainerEntity.location,
                      style: ThemeText.bodyRegularBlackText,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.xmMargin,
            ),
            child: const Text(
              'Specialities',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xsMargin),
            child: PersoCategoryChips(
              categories: trainerEntity.categories,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.xmMargin,
            ),
            child: const Text(
              'Languages',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.mMargin,
              left: Dimens.xsMargin,
              right: Dimens.xmMargin,
              bottom: Dimens.xmMargin,
            ),
            child: _getLanguages(trainerEntity.languages),
          ),
          Container(
            margin: const EdgeInsets.all(Dimens.mMargin),
            child: PersoButton(
              title: context.strings.logout,
              onTap: (context) async {
                context.read<ProfileBloc>().add(const ProfileEvent.logout());
                context.replaceNamed(ScreenNavigationKey.home);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _getLanguages(List<String> languages) {
    final languageWidgets = languages.map((element) {
      final language = element.removeBrackets();
      return Container(
        margin: const EdgeInsets.only(left: Dimens.xsMargin),
        child: Text(
          language,
          style: const TextStyle(fontSize: 24),
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
              top: Dimens.mMargin,
              left: Dimens.mMargin,
            ),
            child: const Text('Rating', style: ThemeText.bodyBoldBlackText),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.mMargin,
              bottom: Dimens.mMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Based on 142 reviews',
                  style: ThemeText.bodyRegularBlackText,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: Dimens.xsMargin,
                        right: Dimens.xmMargin,
                      ),
                      child: const Text(
                        '5.0',
                        style: ThemeText.largerTitleBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.mMargin,
              left: Dimens.mMargin,
              right: Dimens.mMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tap to rate',
                  style: ThemeText.bodyBoldBlackText,
                ),
                RatingBar(
                  allowHalfRating: true,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.yellow),
                    half: const Icon(Icons.star_half, color: Colors.yellow),
                    empty: const Icon(Icons.star_border, color: Colors.yellow),
                  ),
                  onRatingUpdate: (value) {
                    //no-op
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.mMargin,
              right: Dimens.mMargin,
              bottom: Dimens.mMargin,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 48,
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.xsMargin),
                  child: const Text(
                    'Write review',
                    style: ThemeText.calloutRegularGrey,
                  ),
                ),
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.mMargin,
              left: Dimens.mMargin,
            ),
            child: const Text(
              'Reviews',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          _review(),
        ],
      ),
    );
  }

  Container _review() {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.account_circle, size: 48),
                  Container(
                    margin: const EdgeInsets.only(left: Dimens.xsMargin),
                    child: Column(
                      children: [
                        const Text('John Wick',
                            style: ThemeText.bodyBoldBlackText),
                        RatingBar(
                          itemSize: 20,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.yellow),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.yellow,
                            ),
                            empty: const Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                            ),
                          ),
                          onRatingUpdate: (value) {
                            //no-op
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Text('1 month ago', style: ThemeText.bodyRegularBlackText),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xsMargin),
            child: const Text(
              'Let me put it this way! Andrew went out of his way to in our journey together. I wasn’t sure about things in the beginning, Lol.',
              style: ThemeText.bodyRegularBlackText,
            ),
          ),
        ],
      ),
    );
  }
}

enum _Segments { about, reviews }
