// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_category_icon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingCategoryIcon {
  String get path => throw _privateConstructorUsedError;
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
  $Res call({String path, Color color});
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
    Object? path = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingCategoryIconImplCopyWith<$Res>
    implements $TrainingCategoryIconCopyWith<$Res> {
  factory _$$TrainingCategoryIconImplCopyWith(_$TrainingCategoryIconImpl value,
          $Res Function(_$TrainingCategoryIconImpl) then) =
      __$$TrainingCategoryIconImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, Color color});
}

/// @nodoc
class __$$TrainingCategoryIconImplCopyWithImpl<$Res>
    extends _$TrainingCategoryIconCopyWithImpl<$Res, _$TrainingCategoryIconImpl>
    implements _$$TrainingCategoryIconImplCopyWith<$Res> {
  __$$TrainingCategoryIconImplCopyWithImpl(_$TrainingCategoryIconImpl _value,
      $Res Function(_$TrainingCategoryIconImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? color = null,
  }) {
    return _then(_$TrainingCategoryIconImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$TrainingCategoryIconImpl implements _TrainingCategoryIcon {
  const _$TrainingCategoryIconImpl({required this.path, required this.color});

  @override
  final String path;
  @override
  final Color color;

  @override
  String toString() {
    return 'TrainingCategoryIcon(path: $path, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingCategoryIconImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingCategoryIconImplCopyWith<_$TrainingCategoryIconImpl>
      get copyWith =>
          __$$TrainingCategoryIconImplCopyWithImpl<_$TrainingCategoryIconImpl>(
              this, _$identity);
}

abstract class _TrainingCategoryIcon implements TrainingCategoryIcon {
  const factory _TrainingCategoryIcon(
      {required final String path,
      required final Color color}) = _$TrainingCategoryIconImpl;

  @override
  String get path;
  @override
  Color get color;
  @override
  @JsonKey(ignore: true)
  _$$TrainingCategoryIconImplCopyWith<_$TrainingCategoryIconImpl>
      get copyWith => throw _privateConstructorUsedError;
}
