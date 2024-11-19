part of 'trainer_details_screen.dart';

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({
    required List<ReviewEntity> reviews,
    required double rating,
  })  : _rating = rating,
        _reviews = reviews;

  final List<ReviewEntity> _reviews;
  final double _rating;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
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
                        const Text(
                          'John Wick',
                          style: ThemeText.bodyBoldBlackText,
                        ),
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
