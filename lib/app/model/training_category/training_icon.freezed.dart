part of 'training_icon.dart';

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingIcon {
  SvgPicture get icon => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingIconCopyWith<TrainingIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingIconCopyWith<$Res> {
  factory $TrainingIconCopyWith(
          TrainingIcon value, $Res Function(TrainingIcon) then) =
      _$TrainingIconCopyWithImpl<$Res, TrainingIcon>;
  @useResult
  $Res call({SvgPicture icon, Color color});
}

/// @nodoc
class _$TrainingIconCopyWithImpl<$Res, $Val extends TrainingIcon>
    implements $TrainingIconCopyWith<$Res> {
  _$TrainingIconCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as SvgPicture,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainingCategoryCopyWith<$Res>
    implements $TrainingIconCopyWith<$Res> {
  factory _$$_TrainingCategoryCopyWith(
          _$_TrainingCategory value, $Res Function(_$_TrainingCategory) then) =
      __$$_TrainingCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SvgPicture icon, Color color});
}

/// @nodoc
class __$$_TrainingCategoryCopyWithImpl<$Res>
    extends _$TrainingIconCopyWithImpl<$Res, _$_TrainingCategory>
    implements _$$_TrainingCategoryCopyWith<$Res> {
  __$$_TrainingCategoryCopyWithImpl(
      _$_TrainingCategory _value, $Res Function(_$_TrainingCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? color = null,
  }) {
    return _then(_$_TrainingCategory(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as SvgPicture,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_TrainingCategory implements _TrainingCategory {
  const _$_TrainingCategory({required this.icon, required this.color});

  @override
  final SvgPicture icon;
  @override
  final Color color;

  @override
  String toString() {
    return 'TrainingIcon(icon: $icon, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingCategory &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, icon, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingCategoryCopyWith<_$_TrainingCategory> get copyWith =>
      __$$_TrainingCategoryCopyWithImpl<_$_TrainingCategory>(this, _$identity);
}

abstract class _TrainingCategory implements TrainingIcon {
  const factory _TrainingCategory(
      {required final SvgPicture icon,
      required final Color color}) = _$_TrainingCategory;

  @override
  SvgPicture get icon;
  @override
  Color get color;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingCategoryCopyWith<_$_TrainingCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
