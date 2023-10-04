import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_chips_state.freezed.dart';

@freezed
class CategoryChipsState with _$CategoryChipsState {
  const factory CategoryChipsState.initial() = Initial;
  const factory CategoryChipsState.content(List<String> categories) = Content;
}
