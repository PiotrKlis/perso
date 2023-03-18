import 'package:freezed_annotation/freezed_annotation.dart';
part 'empty_state.freezed.dart';

@freezed
class EmptyState with _$EmptyState {
  const factory EmptyState.initial() = Initial;
}
