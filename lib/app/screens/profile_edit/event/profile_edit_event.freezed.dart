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
    required TResult Function(EditableTrainerData trainerData)
        uploadTrainerData,
    required TResult Function(EditableClientData clientData) uploadClientData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult? Function(EditableClientData clientData)? uploadClientData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult Function(EditableClientData clientData)? uploadClientData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadTrainerData value) uploadTrainerData,
    required TResult Function(UploadClientData value) uploadClientData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadTrainerData value)? uploadTrainerData,
    TResult? Function(UploadClientData value)? uploadClientData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadTrainerData value)? uploadTrainerData,
    TResult Function(UploadClientData value)? uploadClientData,
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
abstract class _$$UploadTrainerDataImplCopyWith<$Res> {
  factory _$$UploadTrainerDataImplCopyWith(_$UploadTrainerDataImpl value,
          $Res Function(_$UploadTrainerDataImpl) then) =
      __$$UploadTrainerDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EditableTrainerData trainerData});

  $EditableTrainerDataCopyWith<$Res> get trainerData;
}

/// @nodoc
class __$$UploadTrainerDataImplCopyWithImpl<$Res>
    extends _$ProfileEditEventCopyWithImpl<$Res, _$UploadTrainerDataImpl>
    implements _$$UploadTrainerDataImplCopyWith<$Res> {
  __$$UploadTrainerDataImplCopyWithImpl(_$UploadTrainerDataImpl _value,
      $Res Function(_$UploadTrainerDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainerData = null,
  }) {
    return _then(_$UploadTrainerDataImpl(
      null == trainerData
          ? _value.trainerData
          : trainerData // ignore: cast_nullable_to_non_nullable
              as EditableTrainerData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $EditableTrainerDataCopyWith<$Res> get trainerData {
    return $EditableTrainerDataCopyWith<$Res>(_value.trainerData, (value) {
      return _then(_value.copyWith(trainerData: value));
    });
  }
}

/// @nodoc

class _$UploadTrainerDataImpl implements UploadTrainerData {
  const _$UploadTrainerDataImpl(this.trainerData);

  @override
  final EditableTrainerData trainerData;

  @override
  String toString() {
    return 'ProfileEditEvent.uploadTrainerData(trainerData: $trainerData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadTrainerDataImpl &&
            (identical(other.trainerData, trainerData) ||
                other.trainerData == trainerData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trainerData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadTrainerDataImplCopyWith<_$UploadTrainerDataImpl> get copyWith =>
      __$$UploadTrainerDataImplCopyWithImpl<_$UploadTrainerDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EditableTrainerData trainerData)
        uploadTrainerData,
    required TResult Function(EditableClientData clientData) uploadClientData,
  }) {
    return uploadTrainerData(trainerData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult? Function(EditableClientData clientData)? uploadClientData,
  }) {
    return uploadTrainerData?.call(trainerData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult Function(EditableClientData clientData)? uploadClientData,
    required TResult orElse(),
  }) {
    if (uploadTrainerData != null) {
      return uploadTrainerData(trainerData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadTrainerData value) uploadTrainerData,
    required TResult Function(UploadClientData value) uploadClientData,
  }) {
    return uploadTrainerData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadTrainerData value)? uploadTrainerData,
    TResult? Function(UploadClientData value)? uploadClientData,
  }) {
    return uploadTrainerData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadTrainerData value)? uploadTrainerData,
    TResult Function(UploadClientData value)? uploadClientData,
    required TResult orElse(),
  }) {
    if (uploadTrainerData != null) {
      return uploadTrainerData(this);
    }
    return orElse();
  }
}

abstract class UploadTrainerData implements ProfileEditEvent {
  const factory UploadTrainerData(final EditableTrainerData trainerData) =
      _$UploadTrainerDataImpl;

  EditableTrainerData get trainerData;
  @JsonKey(ignore: true)
  _$$UploadTrainerDataImplCopyWith<_$UploadTrainerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadClientDataImplCopyWith<$Res> {
  factory _$$UploadClientDataImplCopyWith(_$UploadClientDataImpl value,
          $Res Function(_$UploadClientDataImpl) then) =
      __$$UploadClientDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EditableClientData clientData});

  $EditableClientDataCopyWith<$Res> get clientData;
}

/// @nodoc
class __$$UploadClientDataImplCopyWithImpl<$Res>
    extends _$ProfileEditEventCopyWithImpl<$Res, _$UploadClientDataImpl>
    implements _$$UploadClientDataImplCopyWith<$Res> {
  __$$UploadClientDataImplCopyWithImpl(_$UploadClientDataImpl _value,
      $Res Function(_$UploadClientDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientData = null,
  }) {
    return _then(_$UploadClientDataImpl(
      null == clientData
          ? _value.clientData
          : clientData // ignore: cast_nullable_to_non_nullable
              as EditableClientData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $EditableClientDataCopyWith<$Res> get clientData {
    return $EditableClientDataCopyWith<$Res>(_value.clientData, (value) {
      return _then(_value.copyWith(clientData: value));
    });
  }
}

/// @nodoc

class _$UploadClientDataImpl implements UploadClientData {
  const _$UploadClientDataImpl(this.clientData);

  @override
  final EditableClientData clientData;

  @override
  String toString() {
    return 'ProfileEditEvent.uploadClientData(clientData: $clientData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadClientDataImpl &&
            (identical(other.clientData, clientData) ||
                other.clientData == clientData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadClientDataImplCopyWith<_$UploadClientDataImpl> get copyWith =>
      __$$UploadClientDataImplCopyWithImpl<_$UploadClientDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EditableTrainerData trainerData)
        uploadTrainerData,
    required TResult Function(EditableClientData clientData) uploadClientData,
  }) {
    return uploadClientData(clientData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult? Function(EditableClientData clientData)? uploadClientData,
  }) {
    return uploadClientData?.call(clientData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EditableTrainerData trainerData)? uploadTrainerData,
    TResult Function(EditableClientData clientData)? uploadClientData,
    required TResult orElse(),
  }) {
    if (uploadClientData != null) {
      return uploadClientData(clientData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UploadTrainerData value) uploadTrainerData,
    required TResult Function(UploadClientData value) uploadClientData,
  }) {
    return uploadClientData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UploadTrainerData value)? uploadTrainerData,
    TResult? Function(UploadClientData value)? uploadClientData,
  }) {
    return uploadClientData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UploadTrainerData value)? uploadTrainerData,
    TResult Function(UploadClientData value)? uploadClientData,
    required TResult orElse(),
  }) {
    if (uploadClientData != null) {
      return uploadClientData(this);
    }
    return orElse();
  }
}

abstract class UploadClientData implements ProfileEditEvent {
  const factory UploadClientData(final EditableClientData clientData) =
      _$UploadClientDataImpl;

  EditableClientData get clientData;
  @JsonKey(ignore: true)
  _$$UploadClientDataImplCopyWith<_$UploadClientDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
