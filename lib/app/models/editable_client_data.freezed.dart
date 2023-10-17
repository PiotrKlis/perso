// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editable_client_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditableClientData {
  String get imagePath => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditableClientDataCopyWith<EditableClientData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditableClientDataCopyWith<$Res> {
  factory $EditableClientDataCopyWith(
          EditableClientData value, $Res Function(EditableClientData) then) =
      _$EditableClientDataCopyWithImpl<$Res, EditableClientData>;
  @useResult
  $Res call(
      {String imagePath,
      String name,
      String surname,
      String nickname,
      String location});
}

/// @nodoc
class _$EditableClientDataCopyWithImpl<$Res, $Val extends EditableClientData>
    implements $EditableClientDataCopyWith<$Res> {
  _$EditableClientDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditableClientDataImplCopyWith<$Res>
    implements $EditableClientDataCopyWith<$Res> {
  factory _$$EditableClientDataImplCopyWith(_$EditableClientDataImpl value,
          $Res Function(_$EditableClientDataImpl) then) =
      __$$EditableClientDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String imagePath,
      String name,
      String surname,
      String nickname,
      String location});
}

/// @nodoc
class __$$EditableClientDataImplCopyWithImpl<$Res>
    extends _$EditableClientDataCopyWithImpl<$Res, _$EditableClientDataImpl>
    implements _$$EditableClientDataImplCopyWith<$Res> {
  __$$EditableClientDataImplCopyWithImpl(_$EditableClientDataImpl _value,
      $Res Function(_$EditableClientDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? location = null,
  }) {
    return _then(_$EditableClientDataImpl(
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditableClientDataImpl implements _EditableClientData {
  const _$EditableClientDataImpl(
      {required this.imagePath,
      required this.name,
      required this.surname,
      required this.nickname,
      required this.location});

  @override
  final String imagePath;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String nickname;
  @override
  final String location;

  @override
  String toString() {
    return 'EditableClientData(imagePath: $imagePath, name: $name, surname: $surname, nickname: $nickname, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditableClientDataImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, imagePath, name, surname, nickname, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditableClientDataImplCopyWith<_$EditableClientDataImpl> get copyWith =>
      __$$EditableClientDataImplCopyWithImpl<_$EditableClientDataImpl>(
          this, _$identity);
}

abstract class _EditableClientData implements EditableClientData {
  const factory _EditableClientData(
      {required final String imagePath,
      required final String name,
      required final String surname,
      required final String nickname,
      required final String location}) = _$EditableClientDataImpl;

  @override
  String get imagePath;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get nickname;
  @override
  String get location;
  @override
  @JsonKey(ignore: true)
  _$$EditableClientDataImplCopyWith<_$EditableClientDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
