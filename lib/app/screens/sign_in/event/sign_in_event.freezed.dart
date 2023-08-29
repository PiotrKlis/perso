// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignInEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
    required TResult Function() checkIsProfileCreated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
    TResult? Function()? checkIsProfileCreated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    TResult Function()? checkIsProfileCreated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init value) init,
    required TResult Function(Login value) login,
    required TResult Function(CheckIsProfileCreated value)
        checkIsProfileCreated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init value)? init,
    TResult? Function(Login value)? login,
    TResult? Function(CheckIsProfileCreated value)? checkIsProfileCreated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init value)? init,
    TResult Function(Login value)? login,
    TResult Function(CheckIsProfileCreated value)? checkIsProfileCreated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInEventCopyWith<$Res> {
  factory $SignInEventCopyWith(
          SignInEvent value, $Res Function(SignInEvent) then) =
      _$SignInEventCopyWithImpl<$Res, SignInEvent>;
}

/// @nodoc
class _$SignInEventCopyWithImpl<$Res, $Val extends SignInEvent>
    implements $SignInEventCopyWith<$Res> {
  _$SignInEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitCopyWith<$Res> {
  factory _$$InitCopyWith(_$Init value, $Res Function(_$Init) then) =
      __$$InitCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitCopyWithImpl<$Res> extends _$SignInEventCopyWithImpl<$Res, _$Init>
    implements _$$InitCopyWith<$Res> {
  __$$InitCopyWithImpl(_$Init _value, $Res Function(_$Init) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Init implements Init {
  const _$Init();

  @override
  String toString() {
    return 'SignInEvent.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Init);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
    required TResult Function() checkIsProfileCreated,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
    TResult? Function()? checkIsProfileCreated,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    TResult Function()? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init value) init,
    required TResult Function(Login value) login,
    required TResult Function(CheckIsProfileCreated value)
        checkIsProfileCreated,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init value)? init,
    TResult? Function(Login value)? login,
    TResult? Function(CheckIsProfileCreated value)? checkIsProfileCreated,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init value)? init,
    TResult Function(Login value)? login,
    TResult Function(CheckIsProfileCreated value)? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class Init implements SignInEvent {
  const factory Init() = _$Init;
}

/// @nodoc
abstract class _$$LoginCopyWith<$Res> {
  factory _$$LoginCopyWith(_$Login value, $Res Function(_$Login) then) =
      __$$LoginCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginCopyWithImpl<$Res>
    extends _$SignInEventCopyWithImpl<$Res, _$Login>
    implements _$$LoginCopyWith<$Res> {
  __$$LoginCopyWithImpl(_$Login _value, $Res Function(_$Login) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$Login(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Login implements Login {
  const _$Login({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignInEvent.login(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Login &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginCopyWith<_$Login> get copyWith =>
      __$$LoginCopyWithImpl<_$Login>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
    required TResult Function() checkIsProfileCreated,
  }) {
    return login(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
    TResult? Function()? checkIsProfileCreated,
  }) {
    return login?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    TResult Function()? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init value) init,
    required TResult Function(Login value) login,
    required TResult Function(CheckIsProfileCreated value)
        checkIsProfileCreated,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init value)? init,
    TResult? Function(Login value)? login,
    TResult? Function(CheckIsProfileCreated value)? checkIsProfileCreated,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init value)? init,
    TResult Function(Login value)? login,
    TResult Function(CheckIsProfileCreated value)? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class Login implements SignInEvent {
  const factory Login(
      {required final String email, required final String password}) = _$Login;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$LoginCopyWith<_$Login> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckIsProfileCreatedCopyWith<$Res> {
  factory _$$CheckIsProfileCreatedCopyWith(_$CheckIsProfileCreated value,
          $Res Function(_$CheckIsProfileCreated) then) =
      __$$CheckIsProfileCreatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckIsProfileCreatedCopyWithImpl<$Res>
    extends _$SignInEventCopyWithImpl<$Res, _$CheckIsProfileCreated>
    implements _$$CheckIsProfileCreatedCopyWith<$Res> {
  __$$CheckIsProfileCreatedCopyWithImpl(_$CheckIsProfileCreated _value,
      $Res Function(_$CheckIsProfileCreated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckIsProfileCreated implements CheckIsProfileCreated {
  const _$CheckIsProfileCreated();

  @override
  String toString() {
    return 'SignInEvent.checkIsProfileCreated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckIsProfileCreated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
    required TResult Function() checkIsProfileCreated,
  }) {
    return checkIsProfileCreated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
    TResult? Function()? checkIsProfileCreated,
  }) {
    return checkIsProfileCreated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    TResult Function()? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (checkIsProfileCreated != null) {
      return checkIsProfileCreated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init value) init,
    required TResult Function(Login value) login,
    required TResult Function(CheckIsProfileCreated value)
        checkIsProfileCreated,
  }) {
    return checkIsProfileCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init value)? init,
    TResult? Function(Login value)? login,
    TResult? Function(CheckIsProfileCreated value)? checkIsProfileCreated,
  }) {
    return checkIsProfileCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init value)? init,
    TResult Function(Login value)? login,
    TResult Function(CheckIsProfileCreated value)? checkIsProfileCreated,
    required TResult orElse(),
  }) {
    if (checkIsProfileCreated != null) {
      return checkIsProfileCreated(this);
    }
    return orElse();
  }
}

abstract class CheckIsProfileCreated implements SignInEvent {
  const factory CheckIsProfileCreated() = _$CheckIsProfileCreated;
}
