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
  TrainingCategoryIcon get trainingCategoryIcon =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

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
  $Res call({TrainingCategoryIcon trainingCategoryIcon, String name});

  $TrainingCategoryIconCopyWith<$Res> get trainingCategoryIcon;
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
    Object? trainingCategoryIcon = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      trainingCategoryIcon: null == trainingCategoryIcon
          ? _value.trainingCategoryIcon
          : trainingCategoryIcon // ignore: cast_nullable_to_non_nullable
              as TrainingCategoryIcon,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrainingCategoryIconCopyWith<$Res> get trainingCategoryIcon {
    return $TrainingCategoryIconCopyWith<$Res>(_value.trainingCategoryIcon,
        (value) {
      return _then(_value.copyWith(trainingCategoryIcon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainingCategoryImplCopyWith<$Res>
    implements $TrainingCategoryCopyWith<$Res> {
  factory _$$TrainingCategoryImplCopyWith(_$TrainingCategoryImpl value,
          $Res Function(_$TrainingCategoryImpl) then) =
      __$$TrainingCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TrainingCategoryIcon trainingCategoryIcon, String name});

  @override
  $TrainingCategoryIconCopyWith<$Res> get trainingCategoryIcon;
}

/// @nodoc
class __$$TrainingCategoryImplCopyWithImpl<$Res>
    extends _$TrainingCategoryCopyWithImpl<$Res, _$TrainingCategoryImpl>
    implements _$$TrainingCategoryImplCopyWith<$Res> {
  __$$TrainingCategoryImplCopyWithImpl(_$TrainingCategoryImpl _value,
      $Res Function(_$TrainingCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainingCategoryIcon = null,
    Object? name = null,
  }) {
    return _then(_$TrainingCategoryImpl(
      trainingCategoryIcon: null == trainingCategoryIcon
          ? _value.trainingCategoryIcon
          : trainingCategoryIcon // ignore: cast_nullable_to_non_nullable
              as TrainingCategoryIcon,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TrainingCategoryImpl implements _TrainingCategory {
  const _$TrainingCategoryImpl(
      {required this.trainingCategoryIcon, required this.name});

  @override
  final TrainingCategoryIcon trainingCategoryIcon;
  @override
  final String name;

  @override
  String toString() {
    return 'TrainingCategory(trainingCategoryIcon: $trainingCategoryIcon, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingCategoryImpl &&
            (identical(other.trainingCategoryIcon, trainingCategoryIcon) ||
                other.trainingCategoryIcon == trainingCategoryIcon) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trainingCategoryIcon, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingCategoryImplCopyWith<_$TrainingCategoryImpl> get copyWith =>
      __$$TrainingCategoryImplCopyWithImpl<_$TrainingCategoryImpl>(
          this, _$identity);
}

abstract class _TrainingCategory implements TrainingCategory {
  const factory _TrainingCategory(
      {required final TrainingCategoryIcon trainingCategoryIcon,
      required final String name}) = _$TrainingCategoryImpl;

  @override
  TrainingCategoryIcon get trainingCategoryIcon;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TrainingCategoryImplCopyWith<_$TrainingCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
