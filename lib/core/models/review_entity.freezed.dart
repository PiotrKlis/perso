// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReviewEntity {
  double get rating => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReviewEntityCopyWith<ReviewEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewEntityCopyWith<$Res> {
  factory $ReviewEntityCopyWith(
          ReviewEntity value, $Res Function(ReviewEntity) then) =
      _$ReviewEntityCopyWithImpl<$Res, ReviewEntity>;
  @useResult
  $Res call({double rating, String description});
}

/// @nodoc
class _$ReviewEntityCopyWithImpl<$Res, $Val extends ReviewEntity>
    implements $ReviewEntityCopyWith<$Res> {
  _$ReviewEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReviewEntityCopyWith<$Res>
    implements $ReviewEntityCopyWith<$Res> {
  factory _$$_ReviewEntityCopyWith(
          _$_ReviewEntity value, $Res Function(_$_ReviewEntity) then) =
      __$$_ReviewEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rating, String description});
}

/// @nodoc
class __$$_ReviewEntityCopyWithImpl<$Res>
    extends _$ReviewEntityCopyWithImpl<$Res, _$_ReviewEntity>
    implements _$$_ReviewEntityCopyWith<$Res> {
  __$$_ReviewEntityCopyWithImpl(
      _$_ReviewEntity _value, $Res Function(_$_ReviewEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? description = null,
  }) {
    return _then(_$_ReviewEntity(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReviewEntity implements _ReviewEntity {
  const _$_ReviewEntity({required this.rating, required this.description});

  @override
  final double rating;
  @override
  final String description;

  @override
  String toString() {
    return 'ReviewEntity(rating: $rating, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewEntity &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rating, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewEntityCopyWith<_$_ReviewEntity> get copyWith =>
      __$$_ReviewEntityCopyWithImpl<_$_ReviewEntity>(this, _$identity);
}

abstract class _ReviewEntity implements ReviewEntity {
  const factory _ReviewEntity(
      {required final double rating,
      required final String description}) = _$_ReviewEntity;

  @override
  double get rating;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewEntityCopyWith<_$_ReviewEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
