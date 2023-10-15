// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PlaceInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlaceInfo {
  String get address => throw _privateConstructorUsedError;
  LatLng get latLng => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceInfoCopyWith<PlaceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceInfoCopyWith<$Res> {
  factory $PlaceInfoCopyWith(PlaceInfo value, $Res Function(PlaceInfo) then) =
      _$PlaceInfoCopyWithImpl<$Res, PlaceInfo>;
  @useResult
  $Res call({String address, LatLng latLng});
}

/// @nodoc
class _$PlaceInfoCopyWithImpl<$Res, $Val extends PlaceInfo>
    implements $PlaceInfoCopyWith<$Res> {
  _$PlaceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? latLng = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaceInfoImplCopyWith<$Res>
    implements $PlaceInfoCopyWith<$Res> {
  factory _$$PlaceInfoImplCopyWith(
          _$PlaceInfoImpl value, $Res Function(_$PlaceInfoImpl) then) =
      __$$PlaceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, LatLng latLng});
}

/// @nodoc
class __$$PlaceInfoImplCopyWithImpl<$Res>
    extends _$PlaceInfoCopyWithImpl<$Res, _$PlaceInfoImpl>
    implements _$$PlaceInfoImplCopyWith<$Res> {
  __$$PlaceInfoImplCopyWithImpl(
      _$PlaceInfoImpl _value, $Res Function(_$PlaceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? latLng = null,
  }) {
    return _then(_$PlaceInfoImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _$PlaceInfoImpl implements _PlaceInfo {
  const _$PlaceInfoImpl({required this.address, required this.latLng});

  @override
  final String address;
  @override
  final LatLng latLng;

  @override
  String toString() {
    return 'PlaceInfo(address: $address, latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceInfoImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latLng, latLng) || other.latLng == latLng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, latLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceInfoImplCopyWith<_$PlaceInfoImpl> get copyWith =>
      __$$PlaceInfoImplCopyWithImpl<_$PlaceInfoImpl>(this, _$identity);
}

abstract class _PlaceInfo implements PlaceInfo {
  const factory _PlaceInfo(
      {required final String address,
      required final LatLng latLng}) = _$PlaceInfoImpl;

  @override
  String get address;
  @override
  LatLng get latLng;
  @override
  @JsonKey(ignore: true)
  _$$PlaceInfoImplCopyWith<_$PlaceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
