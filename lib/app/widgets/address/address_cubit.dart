import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/address_provider/google_address_provider.dart';

@injectable
class AddressCubit extends Cubit<String> {
  AddressCubit() : super('');
  // final mapCubit = getIt.get<MapCubit>();
  final addressProvider = getIt.get<GoogleAddressProvider>();

  void updateMap(String address) {
    // mapCubit.updateMap(address);
  }

  Future<void> updateAddress(LatLng latlng) async {
    final address = await addressProvider.fetchAddress(latlng);
    emit(address);
  }
}
