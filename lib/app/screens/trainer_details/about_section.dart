part of 'trainer_details_screen.dart';

class _AboutSection extends StatelessWidget {
  const _AboutSection({required TrainerEntity trainerEntity, super.key})
      : _trainerEntity = trainerEntity;

  final TrainerEntity _trainerEntity;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
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
              _trainerEntity.longBio,
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
                      _trainerEntity.address,
                      style: ThemeText.bodyRegularBlackText,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xsMargin),
            child: PersoGoogleMap(trainerEntity: _trainerEntity),
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
              categories: _trainerEntity.categories,
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
            child: _languagesSection(_trainerEntity.languages),
          ),
        ],
      ),
    );
  }

  Row _languagesSection(List<String> languages) {
    final languageWidgets = languages.map((language) {
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
}
