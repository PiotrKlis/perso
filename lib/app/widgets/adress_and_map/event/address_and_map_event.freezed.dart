// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_and_map_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddressAndMapEvent {
  LatLng get latLng => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng latLng) updateMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng latLng)? updateMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng latLng)? updateMap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateMap value) updateMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateMap value)? updateMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateMap value)? updateMap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressAndMapEventCopyWith<AddressAndMapEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressAndMapEventCopyWith<$Res> {
  factory $AddressAndMapEventCopyWith(
          AddressAndMapEvent value, $Res Function(AddressAndMapEvent) then) =
      _$AddressAndMapEventCopyWithImpl<$Res, AddressAndMapEvent>;
  @useResult
  $Res call({LatLng latLng});
}

/// @nodoc
class _$AddressAndMapEventCopyWithImpl<$Res, $Val extends AddressAndMapEvent>
    implements $AddressAndMapEventCopyWith<$Res> {
  _$AddressAndMapEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latLng = null,
  }) {
    return _then(_value.copyWith(
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateMapImplCopyWith<$Res>
    implements $AddressAndMapEventCopyWith<$Res> {
  factory _$$UpdateMapImplCopyWith(
          _$UpdateMapImpl value, $Res Function(_$UpdateMapImpl) then) =
      __$$UpdateMapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng latLng});
}

/// @nodoc
class __$$UpdateMapImplCopyWithImpl<$Res>
    extends _$AddressAndMapEventCopyWithImpl<$Res, _$UpdateMapImpl>
    implements _$$UpdateMapImplCopyWith<$Res> {
  __$$UpdateMapImplCopyWithImpl(
      _$UpdateMapImpl _value, $Res Function(_$UpdateMapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latLng = null,
  }) {
    return _then(_$UpdateMapImpl(
      null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _$UpdateMapImpl implements UpdateMap {
  const _$UpdateMapImpl(this.latLng);

  @override
  final LatLng latLng;

  @override
  String toString() {
    return 'AddressAndMapEvent.updateMap(latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMapImpl &&
            (identical(other.latLng, latLng) || other.latLng == latLng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMapImplCopyWith<_$UpdateMapImpl> get copyWith =>
      __$$UpdateMapImplCopyWithImpl<_$UpdateMapImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng latLng) updateMap,
  }) {
    return updateMap(latLng);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng latLng)? updateMap,
  }) {
    return updateMap?.call(latLng);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng latLng)? updateMap,
    required TResult orElse(),
  }) {
    if (updateMap != null) {
      return updateMap(latLng);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateMap value) updateMap,
  }) {
    return updateMap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateMap value)? updateMap,
  }) {
    return updateMap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateMap value)? updateMap,
    required TResult orElse(),
  }) {
    if (updateMap != null) {
      return updateMap(this);
    }
    return orElse();
  }
}

abstract class UpdateMap implements AddressAndMapEvent {
  const factory UpdateMap(final LatLng latLng) = _$UpdateMapImpl;

  @override
  LatLng get latLng;
  @override
  @JsonKey(ignore: true)
  _$$UpdateMapImplCopyWith<_$UpdateMapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
