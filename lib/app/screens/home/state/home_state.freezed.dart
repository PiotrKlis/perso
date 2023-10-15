// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() navigateToSignIn,
    required TResult Function() navigateToClientProfile,
    required TResult Function() navigateToTrainerProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? navigateToSignIn,
    TResult? Function()? navigateToClientProfile,
    TResult? Function()? navigateToTrainerProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? navigateToSignIn,
    TResult Function()? navigateToClientProfile,
    TResult Function()? navigateToTrainerProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(NavigateToSignIn value) navigateToSignIn,
    required TResult Function(NavigateToClientProfile value)
        navigateToClientProfile,
    required TResult Function(NaviagteToTrainerProfile value)
        navigateToTrainerProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(NavigateToSignIn value)? navigateToSignIn,
    TResult? Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult? Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(NavigateToSignIn value)? navigateToSignIn,
    TResult Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

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
    extends _$HomeStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'HomeState.initial()';
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
    required TResult Function() navigateToSignIn,
    required TResult Function() navigateToClientProfile,
    required TResult Function() navigateToTrainerProfile,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? navigateToSignIn,
    TResult? Function()? navigateToClientProfile,
    TResult? Function()? navigateToTrainerProfile,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? navigateToSignIn,
    TResult Function()? navigateToClientProfile,
    TResult Function()? navigateToTrainerProfile,
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
    required TResult Function(NavigateToSignIn value) navigateToSignIn,
    required TResult Function(NavigateToClientProfile value)
        navigateToClientProfile,
    required TResult Function(NaviagteToTrainerProfile value)
        navigateToTrainerProfile,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(NavigateToSignIn value)? navigateToSignIn,
    TResult? Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult? Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(NavigateToSignIn value)? navigateToSignIn,
    TResult Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements HomeState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$NavigateToSignInImplCopyWith<$Res> {
  factory _$$NavigateToSignInImplCopyWith(_$NavigateToSignInImpl value,
          $Res Function(_$NavigateToSignInImpl) then) =
      __$$NavigateToSignInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToSignInImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$NavigateToSignInImpl>
    implements _$$NavigateToSignInImplCopyWith<$Res> {
  __$$NavigateToSignInImplCopyWithImpl(_$NavigateToSignInImpl _value,
      $Res Function(_$NavigateToSignInImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NavigateToSignInImpl implements NavigateToSignIn {
  const _$NavigateToSignInImpl();

  @override
  String toString() {
    return 'HomeState.navigateToSignIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NavigateToSignInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() navigateToSignIn,
    required TResult Function() navigateToClientProfile,
    required TResult Function() navigateToTrainerProfile,
  }) {
    return navigateToSignIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? navigateToSignIn,
    TResult? Function()? navigateToClientProfile,
    TResult? Function()? navigateToTrainerProfile,
  }) {
    return navigateToSignIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? navigateToSignIn,
    TResult Function()? navigateToClientProfile,
    TResult Function()? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToSignIn != null) {
      return navigateToSignIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(NavigateToSignIn value) navigateToSignIn,
    required TResult Function(NavigateToClientProfile value)
        navigateToClientProfile,
    required TResult Function(NaviagteToTrainerProfile value)
        navigateToTrainerProfile,
  }) {
    return navigateToSignIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(NavigateToSignIn value)? navigateToSignIn,
    TResult? Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult? Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
  }) {
    return navigateToSignIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(NavigateToSignIn value)? navigateToSignIn,
    TResult Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToSignIn != null) {
      return navigateToSignIn(this);
    }
    return orElse();
  }
}

abstract class NavigateToSignIn implements HomeState {
  const factory NavigateToSignIn() = _$NavigateToSignInImpl;
}

/// @nodoc
abstract class _$$NavigateToClientProfileImplCopyWith<$Res> {
  factory _$$NavigateToClientProfileImplCopyWith(
          _$NavigateToClientProfileImpl value,
          $Res Function(_$NavigateToClientProfileImpl) then) =
      __$$NavigateToClientProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToClientProfileImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$NavigateToClientProfileImpl>
    implements _$$NavigateToClientProfileImplCopyWith<$Res> {
  __$$NavigateToClientProfileImplCopyWithImpl(
      _$NavigateToClientProfileImpl _value,
      $Res Function(_$NavigateToClientProfileImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NavigateToClientProfileImpl implements NavigateToClientProfile {
  const _$NavigateToClientProfileImpl();

  @override
  String toString() {
    return 'HomeState.navigateToClientProfile()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigateToClientProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() navigateToSignIn,
    required TResult Function() navigateToClientProfile,
    required TResult Function() navigateToTrainerProfile,
  }) {
    return navigateToClientProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? navigateToSignIn,
    TResult? Function()? navigateToClientProfile,
    TResult? Function()? navigateToTrainerProfile,
  }) {
    return navigateToClientProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? navigateToSignIn,
    TResult Function()? navigateToClientProfile,
    TResult Function()? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToClientProfile != null) {
      return navigateToClientProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(NavigateToSignIn value) navigateToSignIn,
    required TResult Function(NavigateToClientProfile value)
        navigateToClientProfile,
    required TResult Function(NaviagteToTrainerProfile value)
        navigateToTrainerProfile,
  }) {
    return navigateToClientProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(NavigateToSignIn value)? navigateToSignIn,
    TResult? Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult? Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
  }) {
    return navigateToClientProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(NavigateToSignIn value)? navigateToSignIn,
    TResult Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToClientProfile != null) {
      return navigateToClientProfile(this);
    }
    return orElse();
  }
}

abstract class NavigateToClientProfile implements HomeState {
  const factory NavigateToClientProfile() = _$NavigateToClientProfileImpl;
}

/// @nodoc
abstract class _$$NaviagteToTrainerProfileImplCopyWith<$Res> {
  factory _$$NaviagteToTrainerProfileImplCopyWith(
          _$NaviagteToTrainerProfileImpl value,
          $Res Function(_$NaviagteToTrainerProfileImpl) then) =
      __$$NaviagteToTrainerProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NaviagteToTrainerProfileImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$NaviagteToTrainerProfileImpl>
    implements _$$NaviagteToTrainerProfileImplCopyWith<$Res> {
  __$$NaviagteToTrainerProfileImplCopyWithImpl(
      _$NaviagteToTrainerProfileImpl _value,
      $Res Function(_$NaviagteToTrainerProfileImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NaviagteToTrainerProfileImpl implements NaviagteToTrainerProfile {
  const _$NaviagteToTrainerProfileImpl();

  @override
  String toString() {
    return 'HomeState.navigateToTrainerProfile()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NaviagteToTrainerProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() navigateToSignIn,
    required TResult Function() navigateToClientProfile,
    required TResult Function() navigateToTrainerProfile,
  }) {
    return navigateToTrainerProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? navigateToSignIn,
    TResult? Function()? navigateToClientProfile,
    TResult? Function()? navigateToTrainerProfile,
  }) {
    return navigateToTrainerProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? navigateToSignIn,
    TResult Function()? navigateToClientProfile,
    TResult Function()? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToTrainerProfile != null) {
      return navigateToTrainerProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(NavigateToSignIn value) navigateToSignIn,
    required TResult Function(NavigateToClientProfile value)
        navigateToClientProfile,
    required TResult Function(NaviagteToTrainerProfile value)
        navigateToTrainerProfile,
  }) {
    return navigateToTrainerProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(NavigateToSignIn value)? navigateToSignIn,
    TResult? Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult? Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
  }) {
    return navigateToTrainerProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(NavigateToSignIn value)? navigateToSignIn,
    TResult Function(NavigateToClientProfile value)? navigateToClientProfile,
    TResult Function(NaviagteToTrainerProfile value)? navigateToTrainerProfile,
    required TResult orElse(),
  }) {
    if (navigateToTrainerProfile != null) {
      return navigateToTrainerProfile(this);
    }
    return orElse();
  }
}

abstract class NaviagteToTrainerProfile implements HomeState {
  const factory NaviagteToTrainerProfile() = _$NaviagteToTrainerProfileImpl;
}
