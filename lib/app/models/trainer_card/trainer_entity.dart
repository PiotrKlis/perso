import 'package:Perso/app/models/trainer_card/review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainer_entity.freezed.dart';

//TODO: Handle icon
@freezed
class TrainerEntity with _$TrainerEntity {
  const factory TrainerEntity({
    required final String id,
    required final String image,
    required final String name,
    required final String surname,
    required final String nickname,
    required final int votesNumber,
    required final String fullBio,
    required final String shortBio,
    required final String email,
    required final List<String> languages,
    required final double rating,
    required final String location,
    required final String phoneNumber,
    required final List<ReviewEntity> reviews,
    required final List<String> trainingTypes
  }) = _TrainerEntity;
}
