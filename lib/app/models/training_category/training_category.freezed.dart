// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingCategory {
  PersoTrainingCategoryIcon get persoCategoryIcon =>
      throw _privateConstructorUsedError;
  Text get text => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingCategoryCopyWith<TrainingCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingCategoryCopyWith<$Res> {
  factory $TrainingCategoryCopyWith(
          TrainingCategory value, $Res Function(TrainingCategory) then) =
      _$TrainingCategoryCopyWithImpl<$Res, TrainingCategory>;
  @useResult
  $Res call({PersoTrainingCategoryIcon persoCategoryIcon, Text text});
}

/// @nodoc
class _$TrainingCategoryCopyWithImpl<$Res, $Val extends TrainingCategory>
    implements $TrainingCategoryCopyWith<$Res> {
  _$TrainingCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? persoCategoryIcon = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      persoCategoryIcon: null == persoCategoryIcon
          ? _value.persoCategoryIcon
          : persoCategoryIcon // ignore: cast_nullable_to_non_nullable
              as PersoTrainingCategoryIcon,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as Text,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainingCategoryCopyWith<$Res>
    implements $TrainingCategoryCopyWith<$Res> {
  factory _$$_TrainingCategoryCopyWith(
          _$_TrainingCategory value, $Res Function(_$_TrainingCategory) then) =
      __$$_TrainingCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PersoTrainingCategoryIcon persoCategoryIcon, Text text});
}

/// @nodoc
class __$$_TrainingCategoryCopyWithImpl<$Res>
    extends _$TrainingCategoryCopyWithImpl<$Res, _$_TrainingCategory>
    implements _$$_TrainingCategoryCopyWith<$Res> {
  __$$_TrainingCategoryCopyWithImpl(
      _$_TrainingCategory _value, $Res Function(_$_TrainingCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? persoCategoryIcon = null,
    Object? text = null,
  }) {
    return _then(_$_TrainingCategory(
      persoCategoryIcon: null == persoCategoryIcon
          ? _value.persoCategoryIcon
          : persoCategoryIcon // ignore: cast_nullable_to_non_nullable
              as PersoTrainingCategoryIcon,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as Text,
    ));
  }
}

/// @nodoc

class _$_TrainingCategory implements _TrainingCategory {
  const _$_TrainingCategory(
      {required this.persoCategoryIcon, required this.text});

  @override
  final PersoTrainingCategoryIcon persoCategoryIcon;
  @override
  final Text text;

  @override
  String toString() {
    return 'TrainingCategory(persoCategoryIcon: $persoCategoryIcon, text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingCategory &&
            (identical(other.persoCategoryIcon, persoCategoryIcon) ||
                other.persoCategoryIcon == persoCategoryIcon) &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, persoCategoryIcon, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingCategoryCopyWith<_$_TrainingCategory> get copyWith =>
      __$$_TrainingCategoryCopyWithImpl<_$_TrainingCategory>(this, _$identity);
}

abstract class _TrainingCategory implements TrainingCategory {
  const factory _TrainingCategory(
      {required final PersoTrainingCategoryIcon persoCategoryIcon,
      required final Text text}) = _$_TrainingCategory;

  @override
  PersoTrainingCategoryIcon get persoCategoryIcon;
  @override
  Text get text;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingCategoryCopyWith<_$_TrainingCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
