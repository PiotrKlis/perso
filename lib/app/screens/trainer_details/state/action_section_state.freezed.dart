// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_section_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActionSectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool shouldSectionBeVisible) sectionVisibility,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool shouldSectionBeVisible)? sectionVisibility,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool shouldSectionBeVisible)? sectionVisibility,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SectionVisibility value) sectionVisibility,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SectionVisibility value)? sectionVisibility,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SectionVisibility value)? sectionVisibility,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionSectionStateCopyWith<$Res> {
  factory $ActionSectionStateCopyWith(
          ActionSectionState value, $Res Function(ActionSectionState) then) =
      _$ActionSectionStateCopyWithImpl<$Res, ActionSectionState>;
}

/// @nodoc
class _$ActionSectionStateCopyWithImpl<$Res, $Val extends ActionSectionState>
    implements $ActionSectionStateCopyWith<$Res> {
  _$ActionSectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ActionSectionStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ActionSectionState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool shouldSectionBeVisible) sectionVisibility,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool shouldSectionBeVisible)? sectionVisibility,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool shouldSectionBeVisible)? sectionVisibility,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SectionVisibility value) sectionVisibility,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SectionVisibility value)? sectionVisibility,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SectionVisibility value)? sectionVisibility,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements ActionSectionState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SectionVisibilityImplCopyWith<$Res> {
  factory _$$SectionVisibilityImplCopyWith(_$SectionVisibilityImpl value,
          $Res Function(_$SectionVisibilityImpl) then) =
      __$$SectionVisibilityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool shouldSectionBeVisible});
}

/// @nodoc
class __$$SectionVisibilityImplCopyWithImpl<$Res>
    extends _$ActionSectionStateCopyWithImpl<$Res, _$SectionVisibilityImpl>
    implements _$$SectionVisibilityImplCopyWith<$Res> {
  __$$SectionVisibilityImplCopyWithImpl(_$SectionVisibilityImpl _value,
      $Res Function(_$SectionVisibilityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shouldSectionBeVisible = null,
  }) {
    return _then(_$SectionVisibilityImpl(
      null == shouldSectionBeVisible
          ? _value.shouldSectionBeVisible
          : shouldSectionBeVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SectionVisibilityImpl implements SectionVisibility {
  const _$SectionVisibilityImpl(this.shouldSectionBeVisible);

  @override
  final bool shouldSectionBeVisible;

  @override
  String toString() {
    return 'ActionSectionState.sectionVisibility(shouldSectionBeVisible: $shouldSectionBeVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionVisibilityImpl &&
            (identical(other.shouldSectionBeVisible, shouldSectionBeVisible) ||
                other.shouldSectionBeVisible == shouldSectionBeVisible));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shouldSectionBeVisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionVisibilityImplCopyWith<_$SectionVisibilityImpl> get copyWith =>
      __$$SectionVisibilityImplCopyWithImpl<_$SectionVisibilityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool shouldSectionBeVisible) sectionVisibility,
  }) {
    return sectionVisibility(shouldSectionBeVisible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool shouldSectionBeVisible)? sectionVisibility,
  }) {
    return sectionVisibility?.call(shouldSectionBeVisible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool shouldSectionBeVisible)? sectionVisibility,
    required TResult orElse(),
  }) {
    if (sectionVisibility != null) {
      return sectionVisibility(shouldSectionBeVisible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(SectionVisibility value) sectionVisibility,
  }) {
    return sectionVisibility(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(SectionVisibility value)? sectionVisibility,
  }) {
    return sectionVisibility?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(SectionVisibility value)? sectionVisibility,
    required TResult orElse(),
  }) {
    if (sectionVisibility != null) {
      return sectionVisibility(this);
    }
    return orElse();
  }
}

abstract class SectionVisibility implements ActionSectionState {
  const factory SectionVisibility(final bool shouldSectionBeVisible) =
      _$SectionVisibilityImpl;

  bool get shouldSectionBeVisible;
  @JsonKey(ignore: true)
  _$$SectionVisibilityImplCopyWith<_$SectionVisibilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
