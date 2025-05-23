import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/widgets/map/map_data.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = Initial;

  const factory MapState.mapUpdate(MapData mapData) = MapUpdate;
}
