import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/address_and_map/event/address_and_map_event.dart';
import 'package:perso/app/widgets/address_and_map/state/address_and_map_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/address_provider/google_address_provider.dart';

class AddressAndMapBloc extends Bloc<AddressAndMapEvent, AddressAndMapState> {
  AddressAndMapBloc() : super(const AddressAndMapState.initial()) {
    final addressProvider = getIt.get<GoogleAddressProvider>();
    on<UpdateMap>((event, emit) async {
      emit(AddressAndMapState.mapUpdate(event.latLng));
    });
    on<UpdateAddress>((event, emit) async {
      final address = await addressProvider.fetchAddress(event.latLng);
      emit(AddressAndMapState.addressUpdate(address));
    });
  }
}
