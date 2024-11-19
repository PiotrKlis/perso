import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_review_state.freezed.dart';

@freezed
class ConfirmReviewState with _$ConfirmReviewState {
  const factory ConfirmReviewState.initial() = Initial;

  const factory ConfirmReviewState.loading() = Loading;

  const factory ConfirmReviewState.added() = Added;

  const factory ConfirmReviewState.error(String error) = Error;
}
