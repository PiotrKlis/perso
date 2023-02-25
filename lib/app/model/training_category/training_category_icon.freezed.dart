part of 'training_category_icon.dart';

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
mixin _$TrainingCategoryIcon {
  SvgPicture get icon => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingCategoryIconCopyWith<TrainingCategoryIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingCategoryIconCopyWith<$Res> {
  factory $TrainingCategoryIconCopyWith(TrainingCategoryIcon value,
          $Res Function(TrainingCategoryIcon) then) =
      _$TrainingCategoryIconCopyWithImpl<$Res, TrainingCategoryIcon>;
  @useResult
  $Res call({SvgPicture icon, Color color});
}

/// @nodoc
class _$TrainingCategoryIconCopyWithImpl<$Res,
        $Val extends TrainingCategoryIcon>
    implements $TrainingCategoryIconCopyWith<$Res> {
  _$TrainingCategoryIconCopyWithImpl(this._value, this._then);

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
abstract class _$$_TrainingCategoryIconCopyWith<$Res>
    implements $TrainingCategoryIconCopyWith<$Res> {
  factory _$$_TrainingCategoryIconCopyWith(_$_TrainingCategoryIcon value,
          $Res Function(_$_TrainingCategoryIcon) then) =
      __$$_TrainingCategoryIconCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SvgPicture icon, Color color});
}

/// @nodoc
class __$$_TrainingCategoryIconCopyWithImpl<$Res>
    extends _$TrainingCategoryIconCopyWithImpl<$Res, _$_TrainingCategoryIcon>
    implements _$$_TrainingCategoryIconCopyWith<$Res> {
  __$$_TrainingCategoryIconCopyWithImpl(_$_TrainingCategoryIcon _value,
      $Res Function(_$_TrainingCategoryIcon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? color = null,
  }) {
    return _then(_$_TrainingCategoryIcon(
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

class _$_TrainingCategoryIcon implements _TrainingCategoryIcon {
  const _$_TrainingCategoryIcon({required this.icon, required this.color});

  @override
  final SvgPicture icon;
  @override
  final Color color;

  @override
  String toString() {
    return 'TrainingCategoryIcon(icon: $icon, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingCategoryIcon &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, icon, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingCategoryIconCopyWith<_$_TrainingCategoryIcon> get copyWith =>
      __$$_TrainingCategoryIconCopyWithImpl<_$_TrainingCategoryIcon>(
          this, _$identity);
}

abstract class _TrainingCategoryIcon implements TrainingCategoryIcon {
  const factory _TrainingCategoryIcon(
      {required final SvgPicture icon,
      required final Color color}) = _$_TrainingCategoryIcon;

  @override
  SvgPicture get icon;
  @override
  Color get color;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingCategoryIconCopyWith<_$_TrainingCategoryIcon> get copyWith =>
      throw _privateConstructorUsedError;
}
