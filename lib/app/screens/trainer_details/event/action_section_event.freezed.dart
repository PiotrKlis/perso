// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_section_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActionSectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() shouldSectionBeVisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? shouldSectionBeVisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? shouldSectionBeVisible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShouldSectionBeVisible value)
        shouldSectionBeVisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShouldSectionBeVisible value)? shouldSectionBeVisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShouldSectionBeVisible value)? shouldSectionBeVisible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionSectionEventCopyWith<$Res> {
  factory $ActionSectionEventCopyWith(
          ActionSectionEvent value, $Res Function(ActionSectionEvent) then) =
      _$ActionSectionEventCopyWithImpl<$Res, ActionSectionEvent>;
}

/// @nodoc
class _$ActionSectionEventCopyWithImpl<$Res, $Val extends ActionSectionEvent>
    implements $ActionSectionEventCopyWith<$Res> {
  _$ActionSectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ShouldSectionBeVisibleCopyWith<$Res> {
  factory _$$ShouldSectionBeVisibleCopyWith(_$ShouldSectionBeVisible value,
          $Res Function(_$ShouldSectionBeVisible) then) =
      __$$ShouldSectionBeVisibleCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShouldSectionBeVisibleCopyWithImpl<$Res>
    extends _$ActionSectionEventCopyWithImpl<$Res, _$ShouldSectionBeVisible>
    implements _$$ShouldSectionBeVisibleCopyWith<$Res> {
  __$$ShouldSectionBeVisibleCopyWithImpl(_$ShouldSectionBeVisible _value,
      $Res Function(_$ShouldSectionBeVisible) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ShouldSectionBeVisible implements ShouldSectionBeVisible {
  const _$ShouldSectionBeVisible();

  @override
  String toString() {
    return 'ActionSectionEvent.shouldSectionBeVisible()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShouldSectionBeVisible);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() shouldSectionBeVisible,
  }) {
    return shouldSectionBeVisible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? shouldSectionBeVisible,
  }) {
    return shouldSectionBeVisible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? shouldSectionBeVisible,
    required TResult orElse(),
  }) {
    if (shouldSectionBeVisible != null) {
      return shouldSectionBeVisible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShouldSectionBeVisible value)
        shouldSectionBeVisible,
  }) {
    return shouldSectionBeVisible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShouldSectionBeVisible value)? shouldSectionBeVisible,
  }) {
    return shouldSectionBeVisible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShouldSectionBeVisible value)? shouldSectionBeVisible,
    required TResult orElse(),
  }) {
    if (shouldSectionBeVisible != null) {
      return shouldSectionBeVisible(this);
    }
    return orElse();
  }
}

abstract class ShouldSectionBeVisible implements ActionSectionEvent {
  const factory ShouldSectionBeVisible() = _$ShouldSectionBeVisible;
}
