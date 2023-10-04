import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entity.freezed.dart';

@freezed
class ReviewEntity with _$ReviewEntity {
  const factory ReviewEntity({
    required final double rating,
    required final String description,
  }) = _ReviewEntity;
}
