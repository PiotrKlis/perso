import 'package:perso/app/widgets/adress_and_map/event/address_and_map_event.dart';
import 'package:perso/app/widgets/adress_and_map/state/address_and_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressAndMapBloc extends Bloc<AddressAndMapEvent, AddressAndMapState> {
  AddressAndMapBloc() : super(const AddressAndMapState.initial()) {
    on<UpdateMap>((event, emit) async {
      emit(AddressAndMapState.mapUpdate(event.latLng));
    });
  }
}
