import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile/bloc/profile_bloc.dart';
import 'package:perso/app/screens/profile/event/profile_event.dart';
import 'package:perso/app/screens/profile/state/profile_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({super.key});

  final userProfile = getIt.get<UserInfoProvider>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const ProfileEvent.loadData()),
      child: const _ClientProfileScreenBuilder(),
    );
  }
}

class _ClientProfileScreenBuilder extends StatelessWidget {
  const _ClientProfileScreenBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          data: (profileEntity) {
            return _ClientProfileScreenContent(
              clientEntity: profileEntity as ClientEntity,
            );
          },
        );
      },
    );
  }
}

class _ClientProfileScreenContent extends StatefulWidget {
  const _ClientProfileScreenContent({required ClientEntity clientEntity})
      : _clientEntity = clientEntity;

  final ClientEntity _clientEntity;

  @override
  State<_ClientProfileScreenContent> createState() =>
      _ClientProfileScreenContentState();
}

class _ClientProfileScreenContentState
    extends State<_ClientProfileScreenContent> {
  Set<String> _segmentSelected = Set.from({_Segments.about.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(
        isTitleCentered: true,
        title: '@${widget._clientEntity.nickname}',
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
                  child: _image(widget._clientEntity.imagePath),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.mMargin),
                  child: Text(
                    '${widget._clientEntity.name} ${widget._clientEntity.surname}',
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
                      const Text(
                        '4.5',
                        style: ThemeText.subHeadingBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimens.sMargin,
                          right: Dimens.sMargin,
                        ),
                        child: const Icon(Icons.star),
                      ),
                      const Text(
                        '(66})',
                        style: ThemeText.subHeadingRegular,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _segmentSelected.contains(_Segments.about.name),
                  child: _aboutSection(widget._clientEntity),
                ),
                Visibility(
                  visible: _segmentSelected.contains(_Segments.reviews.name),
                  child: _reviewsSection(widget._clientEntity),
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

  Widget _image(String imagePath) {
    if (imagePath.isNotEmpty) {
      return Image.network(imagePath);
    } else {
      return const Icon(
        Icons.account_circle,
        size: 88,
      );
    }
  }

  Container _aboutSection(ClientEntity clientEntity) {
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
              top: Dimens.lMargin,
              left: Dimens.xmMargin,
            ),
            child: const Text(
              'Specialities',
              style: ThemeText.bodyBoldBlackText,
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
            child: _getLanguages(clientEntity.languages),
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

  Container _reviewsSection(ClientEntity clientEntity) {
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
                        const Text('John Wick', style: ThemeText.bodyBoldBlackText),
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
