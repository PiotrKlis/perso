import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainer_short_data.freezed.dart';

@freezed
class TrainerShortData with _$TrainerShortData {
  const factory TrainerShortData(
      {required final String id,
        required final String name,
        required final String surname,
        required final String nickname,
        required final int votesNumber,
        required final double rating,
        required final String shortBio,
        required final List<String> languages,
        required final List<String> categories,
        required final String imagePath}) = _TrainerShortData;
}