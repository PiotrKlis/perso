// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trainer_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainerCard {
  String get icon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get ratingScore => throw _privateConstructorUsedError;
  int get votesNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainerCardCopyWith<TrainerCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainerCardCopyWith<$Res> {
  factory $TrainerCardCopyWith(
          TrainerCard value, $Res Function(TrainerCard) then) =
      _$TrainerCardCopyWithImpl<$Res, TrainerCard>;
  @useResult
  $Res call(
      {String icon,
      String name,
      String nickname,
      String description,
      double ratingScore,
      int votesNumber});
}

/// @nodoc
class _$TrainerCardCopyWithImpl<$Res, $Val extends TrainerCard>
    implements $TrainerCardCopyWith<$Res> {
  _$TrainerCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? name = null,
    Object? nickname = null,
    Object? description = null,
    Object? ratingScore = null,
    Object? votesNumber = null,
  }) {
    return _then(_value.copyWith(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ratingScore: null == ratingScore
          ? _value.ratingScore
          : ratingScore // ignore: cast_nullable_to_non_nullable
              as double,
      votesNumber: null == votesNumber
          ? _value.votesNumber
          : votesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainerCardCopyWith<$Res>
    implements $TrainerCardCopyWith<$Res> {
  factory _$$_TrainerCardCopyWith(
          _$_TrainerCard value, $Res Function(_$_TrainerCard) then) =
      __$$_TrainerCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String icon,
      String name,
      String nickname,
      String description,
      double ratingScore,
      int votesNumber});
}

/// @nodoc
class __$$_TrainerCardCopyWithImpl<$Res>
    extends _$TrainerCardCopyWithImpl<$Res, _$_TrainerCard>
    implements _$$_TrainerCardCopyWith<$Res> {
  __$$_TrainerCardCopyWithImpl(
      _$_TrainerCard _value, $Res Function(_$_TrainerCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? name = null,
    Object? nickname = null,
    Object? description = null,
    Object? ratingScore = null,
    Object? votesNumber = null,
  }) {
    return _then(_$_TrainerCard(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ratingScore: null == ratingScore
          ? _value.ratingScore
          : ratingScore // ignore: cast_nullable_to_non_nullable
              as double,
      votesNumber: null == votesNumber
          ? _value.votesNumber
          : votesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TrainerCard implements _TrainerCard {
  const _$_TrainerCard(
      {required this.icon,
      required this.name,
      required this.nickname,
      required this.description,
      required this.ratingScore,
      required this.votesNumber});

  @override
  final String icon;
  @override
  final String name;
  @override
  final String nickname;
  @override
  final String description;
  @override
  final double ratingScore;
  @override
  final int votesNumber;

  @override
  String toString() {
    return 'TrainerCard(icon: $icon, name: $name, nickname: $nickname, description: $description, ratingScore: $ratingScore, votesNumber: $votesNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainerCard &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ratingScore, ratingScore) ||
                other.ratingScore == ratingScore) &&
            (identical(other.votesNumber, votesNumber) ||
                other.votesNumber == votesNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, icon, name, nickname, description, ratingScore, votesNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainerCardCopyWith<_$_TrainerCard> get copyWith =>
      __$$_TrainerCardCopyWithImpl<_$_TrainerCard>(this, _$identity);
}

abstract class _TrainerCard implements TrainerCard {
  const factory _TrainerCard(
      {required final String icon,
      required final String name,
      required final String nickname,
      required final String description,
      required final double ratingScore,
      required final int votesNumber}) = _$_TrainerCard;

  @override
  String get icon;
  @override
  String get name;
  @override
  String get nickname;
  @override
  String get description;
  @override
  double get ratingScore;
  @override
  int get votesNumber;
  @override
  @JsonKey(ignore: true)
  _$$_TrainerCardCopyWith<_$_TrainerCard> get copyWith =>
      throw _privateConstructorUsedError;
}
