import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_chips_event.freezed.dart';

@freezed
class CategoryChipsEvent with _$CategoryChipsEvent {
  const factory CategoryChipsEvent.loadAllCategories() = LoadAllCategories;
}
