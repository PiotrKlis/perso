// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_request_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingRequestEvent {
  String get trainerId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) trainingRequest,
    required TResult Function(String trainerId)
        checkIfUserHasAlreadyRequestTraining,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? trainingRequest,
    TResult? Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? trainingRequest,
    TResult Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrainingRequest value) trainingRequest,
    required TResult Function(CheckIfUserHasAlreadyRequestTraining value)
        checkIfUserHasAlreadyRequestTraining,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrainingRequest value)? trainingRequest,
    TResult? Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrainingRequest value)? trainingRequest,
    TResult Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingRequestEventCopyWith<TrainingRequestEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingRequestEventCopyWith<$Res> {
  factory $TrainingRequestEventCopyWith(TrainingRequestEvent value,
          $Res Function(TrainingRequestEvent) then) =
      _$TrainingRequestEventCopyWithImpl<$Res, TrainingRequestEvent>;
  @useResult
  $Res call({String trainerId});
}

/// @nodoc
class _$TrainingRequestEventCopyWithImpl<$Res,
        $Val extends TrainingRequestEvent>
    implements $TrainingRequestEventCopyWith<$Res> {
  _$TrainingRequestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainerId = null,
  }) {
    return _then(_value.copyWith(
      trainerId: null == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingRequestCopyWith<$Res>
    implements $TrainingRequestEventCopyWith<$Res> {
  factory _$$TrainingRequestCopyWith(
          _$TrainingRequest value, $Res Function(_$TrainingRequest) then) =
      __$$TrainingRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String trainerId});
}

/// @nodoc
class __$$TrainingRequestCopyWithImpl<$Res>
    extends _$TrainingRequestEventCopyWithImpl<$Res, _$TrainingRequest>
    implements _$$TrainingRequestCopyWith<$Res> {
  __$$TrainingRequestCopyWithImpl(
      _$TrainingRequest _value, $Res Function(_$TrainingRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainerId = null,
  }) {
    return _then(_$TrainingRequest(
      null == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TrainingRequest implements TrainingRequest {
  const _$TrainingRequest(this.trainerId);

  @override
  final String trainerId;

  @override
  String toString() {
    return 'TrainingRequestEvent.trainingRequest(trainerId: $trainerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingRequest &&
            (identical(other.trainerId, trainerId) ||
                other.trainerId == trainerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trainerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingRequestCopyWith<_$TrainingRequest> get copyWith =>
      __$$TrainingRequestCopyWithImpl<_$TrainingRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) trainingRequest,
    required TResult Function(String trainerId)
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return trainingRequest(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? trainingRequest,
    TResult? Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
  }) {
    return trainingRequest?.call(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? trainingRequest,
    TResult Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) {
    if (trainingRequest != null) {
      return trainingRequest(trainerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrainingRequest value) trainingRequest,
    required TResult Function(CheckIfUserHasAlreadyRequestTraining value)
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return trainingRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrainingRequest value)? trainingRequest,
    TResult? Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return trainingRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrainingRequest value)? trainingRequest,
    TResult Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) {
    if (trainingRequest != null) {
      return trainingRequest(this);
    }
    return orElse();
  }
}

abstract class TrainingRequest implements TrainingRequestEvent {
  const factory TrainingRequest(final String trainerId) = _$TrainingRequest;

  @override
  String get trainerId;
  @override
  @JsonKey(ignore: true)
  _$$TrainingRequestCopyWith<_$TrainingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckIfUserHasAlreadyRequestTrainingCopyWith<$Res>
    implements $TrainingRequestEventCopyWith<$Res> {
  factory _$$CheckIfUserHasAlreadyRequestTrainingCopyWith(
          _$CheckIfUserHasAlreadyRequestTraining value,
          $Res Function(_$CheckIfUserHasAlreadyRequestTraining) then) =
      __$$CheckIfUserHasAlreadyRequestTrainingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String trainerId});
}

/// @nodoc
class __$$CheckIfUserHasAlreadyRequestTrainingCopyWithImpl<$Res>
    extends _$TrainingRequestEventCopyWithImpl<$Res,
        _$CheckIfUserHasAlreadyRequestTraining>
    implements _$$CheckIfUserHasAlreadyRequestTrainingCopyWith<$Res> {
  __$$CheckIfUserHasAlreadyRequestTrainingCopyWithImpl(
      _$CheckIfUserHasAlreadyRequestTraining _value,
      $Res Function(_$CheckIfUserHasAlreadyRequestTraining) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainerId = null,
  }) {
    return _then(_$CheckIfUserHasAlreadyRequestTraining(
      null == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckIfUserHasAlreadyRequestTraining
    implements CheckIfUserHasAlreadyRequestTraining {
  const _$CheckIfUserHasAlreadyRequestTraining(this.trainerId);

  @override
  final String trainerId;

  @override
  String toString() {
    return 'TrainingRequestEvent.checkIfUserHasAlreadyRequestTraining(trainerId: $trainerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckIfUserHasAlreadyRequestTraining &&
            (identical(other.trainerId, trainerId) ||
                other.trainerId == trainerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trainerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckIfUserHasAlreadyRequestTrainingCopyWith<
          _$CheckIfUserHasAlreadyRequestTraining>
      get copyWith => __$$CheckIfUserHasAlreadyRequestTrainingCopyWithImpl<
          _$CheckIfUserHasAlreadyRequestTraining>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) trainingRequest,
    required TResult Function(String trainerId)
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return checkIfUserHasAlreadyRequestTraining(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? trainingRequest,
    TResult? Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
  }) {
    return checkIfUserHasAlreadyRequestTraining?.call(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? trainingRequest,
    TResult Function(String trainerId)? checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) {
    if (checkIfUserHasAlreadyRequestTraining != null) {
      return checkIfUserHasAlreadyRequestTraining(trainerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TrainingRequest value) trainingRequest,
    required TResult Function(CheckIfUserHasAlreadyRequestTraining value)
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return checkIfUserHasAlreadyRequestTraining(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TrainingRequest value)? trainingRequest,
    TResult? Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
  }) {
    return checkIfUserHasAlreadyRequestTraining?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TrainingRequest value)? trainingRequest,
    TResult Function(CheckIfUserHasAlreadyRequestTraining value)?
        checkIfUserHasAlreadyRequestTraining,
    required TResult orElse(),
  }) {
    if (checkIfUserHasAlreadyRequestTraining != null) {
      return checkIfUserHasAlreadyRequestTraining(this);
    }
    return orElse();
  }
}

abstract class CheckIfUserHasAlreadyRequestTraining
    implements TrainingRequestEvent {
  const factory CheckIfUserHasAlreadyRequestTraining(final String trainerId) =
      _$CheckIfUserHasAlreadyRequestTraining;

  @override
  String get trainerId;
  @override
  @JsonKey(ignore: true)
  _$$CheckIfUserHasAlreadyRequestTrainingCopyWith<
          _$CheckIfUserHasAlreadyRequestTraining>
      get copyWith => throw _privateConstructorUsedError;
}
