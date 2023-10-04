// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trainer_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainerDetailsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) loadData,
    required TResult Function() addReview,
    required TResult Function(String trainerId) trainingRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? loadData,
    TResult? Function()? addReview,
    TResult? Function(String trainerId)? trainingRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? loadData,
    TResult Function()? addReview,
    TResult Function(String trainerId)? trainingRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(AddReview value) addReview,
    required TResult Function(TrainingRequest value) trainingRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(AddReview value)? addReview,
    TResult? Function(TrainingRequest value)? trainingRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(AddReview value)? addReview,
    TResult Function(TrainingRequest value)? trainingRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainerDetailsEventCopyWith<$Res> {
  factory $TrainerDetailsEventCopyWith(
          TrainerDetailsEvent value, $Res Function(TrainerDetailsEvent) then) =
      _$TrainerDetailsEventCopyWithImpl<$Res, TrainerDetailsEvent>;
}

/// @nodoc
class _$TrainerDetailsEventCopyWithImpl<$Res, $Val extends TrainerDetailsEvent>
    implements $TrainerDetailsEventCopyWith<$Res> {
  _$TrainerDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadDataCopyWith<$Res> {
  factory _$$LoadDataCopyWith(
          _$LoadData value, $Res Function(_$LoadData) then) =
      __$$LoadDataCopyWithImpl<$Res>;
  @useResult
  $Res call({String trainerId});
}

/// @nodoc
class __$$LoadDataCopyWithImpl<$Res>
    extends _$TrainerDetailsEventCopyWithImpl<$Res, _$LoadData>
    implements _$$LoadDataCopyWith<$Res> {
  __$$LoadDataCopyWithImpl(_$LoadData _value, $Res Function(_$LoadData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainerId = null,
  }) {
    return _then(_$LoadData(
      null == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadData implements LoadData {
  const _$LoadData(this.trainerId);

  @override
  final String trainerId;

  @override
  String toString() {
    return 'TrainerDetailsEvent.loadData(trainerId: $trainerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadData &&
            (identical(other.trainerId, trainerId) ||
                other.trainerId == trainerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trainerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadDataCopyWith<_$LoadData> get copyWith =>
      __$$LoadDataCopyWithImpl<_$LoadData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) loadData,
    required TResult Function() addReview,
    required TResult Function(String trainerId) trainingRequest,
  }) {
    return loadData(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? loadData,
    TResult? Function()? addReview,
    TResult? Function(String trainerId)? trainingRequest,
  }) {
    return loadData?.call(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? loadData,
    TResult Function()? addReview,
    TResult Function(String trainerId)? trainingRequest,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData(trainerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(AddReview value) addReview,
    required TResult Function(TrainingRequest value) trainingRequest,
  }) {
    return loadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(AddReview value)? addReview,
    TResult? Function(TrainingRequest value)? trainingRequest,
  }) {
    return loadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(AddReview value)? addReview,
    TResult Function(TrainingRequest value)? trainingRequest,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData(this);
    }
    return orElse();
  }
}

abstract class LoadData implements TrainerDetailsEvent {
  const factory LoadData(final String trainerId) = _$LoadData;

  String get trainerId;
  @JsonKey(ignore: true)
  _$$LoadDataCopyWith<_$LoadData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddReviewCopyWith<$Res> {
  factory _$$AddReviewCopyWith(
          _$AddReview value, $Res Function(_$AddReview) then) =
      __$$AddReviewCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddReviewCopyWithImpl<$Res>
    extends _$TrainerDetailsEventCopyWithImpl<$Res, _$AddReview>
    implements _$$AddReviewCopyWith<$Res> {
  __$$AddReviewCopyWithImpl(
      _$AddReview _value, $Res Function(_$AddReview) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddReview implements AddReview {
  const _$AddReview();

  @override
  String toString() {
    return 'TrainerDetailsEvent.addReview()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddReview);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String trainerId) loadData,
    required TResult Function() addReview,
    required TResult Function(String trainerId) trainingRequest,
  }) {
    return addReview();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? loadData,
    TResult? Function()? addReview,
    TResult? Function(String trainerId)? trainingRequest,
  }) {
    return addReview?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? loadData,
    TResult Function()? addReview,
    TResult Function(String trainerId)? trainingRequest,
    required TResult orElse(),
  }) {
    if (addReview != null) {
      return addReview();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadData value) loadData,
    required TResult Function(AddReview value) addReview,
    required TResult Function(TrainingRequest value) trainingRequest,
  }) {
    return addReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(AddReview value)? addReview,
    TResult? Function(TrainingRequest value)? trainingRequest,
  }) {
    return addReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(AddReview value)? addReview,
    TResult Function(TrainingRequest value)? trainingRequest,
    required TResult orElse(),
  }) {
    if (addReview != null) {
      return addReview(this);
    }
    return orElse();
  }
}

abstract class AddReview implements TrainerDetailsEvent {
  const factory AddReview() = _$AddReview;
}

/// @nodoc
abstract class _$$TrainingRequestCopyWith<$Res> {
  factory _$$TrainingRequestCopyWith(
          _$TrainingRequest value, $Res Function(_$TrainingRequest) then) =
      __$$TrainingRequestCopyWithImpl<$Res>;
  @useResult
  $Res call({String trainerId});
}

/// @nodoc
class __$$TrainingRequestCopyWithImpl<$Res>
    extends _$TrainerDetailsEventCopyWithImpl<$Res, _$TrainingRequest>
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
    return 'TrainerDetailsEvent.trainingRequest(trainerId: $trainerId)';
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
    required TResult Function(String trainerId) loadData,
    required TResult Function() addReview,
    required TResult Function(String trainerId) trainingRequest,
  }) {
    return trainingRequest(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String trainerId)? loadData,
    TResult? Function()? addReview,
    TResult? Function(String trainerId)? trainingRequest,
  }) {
    return trainingRequest?.call(trainerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String trainerId)? loadData,
    TResult Function()? addReview,
    TResult Function(String trainerId)? trainingRequest,
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
    required TResult Function(LoadData value) loadData,
    required TResult Function(AddReview value) addReview,
    required TResult Function(TrainingRequest value) trainingRequest,
  }) {
    return trainingRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadData value)? loadData,
    TResult? Function(AddReview value)? addReview,
    TResult? Function(TrainingRequest value)? trainingRequest,
  }) {
    return trainingRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadData value)? loadData,
    TResult Function(AddReview value)? addReview,
    TResult Function(TrainingRequest value)? trainingRequest,
    required TResult orElse(),
  }) {
    if (trainingRequest != null) {
      return trainingRequest(this);
    }
    return orElse();
  }
}

abstract class TrainingRequest implements TrainerDetailsEvent {
  const factory TrainingRequest(final String trainerId) = _$TrainingRequest;

  String get trainerId;
  @JsonKey(ignore: true)
  _$$TrainingRequestCopyWith<_$TrainingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
