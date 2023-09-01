// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProfileEditEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadData value) uploadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadData value)? uploadData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadData value)? uploadData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEditEventCopyWith<$Res> {
  factory $ProfileEditEventCopyWith(
          ProfileEditEvent value, $Res Function(ProfileEditEvent) then) =
      _$ProfileEditEventCopyWithImpl<$Res, ProfileEditEvent>;
}

/// @nodoc
class _$ProfileEditEventCopyWithImpl<$Res, $Val extends ProfileEditEvent>
    implements $ProfileEditEventCopyWith<$Res> {
  _$ProfileEditEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UploadDataCopyWith<$Res> {
  factory _$$UploadDataCopyWith(
          _$UploadData value, $Res Function(_$UploadData) then) =
      __$$UploadDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UploadDataCopyWithImpl<$Res>
    extends _$ProfileEditEventCopyWithImpl<$Res, _$UploadData>
    implements _$$UploadDataCopyWith<$Res> {
  __$$UploadDataCopyWithImpl(
      _$UploadData _value, $Res Function(_$UploadData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UploadData implements UploadData {
  const _$UploadData();

  @override
  String toString() {
    return 'ProfileEditEvent.uploadData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UploadData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uploadData,
  }) {
    return uploadData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uploadData,
  }) {
    return uploadData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uploadData,
    required TResult orElse(),
  }) {
    if (uploadData != null) {
      return uploadData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadData value) uploadData,
  }) {
    return uploadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadData value)? uploadData,
  }) {
    return uploadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadData value)? uploadData,
    required TResult orElse(),
  }) {
    if (uploadData != null) {
      return uploadData(this);
    }
    return orElse();
  }
}

abstract class UploadData implements ProfileEditEvent {
  const factory UploadData() = _$UploadData;
}
