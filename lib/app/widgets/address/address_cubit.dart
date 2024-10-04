import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/address_provider/google_address_provider.dart';

@injectable
class AddressCubit extends Cubit<List<String>> {
  AddressCubit() : super([]);
  final _mapCubit = getIt.get<MapCubit>();
  final _addressProvider = getIt.get<GoogleAddressProvider>();

  void updateMap(String address) {
    _mapCubit.updateMap(address);
  }

  Future<List<String>> fetchAddressSuggestions(String input) async {
    final suggestions = await _addressProvider.fetchAddressSuggestions(input);
    return suggestions;
  }
}
