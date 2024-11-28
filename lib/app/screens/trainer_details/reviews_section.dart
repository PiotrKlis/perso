part of 'trainer_details_screen.dart';

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({
    required List<ReviewEntity> reviews,
    required double rating,
    required String trainerId,
  })  : _rating = rating,
        _reviews = reviews,
        _trainerId = trainerId;

  final List<ReviewEntity> _reviews;
  final double _rating;
  final String _trainerId;

  @override
  Widget build(BuildContext context) {
    final reviewTextEditingController = TextEditingController();
    var tappedRating = _rating;

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
                      child: Text(
                        tappedRating.toString(),
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
                    tappedRating = value;
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
                Expanded(
                  child: Container(
                    height: 140,
                    margin: const EdgeInsets.only(
                      top: Dimens.xmMargin,
                      left: Dimens.xmMargin,
                    ),
                    child: PersoTextField(
                      hintText: context.strings.write_review,
                      customValidator: TextFieldValidator.validateIsEmpty,
                      isMultiLine: true,
                      maxLength: 150,
                      textEditingController: reviewTextEditingController,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(Dimens.xmMargin),
            child: BlocBuilder<ConfirmReviewCubit, ConfirmReviewState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return PersoButton(
                      title: context.strings.confirm,
                      onTap: (context) {
                        context.read<ConfirmReviewCubit>().addReview(
                              reviewTextEditingController.text,
                              _trainerId,
                              tappedRating,
                            );
                      },
                    );
                  },
                  loading: () {
                    return const PersoButton(
                      isLoading: true,
                    );
                  },
                  added: () {
                    return const PersoButton(
                      title: 'Review sent',
                    );
                  },
                  error: (error) {
                    return PersoButton(
                      title: 'Something went wrong, try again',
                      onTap: (context) {
                        context.read<ConfirmReviewCubit>().addReview(
                              reviewTextEditingController.text,
                              _trainerId,
                              tappedRating,
                            );
                      },
                    );
                  },
                );
              },
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
